import 'package:flutter/material.dart';

import '../models/date.dart';

class DateCard extends StatelessWidget {
  const DateCard({
    Key? key,
    required this.date,
  }) : super(key: key);

  final Date date;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "activities", arguments: date);
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
                      color: date.remaining == 0
                          ? Theme.of(context).primaryColor.withOpacity(0.2)
                          : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "${date.remaining}",
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
                          "Total activities: ${date.total}",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          date.formattedDate,
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
                ))
          ],
        ),
      ),
    );
  }
}
