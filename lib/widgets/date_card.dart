import 'package:flutter/material.dart';

import 'head_line_2.dart';
import 'sub_title_1.dart';

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
          Row(
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
                  "20",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SubTitle1(
                    text: "Friday 3 February 2022",
                  ),
                  HeadLine2(text: "2022-02-03"),
                ],
              ),
            ],
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
