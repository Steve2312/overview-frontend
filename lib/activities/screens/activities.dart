import 'package:flutter/material.dart';
import 'package:overview/activities/providers/activities_provider.dart';
import 'package:provider/provider.dart';

import '../../dates/models/date.dart';
import '../../shared/widgets/app_header.dart';
import '../../shared/widgets/loading_indicator.dart';
import '../widgets/activity_card.dart';
import '../models/activity.dart';
import '../widgets/add_activity_button.dart';

class Activities extends StatefulWidget {
  const Activities({Key? key}) : super(key: key);

  @override
  State<Activities> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Date date = ModalRoute.of(context)!.settings.arguments as Date;
      Provider.of<ActivitiesProvider>(context, listen: false)
          .loadActivities(date.date);
    });
  }

  @override
  Widget build(BuildContext context) {
    Date date = ModalRoute.of(context)!.settings.arguments as Date;

    ActivitiesProvider activitiesProvider =
        Provider.of<ActivitiesProvider>(context);

    List<Activity> activities = activitiesProvider.activities;
    bool isFetching = activitiesProvider.isFetching;

    int _getRemainingActivities() {
      if (activities.isNotEmpty) {
        return activities.where((activity) => !activity.finished).length;
      }

      return date.remaining;
    }

    int _getTotalActivities() {
      if (activities.isNotEmpty) {
        return activities.length;
      }

      return date.total;
    }

    return Scaffold(
      appBar: AppHeader(
        title: Column(
          mainAxisSize: MainAxisSize.min,
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
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "${_getRemainingActivities()} out of ${_getTotalActivities()} activities remaining",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
        icon: const Icon(Icons.more_vert_rounded),
      ),
      floatingActionButton: const AddActivityButton(),
      body: Stack(
        children: [
          ListView.separated(
            padding: const EdgeInsets.all(30),
            itemCount: activities.length,
            itemBuilder: (context, index) =>
                ActivityCard(activity: activities[index]),
            separatorBuilder: (context, index) => const SizedBox(
              height: 15,
            ),
          ),
          if (isFetching) const LoadingIndicator(),
        ],
      ),
    );
  }
}
