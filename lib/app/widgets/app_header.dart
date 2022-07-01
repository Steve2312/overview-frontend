import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../activities/providers/activity_provider.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({Key? key, required this.title, this.icon, this.iconOnClick})
      : super(key: key);

  final Widget? title;
  final Widget? icon;
  final Function? iconOnClick;

  @override
  Widget build(BuildContext context) {
    ActivityProvider activityProvider = Provider.of<ActivityProvider>(context);

    bool backButtonVisible = Navigator.canPop(context) &&
        ModalRoute.of(context)!.settings.name != "home";

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (backButtonVisible)
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
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 30,
                              horizontal: backButtonVisible ? 0 : 30,
                            ),
                            child: title,
                          ),
                        ),
                      ],
                    ),
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
              if (!activityProvider.online)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  width: double.infinity,
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  child: Text(
                    "You are offline",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(200);
}
