import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:overview/activities/providers/activities_provider.dart';
import 'package:overview/activities/screens/activities.dart';
import 'package:overview/dates/screens/dates.dart';
import 'package:flutter/services.dart';
import 'package:overview/settings/screens/settings.dart';
import 'package:overview/shared/themes/dark_theme.dart';
import 'package:provider/provider.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import 'activities/screens/activity_editor.dart';
import 'dates/providers/date_provider.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: appBarBackgroundColor,
      ),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DateProvider()),
        ChangeNotifierProvider(create: (context) => ActivitiesProvider()),
      ],
      child: MaterialApp(
        theme: darkTheme,
        initialRoute: "home",
        routes: {
          "home": (context) => const Home(),
          "settings": (context) => const Settings(),
          "activities": (context) => const Activities(),
        },
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void openEditor(String googleShare) {
      Navigator.popUntil(context, (route) => route.isFirst);
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        enableDrag: false,
        isScrollControlled: true,
        isDismissible: false,
        context: context,
        builder: (context) {
          return ActivityEditor(
            googleShare: googleShare,
          );
        },
      );
    }

    ReceiveSharingIntent.getTextStream().listen((value) => openEditor(value));

    ReceiveSharingIntent.getInitialText().then((value) {
      if (value != null) {
        openEditor(value);
      }
    });

    return const Dates();
  }
}
