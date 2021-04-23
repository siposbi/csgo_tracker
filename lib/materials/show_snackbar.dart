import 'package:flutter/material.dart';

class ShowSnackBar {
  static show(
      {required BuildContext context,
      required String text,
      Color textColor = Colors.white,
      Color backgroundColor = Colors.green}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      backgroundColor: backgroundColor,
    ));
  }
}
