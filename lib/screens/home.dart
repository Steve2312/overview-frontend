import 'package:flutter/material.dart';
import 'package:overview/screens/settings.dart';

import '../widgets/activity_today.dart';
import '../widgets/app_header.dart';
import '../widgets/body_text_1.dart';
import '../widgets/date_card.dart';
import '../widgets/head_line_1.dart';

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
      backgroundColor: Theme.of(context).backgroundColor,
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
        children: const [
          HeadLine1(
            text: "Hi, Steve!",
          ),
          SizedBox(height: 15),
          BodyText1(
            text: "Let us make your activity planning for vacations feel easy!",
          ),
          SizedBox(height: 15),
          ActivityToday(),
          SizedBox(height: 50),
          HeadLine1(text: "Dates"),
          SizedBox(
            height: 15,
          ),
          BodyText1(
            text:
                "These are the dates where you have existing activities planned. More dates will appear based on the activities you plan!",
          ),
          SizedBox(height: 15),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
          DateCard(),
        ],
      ),
    );
  }
}
