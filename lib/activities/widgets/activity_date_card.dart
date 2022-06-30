import 'package:flutter/material.dart';

class ActivityDateCard extends StatelessWidget {
  const ActivityDateCard({
    Key? key,
    required this.date,
    required this.total,
    required this.remaining,
    this.onTap,
  }) : super(key: key);

  final String date;
  final int total;
  final int remaining;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).appBarTheme.shadowColor!,
              offset: const Offset(0, 0),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: remaining == 0
                          ? Theme.of(context).primaryColor.withOpacity(0.2)
                          : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "$remaining",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total activities: $total",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          date,
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    overflow: TextOverflow.ellipsis,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            IconTheme(
              data: Theme.of(context).iconTheme,
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
