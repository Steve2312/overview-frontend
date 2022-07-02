import 'package:flutter/material.dart';
import 'package:overview_frontend/activities/services/activity_service.dart';

class ActivityAddButton extends StatelessWidget {
  const ActivityAddButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () => openEditor(context, null),
      child: const Icon(Icons.add),
    );
  }
}
