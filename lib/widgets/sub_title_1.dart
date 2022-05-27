import 'package:flutter/material.dart';

class SubTitle1 extends StatelessWidget {
  const SubTitle1({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.subtitle1,
    );
  }
}
