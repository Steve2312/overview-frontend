import 'package:flutter/material.dart';
import 'package:overview/providers/date_provider.dart';
import 'package:provider/provider.dart';

import '../models/date.dart';
import '../widgets/activity_today.dart';
import '../widgets/app_header.dart';
import '../widgets/date_card.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Date> dates = Provider.of<DateProvider>(context).dates;

    return Scaffold(
      appBar: AppHeader(
        title: Text(
          "Overview",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        icon: GestureDetector(
          onTap: () => Navigator.pushNamed(context, "settings"),
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
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dates.length,
            itemBuilder: (context, index) => DateCard(
              date: dates[index],
            ),
          )
        ],
      ),
    );
  }
}
