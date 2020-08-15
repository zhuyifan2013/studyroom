import 'package:flutter/material.dart';

class UIUtils {
  static void showSimpleSnackBar(BuildContext context, String text, {Duration duration = const Duration(seconds: 2)}) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text), duration: duration,));
  }
}