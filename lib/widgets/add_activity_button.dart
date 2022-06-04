import 'package:flutter/material.dart';

class AddActivityButton extends StatelessWidget {
  const AddActivityButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {},
      icon: const Icon(Icons.add),
      label: const Text("Activity"),
    );
  }
}
