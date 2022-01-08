import 'package:flutter/material.dart';
import 'package:thundervolt/utils/sizeConfig.dart';

class Constant {
  static Color bgColor = Color(0xff151924);
  static Color tealColor = Color(0xff25E3B5);
  static Color lightbgColor = Color.fromRGBO(33, 247, 192, 0.14);
  static Color lightGrey = Color(0xff555B69);
  static Color cardGrey = Color(0xff555B69);
}

Widget sh(double height) {
  return SizedBox(
    height: SizeConfig.screenHeight! * height / 926,
  );
}

Widget sw(double width) {
  return SizedBox(
    height: SizeConfig.screenWidth! * width / 428,
  );
}
