// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'package:intl/intl.dart';
import 'package:shopping_home/components/button_widget.dart';
import 'package:shopping_home/controllers/sign_up_controller.dart';

class DatePickerWidget extends StatefulWidget {
  final String txt;
  final String? initdate;
  DateTime? inputdate;

  DatePickerWidget({
    Key? key,
    required this.txt,
    this.initdate,
    required this.inputdate,
  }) : super(key: key);

  @override
  DatePickerWidgetState createState() => DatePickerWidgetState();
}

class DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? date;
  String getText() {
    if (date == null) {
      return widget.initdate ?? '${'select'.tr}${widget.txt}';
    } else {
      return DateFormat('yyyy/MM/dd').format(date!);
    }
  }

  String getDisDate() {
    return getText();
  }

  @override
  Widget build(BuildContext context) => ButtonHeaderWidget(
        title: widget.txt,
        text: getText(),
        onClicked: () => pickDate(context),
      );

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime.now(),
    );

    if (newDate == null) return;

    setState(
      () => {
        date = newDate,
        widget.inputdate = newDate,
        SignUpController.birthdate = date,
      },
    );
  }
}
