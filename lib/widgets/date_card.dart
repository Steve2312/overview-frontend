import 'package:flutter/material.dart';

class DateCard extends StatelessWidget {
  const DateCard({
    Key? key,
  }) : super(key: key);

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
                    "43",
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
                        "Pending activities: 10",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        "Wednesday 31 November 2022",
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
