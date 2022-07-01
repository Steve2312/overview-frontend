import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:overview_frontend/activities/providers/activity_provider.dart';
import 'package:overview_frontend/app/widgets/app_header.dart';
import 'package:provider/provider.dart';

import '../../app/widgets/loading_indicator.dart';
import '../models/activity.dart';
import '../widgets/activity_date_card.dart';

class ActivityDates extends StatelessWidget {
  const ActivityDates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ActivityProvider activityProvider = Provider.of<ActivityProvider>(context);
    SplayTreeMap<String, List<Activity>> activityMap =
        activityProvider.activityMap;
    bool isFetching = activityProvider.fetching;

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
                itemCount: activityMap.keys.length,
                itemBuilder: (context, index) {
                  String date = activityMap.keys.elementAt(index);
                  List<Activity> activities = activityMap[date]!;
                  int remaining = activities.where((activity) {
                    return !activity.finished;
                  }).length;

                  return ActivityDateCard(
                    date: activities.first.formattedDate,
                    total: activities.length,
                    remaining: remaining,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "activities",
                        arguments: {
                          'date': date,
                        },
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 15,
                ),
              ),
              if (isFetching) const LoadingIndicator(),
            ],
          ),
        ],
      ),
    );
  }
}
