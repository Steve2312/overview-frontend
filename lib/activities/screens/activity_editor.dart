import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overview/activities/providers/activities_provider.dart';
import 'package:provider/provider.dart';

import '../../dates/providers/date_provider.dart';
import '../../shared/themes/dark_theme.dart';
import '../models/activity.dart';
import '../widgets/activity_editor_text_field.dart';

class ActivityEditor extends StatefulWidget {
  const ActivityEditor({
    Key? key,
    this.activity,
    this.googleShare,
  }) : super(key: key);

  final Activity? activity;
  final String? googleShare;

  @override
  State<ActivityEditor> createState() => _ActivityEditorState();
}

class _ActivityEditorState extends State<ActivityEditor> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _googleMapsURLController = TextEditingController();
  final _dateController = TextEditingController();

  bool _showRequiredFields = false;

  @override
  void initState() {
    super.initState();

    if (widget.activity != null) {
      autoFillFromActivity(widget.activity!);
    }

    if (widget.googleShare != null) {
      autoFillFromGoogleShare(widget.googleShare!);
    }
  }

  void autoFillFromGoogleShare(String sharedValue) {
    var lineSplitter = const LineSplitter();
    var lines = lineSplitter.convert(sharedValue);

    _nameController.text = lines.first;
    _googleMapsURLController.text = lines.last;
  }

  void autoFillFromActivity(Activity activity) {
    _nameController.text = activity.name;
    _dateController.text = activity.date;

    if (activity.description != null) {
      _descriptionController.text = activity.description!;
    }

    if (activity.googleMapsUrl != null) {
      _googleMapsURLController.text = activity.googleMapsUrl!;
    }
  }

  @override
  Widget build(BuildContext context) {
    var activitiesProvider = Provider.of<ActivitiesProvider>(context);
    var dateProvider = Provider.of<DateProvider>(context);

    void saveOnTap() async {
      var name = _nameController.text;
      var description = _descriptionController.text;
      var googleMapsUrl = _googleMapsURLController.text;
      var date = _dateController.text;

      if (name.isNotEmpty && date.isNotEmpty) {
        var editMode = widget.activity != null;

        if (editMode) {
          Activity activity = Activity(widget.activity!.id, name, description,
              widget.activity!.finished, googleMapsUrl, date);
          activitiesProvider.patchActivity(activity).then((value) {
            Navigator.pop(context);
            dateProvider.loadDates();
            activitiesProvider.reloadActivities();
          });
        } else {
          Activity activity =
              Activity(0, name, description, false, googleMapsUrl, date);

          activitiesProvider.putActivity(activity).then((value) {
            Navigator.pop(context);
            dateProvider.loadDates();
            activitiesProvider.reloadActivities();
          });
        }
      }

      if (name.isEmpty || date.isEmpty) {
        setState(() {
          _showRequiredFields = true;
        });
      }
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.90,
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: Text(
                  widget.activity == null ? "Add activity" : "Edit activity",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: IconTheme(
                    data: Theme.of(context).iconTheme,
                    child: const Icon(Icons.close),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(30),
              children: [
                Text(
                  "Name * ",
                  style: _showRequiredFields && _nameController.text.isEmpty
                      ? Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: Colors.redAccent,
                          )
                      : Theme.of(context).textTheme.subtitle1,
                ),
                ActivityEditorTextField(
                  textEditingController: _nameController,
                  placeHolder: 'Example: Mount Fuji',
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Description",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                ActivityEditorTextField(
                  textEditingController: _descriptionController,
                  placeHolder: 'Example: 3776 meters high Japanese mountain',
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Google Maps URL",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                ActivityEditorTextField(
                  textEditingController: _googleMapsURLController,
                  placeHolder: 'Example: https://maps.app.goo.gl/',
                  textInputType: TextInputType.url,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Date * ",
                  style: _showRequiredFields && _dateController.text.isEmpty
                      ? Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: Colors.redAccent,
                          )
                      : Theme.of(context).textTheme.subtitle1,
                ),
                TextField(
                  controller: _dateController,
                  onTap: () async {
                    DateTime? selected = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: darkTheme,
                          child: child!,
                        );
                      },
                    );
                    if (selected != null) {
                      _dateController.text =
                          DateFormat('yyyy-MM-dd').format(selected);
                    }
                  },
                  readOnly: true,
                  style: Theme.of(context).inputDecorationTheme.labelStyle,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                    hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                    hintText: "Example: 10-11-2002",
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () => saveOnTap(),
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor),
                  child: Text(
                    "Save",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
