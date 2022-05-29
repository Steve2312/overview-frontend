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
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black.withOpacity(0.2),
          ),
        ),
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
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "${date.total}",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.white,
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
                        "Pending activities: ${date.remaining}",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        date.date,
                        style: Theme.of(context).textTheme.headline2!.copyWith(
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
    );
  }
}
