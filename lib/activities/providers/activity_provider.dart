import 'dart:collection';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:overview_frontend/activities/services/activity_service.dart';

import '../models/activity.dart';

class ActivityProvider extends ChangeNotifier {
  var activityMap = SplayTreeMap<String, List<Activity>>();
  var fetching = false;
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

      List<Activity> activities = await getActivities();

      // compare local with get
      // post all activities with later last edited
      // save locally
      saveActivitiesToLocal(activities);
      // initialize map
      activityMap = _mapActivitiesByDate(activities);
    } finally {
      _setFetching(false);
    }
  }

  Future<void> loadActivitiesFromLocal() async {
    List<Activity> activities = await getActivitiesFromLocal();
    activityMap = _mapActivitiesByDate(activities);
  }

  Future<void> create(Activity activity) async {
    Activity createdActivity = await putActivity(activity);
    // Update activity locally
    synchronize();
  }

  Future<void> edit(Activity activity) async {
    updateActivityMap(activity);
    // Save Activity Map Locally
    try {
      // Try to save if online
      Activity updatedActivity = await patchActivity(activity);
    } catch (error) {
      // if offline show offline message
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

  void _setFetching(bool fetching) {
    this.fetching = fetching;
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
