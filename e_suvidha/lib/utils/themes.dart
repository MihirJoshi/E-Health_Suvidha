import 'package:flutter/material.dart';

class MyThemes {
  static const bgcolor = const Color(0xff81d4fa);
  static const lightsky = Color(0xFFA6C0FF);
  static const whiteshade = Color(0xFFF8F9FA);
  static const blue = Color(0xFF497fff);
  static const lightblueshade = Color(0xFF758CC8);
  static const grayshade = Color(0xFFEBEBEB);
  static const lightblue = Color(0xFF4B68D1);
  static const blackshade = Color(0xFF555555);
  static const hintText = Color(0xFFC7C7CD);
  static const Color navbar = Color(0xFF2196f3);
}

class KTextStyle {
  static const headerTextStyle = TextStyle(
      color: MyThemes.whiteshade, fontSize: 28, fontWeight: FontWeight.w700);

  static const textFieldHeading =
      TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500);

  static const textFieldHintStyle = TextStyle(
      color: MyThemes.hintText, fontSize: 14, fontWeight: FontWeight.w500);

  static const authButtonTextStyle = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w600, color: MyThemes.whiteshade);
}
