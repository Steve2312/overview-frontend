import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:overview_frontend/activities/models/activity.dart';

Client _client = Client();
Map<String, String> _headers = {
  'Content-Type': 'application/json; charset=UTF-8',
};

Future<List<Activity>> getActivities() async {
  Uri url = Uri.parse("${dotenv.env["API_URL"]!}/activities");
  Response response = await _client.get(url);

  return _parseActivities(response.body);
}

Future<Activity> putActivity(Activity activity) async {
  Uri url = Uri.parse("${dotenv.env["API_URL"]!}/activities");
  Response response = await _client.put(
    url,
    headers: _headers,
    body: jsonEncode(activity),
  );

  return _parseActivity(response.body);
}

Future<Activity> patchActivity(Activity activity) async {
  Uri url = Uri.parse("${dotenv.env["API_URL"]!}/activities/${activity.id}");
  Response response = await _client.patch(
    url,
    headers: _headers,
    body: jsonEncode(activity),
  );

  return _parseActivity(response.body);
}

Future<void> deleteActivity(int id) async {
  Uri url = Uri.parse("${dotenv.env["API_URL"]!}/activities/$id");

  await _client.delete(url);
}

Activity _parseActivity(String responseBody) {
  Map<String, dynamic> activityJson = jsonDecode(responseBody);

  return Activity.fromJson(activityJson);
}

List<Activity> _parseActivities(String responseBody) {
  Map<String, dynamic> responseData = jsonDecode(responseBody);
  List<dynamic> activitiesJson = responseData["data"];

  return activitiesJson
      .map((activityJson) => Activity.fromJson(activityJson))
      .toList();
}
