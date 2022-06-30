import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:overview_frontend/activities/services/activity_service.dart';

import '../models/activity.dart';

class ActivityProvider extends ChangeNotifier {
  bool isFetching = false;
  SplayTreeMap<String, List<Activity>> activityMap =
      SplayTreeMap<String, List<Activity>>();

  ActivityProvider() {
    fetch();
  }

  Future<void> fetch() async {
    isFetching = true;
    notifyListeners();

    try {
      List<Activity> activities = await getActivities();
      activityMap = _mapActivitiesByDate(activities);
    } catch (error) {
      // Show toaster
    }

    isFetching = false;
    notifyListeners();
  }

  Future<void> create(Activity activity) async {
    Activity createdActivity = await putActivity(activity);
    // Update activity locally
    fetch();
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
}
