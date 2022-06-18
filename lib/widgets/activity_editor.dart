import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overview/providers/activities_provider.dart';
import 'package:overview/providers/date_provider.dart';
import 'package:overview/themes/dark_theme.dart';
import 'package:provider/provider.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import '../models/activity.dart';
import 'activity_editor_text_field.dart';

class ActivityEditor extends StatefulWidget {
  const ActivityEditor({Key? key, this.activity, this.googleShare})
      : super(key: key);

  final Activity? activity;
  final String? googleShare;

  @override
  State<ActivityEditor> createState() => _ActivityEditorState();
}

class _ActivityEditorState extends State<ActivityEditor> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _googleMapsURLController =
      TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.activity != null) {
      //  Patch Request
    }

    if (widget.googleShare != null) {
      LineSplitter lineSplitter = LineSplitter();
      List<String> lines = lineSplitter.convert(widget.googleShare!);

      _nameController.text = lines[0];
      _googleMapsURLController.text = lines[lines.length - 1];
    }
  }

  @override
  Widget build(BuildContext context) {
    ActivitiesProvider activitiesProvider =
        Provider.of<ActivitiesProvider>(context);

    void onSave() async {
      if (_nameController.text.isNotEmpty && _dateController.text.isNotEmpty) {
        Activity activity = Activity(
          0,
          _nameController.text,
          _descriptionController.text,
          false,
          _googleMapsURLController.text,
          _dateController.text,
        );
        await activitiesProvider.putActivity(activity).then(
          (value) {
            Navigator.pop(context);
            Provider.of<DateProvider>(context, listen: false).loadDates();
          },
        ).catchError((e) => print(e));
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
                  "Add activity",
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
                  "Name",
                  style: Theme.of(context).textTheme.subtitle1,
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
                  "Date",
                  style: Theme.of(context).textTheme.subtitle1,
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
                  onPressed: () {
                    onSave();
                  },
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
