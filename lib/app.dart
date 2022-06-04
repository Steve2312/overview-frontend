import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:overview/providers/activities_provider.dart';
import 'package:overview/providers/date_provider.dart';
import 'package:overview/screens/activities.dart';
import 'package:overview/screens/home.dart';
import 'package:overview/screens/settings.dart';
import 'package:overview/themes/dark_theme.dart';
import 'package:overview/themes/light_theme.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
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
