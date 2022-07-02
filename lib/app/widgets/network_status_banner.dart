import 'package:flutter/material.dart';

class NetworkStatusBanner extends StatelessWidget {
  const NetworkStatusBanner({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 15,
      ),
      width: double.infinity,
      color: Theme.of(context).primaryColor.withOpacity(0.2),
      child: Text(
        message,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
