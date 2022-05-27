import 'package:flutter/material.dart';
import 'package:overview/screens/home.dart';
import 'package:overview/themes/light_theme.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      home: const Home(),
    );
  }
}
