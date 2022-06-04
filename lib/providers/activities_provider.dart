import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

import '../models/activity.dart';

class ActivitiesProvider extends ChangeNotifier {
  List<Activity> activities = [];
  bool isFetching = false;

  void loadActivities(String date) {
    resetActivities();
    setIsFetching(true);
    fetchActivities(date).then((activities) {
      this.activities = activities;
      notifyListeners();
      setIsFetching(false);
    }).catchError((e) {
      setIsFetching(false);
    });
  }

  void resetActivities() {
    activities = [];
    notifyListeners();
  }

  void setIsFetching(bool fetching) {
    isFetching = fetching;
    notifyListeners();
  }

  Future fetchActivities(String date) async {
    Client client = Client();
    Uri url = Uri.parse("${dotenv.env["API_URL"]!}/activities?date=$date");
    Response response = await client.get(url);

    Map<String, dynamic> decodedResponse = jsonDecode(response.body);

    List<dynamic> decodedDates = decodedResponse["data"];
    return decodedDates.map((activity) => Activity.fromJson(activity)).toList();
  }

  void toggleFinished(Activity activity) {
    activity.finished = !activity.finished;
    notifyListeners();
  }
}
