import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({Key? key, required this.title, this.icon, this.iconOnClick})
      : super(key: key);

  final Widget? title;
  final Widget? icon;
  final Function? iconOnClick;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).appBarTheme.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).appBarTheme.shadowColor!,
              offset: const Offset(0, 0),
              blurRadius: 1,
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (Navigator.canPop(context))
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: IconTheme(
                          data: Theme.of(context).iconTheme,
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: Navigator.canPop(context) ? 0 : 30,
                    ),
                    child: title,
                  ),
                ],
              ),
              if (icon != null)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (iconOnClick != null) {
                      iconOnClick!();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: icon,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(132);
}
