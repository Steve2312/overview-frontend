import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

import '../models/date.dart';

class DateProvider extends ChangeNotifier {
  List<Date> dates = [];
  bool isFetching = false;

  DateProvider() {
    loadDates();
  }

  void loadDates() {
    setIsFetching(true);
    fetchDates().then((dates) {
      this.dates = dates;
      notifyListeners();
      setIsFetching(false);
    }).catchError((e) {
      setIsFetching(false);
    });
  }

  void setIsFetching(bool fetching) {
    isFetching = fetching;
    notifyListeners();
  }

  Future fetchDates() async {
    Client client = Client();
    Uri url = Uri.parse("${dotenv.env["API_URL"]!}/activities/dates");
    Response response = await client.get(url);
    client.close();
    Map<String, dynamic> decodedResponse = jsonDecode(response.body);

    List<dynamic> decodedDates = decodedResponse["data"];
    return decodedDates.map((date) => Date.fromJson(date)).toList();
  }
}
