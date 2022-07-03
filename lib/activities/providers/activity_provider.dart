import 'dart:collection';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:overview_frontend/activities/services/activity_service.dart';

import '../models/activity.dart';

class ActivityProvider extends ChangeNotifier {
  var activityMap = SplayTreeMap<String, List<Activity>>();
  var fetching = false;
  var synchronizing = false;
  var online = false;

  ActivityProvider() {
    _checkOnline().then((online) {
      online ? synchronize() : loadActivitiesFromLocal();
      _setOnlineListener((bool online) {
        _setOnline(online);
        if (online) synchronize();
      });
    });
  }

  Future<void> synchronize() async {
    try {
      _setFetching(true);
      _setSynchronizing(true);

      List<Activity> activities = await getActivities();
      List<Activity> localActivities = await getActivitiesFromLocal();

      await patchLocalActivities(activities, localActivities);
      await putLocalActivities(localActivities);

      List<Activity> activitiesAfterSync = await getActivities();

      activityMap = _mapActivitiesByDate(activitiesAfterSync);
      saveActivitiesToLocal(activitiesAfterSync);
    } finally {
      _setFetching(false);
      _setSynchronizing(false);
    }
  }

  Future<void> patchLocalActivities(
    List<Activity> activities,
    List<Activity> localActivities,
  ) async {
    for (var activity in activities) {
      var index = localActivities.indexWhere((e) => e.id == activity.id);
      if (index != -1) {
        var localActivity = localActivities[index];
        var serverLastEdited = BigInt.parse(activity.lastEdited);
        var localLastEdited = BigInt.parse(localActivity.lastEdited);

        if (localLastEdited > serverLastEdited) {
          await patchActivity(localActivity);
        }
      }
    }
  }

  Future<void> putLocalActivities(List<Activity> localActivities) async {
    for (var activity in localActivities) {
      if (activity.id == null) {
        await putActivity(activity);
      }
    }
  }

  Future<void> loadActivitiesFromLocal() async {
    List<Activity> activities = await getActivitiesFromLocal();
    activityMap = _mapActivitiesByDate(activities);
    notifyListeners();
  }

  Future<void> create(Activity activity) async {
    try {
      Activity createdActivity = await putActivity(activity);
      addActivityToLocal(createdActivity);
      addActivityToMap(createdActivity);
    } catch (err) {
      activity.lastEdited = DateTime.now().millisecondsSinceEpoch.toString();
      addActivityToMap(activity);
    }
  }

  Future<void> edit(Activity activity) async {
    try {
      updateActivityMap(activity);

      Activity updatedActivity = await patchActivity(activity);

      editActivityInLocal(updatedActivity);
      updateActivityMap(updatedActivity);
    } catch (err) {
      activity.lastEdited = DateTime.now().millisecondsSinceEpoch.toString();
      editActivityInLocal(activity);
    }
  }

  Future<void> delete(Activity activity) async {
    try {
      deleteActivityFromMap(activity);
      await deleteActivity(activity.id!);
    } finally {
      deleteActivityInLocal(activity);
    }
  }

  SplayTreeMap<String, List<Activity>> _mapActivitiesByDate(
      List<Activity> activities) {
    SplayTreeMap<String, List<Activity>> map =
        SplayTreeMap<String, List<Activity>>();

    for (var activity in activities) {
      if (!map.containsKey(activity.date)) {
        map[activity.date] = [];
      }

      map[activity.date]!.add(activity);
    }

    return map;
  }

  void updateActivityMap(Activity activity) {
    List<Activity> activities = activityMap[activity.date]!;
    int index = activities.indexWhere((a) => a.id == activity.id);

    if (index != -1) {
      activities[index] = activity;
      notifyListeners();
    }
  }

  void addActivityToMap(Activity activity) {
    List<Activity>? activities = activityMap[activity.date];
    activities ??= [];

    activities.add(activity);
    activities.sort((a, b) => a.name.compareTo(b.name));

    activityMap[activity.date] = activities;

    notifyListeners();
  }

  void deleteActivityFromMap(Activity activity) {
    List<Activity> activities = activityMap[activity.date]!;
    int index = activities.indexWhere((a) => a.id == activity.id);
    if (index != -1) {
      activities.removeAt(index);
      notifyListeners();
    }
  }

  void _setFetching(bool fetching) {
    this.fetching = fetching;
    notifyListeners();
  }

  void _setSynchronizing(bool synchronizing) {
    this.synchronizing = synchronizing;
    notifyListeners();
  }

  void _setOnline(bool online) {
    this.online = online;
    notifyListeners();
  }

  Future<bool> _checkOnline() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  void _setOnlineListener(Function onChange) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      onChange(result != ConnectivityResult.none);
    });
  }
}
