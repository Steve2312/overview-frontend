import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overview_frontend/activities/providers/activity_provider.dart';
import 'package:overview_frontend/activities/screens/activity_dates.dart';
import 'package:overview_frontend/app/theme/dark_theme.dart';
import 'package:provider/provider.dart';

import '../../activities/screens/activities.dart';
import '../../settings/screens/settings.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: brightness,
        systemNavigationBarColor: appBarBackgroundColor,
      ),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ActivityProvider())
      ],
      child: MaterialApp(
        theme: darkTheme,
        initialRoute: 'home',
        routes: {
          "home": (context) => const ActivityDates(),
          "activities": (context) => const Activities(),
          "settings": (context) => const Settings(),
        },
      ),
    );
  }
}
