import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({Key? key, required this.title, this.icon}) : super(key: key);

  final String title;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.backgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (Navigator.canPop(context))
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: IconTheme(
                        data: Theme.of(context).iconTheme,
                        child: const Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                    ),
                  if (Navigator.canPop(context))
                    const SizedBox(
                      width: 15,
                    ),
                  Text(
                    title,
                    style: Theme.of(context).appBarTheme.titleTextStyle,
                  ),
                ],
              ),
              if (icon != null) icon!,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
