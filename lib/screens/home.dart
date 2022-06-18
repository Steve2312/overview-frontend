import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:overview/providers/date_provider.dart';
import 'package:overview/widgets/add_activity_button.dart';
import 'package:provider/provider.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import '../models/date.dart';
import '../widgets/activity_editor.dart';
import '../widgets/app_header.dart';
import '../widgets/date_card.dart';
import '../widgets/loading_indicator.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateProvider dateProvider = Provider.of<DateProvider>(context);
    List<Date> dates = dateProvider.dates;
    bool isFetching = dateProvider.isFetching;

    List<String> parseGoogleShare(String value) {
      LineSplitter ls = const LineSplitter();
      List<String> lines = ls.convert(value);
      return lines;
    }

    ReceiveSharingIntent.getTextStream().listen((String value) {
      Navigator.popUntil(context, (route) => route.isFirst);
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          enableDrag: false,
          isScrollControlled: true,
          isDismissible: false,
          context: context,
          builder: (context) {
            return ActivityEditor(
              googleShare: value,
            );
          });
    });

    return Scaffold(
      appBar: AppHeader(
        title: Text(
          "Overview",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        icon: IconTheme(
          data: Theme.of(context).appBarTheme.iconTheme!,
          child: const Icon(Icons.settings),
        ),
        iconOnClick: () => Navigator.pushNamed(context, "settings"),
      ),
      floatingActionButton: const AddActivityButton(),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 50,
        ),
        children: [
          Text(
            "My Activities",
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "These are the dates where you have existing activities planned. More dates will appear based on the activities you plan!",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 15),
          Stack(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dates.length,
                itemBuilder: (context, index) => DateCard(
                  date: dates[index],
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 15,
                ),
              ),
              if (isFetching) const LoadingIndicator(),
            ],
          )
        ],
      ),
    );
  }
}
