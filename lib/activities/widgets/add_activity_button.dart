import 'package:flutter/material.dart';

import '../screens/activity_editor.dart';

class AddActivityButton extends StatelessWidget {
  const AddActivityButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          enableDrag: false,
          isScrollControlled: true,
          isDismissible: false,
          context: context,
          builder: (context) {
            return const ActivityEditor();
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
