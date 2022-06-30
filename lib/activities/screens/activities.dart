import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/widgets/app_header.dart';
import '../../app/widgets/loading_indicator.dart';
import '../models/activity.dart';
import '../providers/activity_provider.dart';
import '../widgets/activity_card.dart';

class Activities extends StatelessWidget {
  const Activities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ActivityProvider activityProvider = Provider.of<ActivityProvider>(context);

    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    String date = arguments["date"];
    List<Activity> activities = activityProvider.activityMap[date]!;
    bool isFetching = activityProvider.isFetching;
    int remaining = activities.where((activity) => !activity.finished).length;

    return Scaffold(
      appBar: AppHeader(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              activities.first.formattedDate,
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
              "$remaining out of ${activities.length} activities remaining",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
        icon: const Icon(Icons.more_vert_rounded),
      ),
      body: Stack(
        children: [
          ListView.separated(
            padding: const EdgeInsets.all(30),
            itemCount: activities.length,
            itemBuilder: (context, index) => ActivityCard(
              activity: activities[index],
              googleMapsOnTap: () async {
                String? googleMapsUrl = activities[index].googleMapsUrl;
                if (googleMapsUrl != null) {
                  Uri url = Uri.parse(googleMapsUrl);
                  bool canLaunch = await canLaunchUrl(url);

                  if (canLaunch) {
                    launchUrl(url, mode: LaunchMode.externalApplication);
                  }
                }
              },
              editButtonOnTap: () => {},
              radioButtonOnTap: () {
                Activity activity = activities[index];
                activity.finished = !activity.finished;
                activityProvider.edit(activity);
              },
            ),
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
