import 'package:flutter/material.dart';
import 'package:overview/providers/activities_provider.dart';
import 'package:overview/widgets/app_header.dart';
import 'package:provider/provider.dart';

import '../models/activity.dart';
import '../models/date.dart';

class Activities extends StatelessWidget {
  const Activities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Date date = ModalRoute.of(context)!.settings.arguments as Date;

    List<Activity> activities =
        Provider.of<ActivitiesProvider>(context).activities;

    Provider.of<ActivitiesProvider>(context, listen: false)
        .loadActivities(date.date);

    return Scaffold(
      appBar: AppHeader(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date.formattedDate,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Activities",
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "${date.remaining} out of ${date.total} activities remaining",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(30),
        itemCount: activities.length,
        itemBuilder: (context, index) => Text(
          activities[index].name,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}
