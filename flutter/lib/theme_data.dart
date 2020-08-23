import 'package:flutter/material.dart';

class AppThemeData {

  // Colors
  static const Color color_app_bg = Color(0x22309F8C);
  static const Color color_app = Color(0xff309F8C);
  static const Color color_app_alpha_10 = Color(0x11309F8C);
  static const Color color_app_alpha_50 = Color(0x88309F8C);
  static const Color color_page_bg = Color(0xfffafafa);
  static const Color tag_color_green = color_app;
  static const Color tag_color_green_bg = color_app_bg;


  // Font Styles
  static const TextStyle taskTagStyleGreen = TextStyle(
    color: tag_color_green,
    fontSize: 12,
    fontWeight: FontWeight.bold
  );

  static const TextStyle taskContentStyleGreen = TextStyle(
      fontSize: 16,
  );

  static const TextStyle bottomButtonContentStyleGreen = TextStyle(
    color: Colors.white,
    fontSize: 16,
  );

}