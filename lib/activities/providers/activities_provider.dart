import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

import '../models/activity.dart';

class ActivitiesProvider extends ChangeNotifier {
  List<Activity> activities = [];
  late String date;
  bool isFetching = false;

  void loadActivities(String date) {
    resetActivities();
    setIsFetching(true);
    this.date = date;
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
    client.close();

    Map<String, dynamic> decodedResponse = jsonDecode(response.body);

    List<dynamic> decodedDates = decodedResponse["data"];
    return decodedDates.map((activity) => Activity.fromJson(activity)).toList();
  }

  Future toggleFinished(Activity activity) async {
    activity.finished = !activity.finished;
    notifyListeners();

    await patchActivity(activity);
  }

  Future putActivity(Activity activity) async {
    Client client = Client();
    Uri url = Uri.parse("${dotenv.env["API_URL"]!}/activities");
    Response response = await client.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(activity),
    );
    client.close();
  }

  Future patchActivity(Activity activity) async {
    Client client = Client();
    Uri url = Uri.parse("${dotenv.env["API_URL"]!}/activities/${activity.id}");
    Response response = await client.patch(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(activity),
    );
    client.close();
  }

  void updateRemainingCount() {}
}
