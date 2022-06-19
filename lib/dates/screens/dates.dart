import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import '../../activities/screens/activity_editor.dart';
import '../../activities/widgets/add_activity_button.dart';
import '../../shared/widgets/app_header.dart';
import '../../shared/widgets/loading_indicator.dart';
import '../models/date.dart';
import '../providers/date_provider.dart';
import '../widgets/date_card.dart';

class Dates extends StatelessWidget {
  const Dates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateProvider dateProvider = Provider.of<DateProvider>(context);
    List<Date> dates = dateProvider.dates;
    bool isFetching = dateProvider.isFetching;

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
