import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

import '../models/date.dart';

class DateProvider extends ChangeNotifier {
  List<Date> dates = [];

  DateProvider() {
    fetchDates().then((dates) {
      this.dates = dates;
    });
  }

  Future fetchDates() async {
    Client client = Client();
    Uri url = Uri.parse("${dotenv.env["API_URL"]!}/activities/dates");
    Response response = await client.get(url);

    Map<String, dynamic> decodedResponse = jsonDecode(response.body);

    List<dynamic> decodedDates = decodedResponse["data"];
    return decodedDates.map((date) => Date.fromJson(date)).toList();
  }
}
