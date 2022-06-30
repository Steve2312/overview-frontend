import 'package:flutter/material.dart';

import '../models/activity.dart';

class ActivityCard extends StatefulWidget {
  const ActivityCard({
    Key? key,
    required this.activity,
    required this.radioButtonOnTap,
    required this.googleMapsOnTap,
    required this.editButtonOnTap,
  }) : super(key: key);

  final Activity activity;
  final Function radioButtonOnTap;
  final Function googleMapsOnTap;
  final Function editButtonOnTap;

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  bool isExpanded = false;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Expand widget if widget is not finished
    if (!widget.activity.finished) {
      _controller.value = _controller.upperBound;
      isExpanded = true;
    }
  }

  void _toggleContainer() {
    if (_animation.status != AnimationStatus.completed) {
      _controller.forward();
      setState(() {
        isExpanded = true;
      });
    } else {
      _controller.animateBack(0, duration: const Duration(milliseconds: 200));
      setState(() {
        isExpanded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.activity.finished ? 0.6 : 1,
      duration: const Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
      child: Container(
        alignment: Alignment.topCenter,
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
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (!widget.activity.finished && isExpanded) {
                      _toggleContainer();
                    }
                    widget.radioButtonOnTap();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      bottom: 15,
                      left: 15,
                      right: 5,
                    ),
                    child: Icon(
                      widget.activity.finished
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      _toggleContainer();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 15,
                        bottom: 15,
                        left: 5,
                        right: 15,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.activity.name,
                              overflow: TextOverflow.visible,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  ?.copyWith(
                                    decoration: widget.activity.finished
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          RotationTransition(
                            turns: _animation,
                            child: Icon(
                              isExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizeTransition(
              sizeFactor: _animation,
              axis: Axis.vertical,
              child: FadeTransition(
                opacity: _animation,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 0,
                    bottom: 15,
                    left: 15,
                    right: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.activity.description != null &&
                          widget.activity.description != "")
                        Text(
                          widget.activity.description!,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      if (widget.activity.description != null &&
                          widget.activity.description != "")
                        const SizedBox(
                          height: 15,
                        ),
                      Wrap(
                        spacing: 15,
                        children: [
                          if (widget.activity.googleMapsUrl != null &&
                              widget.activity.googleMapsUrl != "")
                            OutlinedButton.icon(
                              onPressed: () {
                                widget.googleMapsOnTap();
                              },
                              style:
                                  Theme.of(context).outlinedButtonTheme.style,
                              icon: const Icon(
                                Icons.location_on,
                                size: 20,
                              ),
                              label: const Text("Google Maps"),
                            ),
                          OutlinedButton.icon(
                            onPressed: () {
                              widget.editButtonOnTap();
                            },
                            style: Theme.of(context).outlinedButtonTheme.style,
                            icon: const Icon(
                              Icons.edit,
                              size: 20,
                            ),
                            label: const Text("Edit"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
