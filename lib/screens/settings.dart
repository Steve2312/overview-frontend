import 'package:flutter/material.dart';

import '../widgets/app_header.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppHeader(
        title: 'Settings',
      ),
    );
  }
}
