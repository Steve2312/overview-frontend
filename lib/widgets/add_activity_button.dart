import 'package:flutter/material.dart';
import 'package:overview/widgets/activity_editor.dart';

class AddActivityButton extends StatelessWidget {
  const AddActivityButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
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
            });
      },
      icon: const Icon(Icons.add),
      label: const Text("Activity"),
    );
  }
}
