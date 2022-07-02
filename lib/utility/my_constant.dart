import 'package:flutter/material.dart';

class MyConstant {
  //filed
  static Color dark = const Color.fromARGB(255, 14, 31, 72);
  static Color primary = const Color.fromARGB(255, 190, 126, 42);
  static Color light = const Color.fromARGB(255, 227, 225, 187);
  static Color active = const Color.fromARGB(255, 227, 27, 27);

  //method
  TextStyle h1Style() => TextStyle(
        fontSize: 36,
        color: dark,
        fontWeight: FontWeight.bold,
      );

  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        color: dark,
        fontWeight: FontWeight.w700,
      );

  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.normal,
      );

  TextStyle h3ActiveStyle() => TextStyle(
        fontSize: 16,
        color: active,
        fontWeight: FontWeight.w500,
      );
}
