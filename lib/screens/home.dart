import 'package:flutter/material.dart';
import 'package:overview/screens/settings.dart';

import '../widgets/activity_today.dart';
import '../widgets/app_header.dart';
import '../widgets/date_card.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  void navigateToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Settings(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        title: "Overview",
        icon: GestureDetector(
          onTap: () => navigateToSettings(context),
          child: IconTheme(
            data: Theme.of(context).appBarTheme.iconTheme!,
            child: const Icon(Icons.settings),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 50,
        ),
        children: [
          Text(
            "Hi, Steve!",
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(height: 15),
          Text(
            "Let us make your activity planning for vacations feel easy!",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 15),
          const ActivityToday(),
          const SizedBox(height: 50),
          Text(
            "Dates",
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
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
          const DateCard(),
        ],
      ),
    );
  }
}
