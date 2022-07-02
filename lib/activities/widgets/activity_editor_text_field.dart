import 'package:flutter/material.dart';

class ActivityEditorTextField extends StatelessWidget {
  const ActivityEditorTextField({
    Key? key,
    this.textEditingController,
    required this.placeHolder,
    required this.textInputType,
  }) : super(key: key);

  final TextEditingController? textEditingController;
  final String placeHolder;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      maxLines: null,
      controller: textEditingController,
      style: Theme.of(context).inputDecorationTheme.labelStyle,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
        hintText: placeHolder,
        hintMaxLines: 1,
      ),
    );
  }
}
