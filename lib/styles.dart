import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class Styles {
  static const TextStyle productRowItemName = TextStyle(
    //color: Color.fromRGBO(0, 0, 0, 0.8),
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const CupertinoThemeData DayTheme =
      CupertinoThemeData(brightness: Brightness.light);

  static const CupertinoThemeData NightTheme =
      CupertinoThemeData(brightness: Brightness.dark);

  static const TextStyle productRowTotal = TextStyle(
    //  color: Color.fromRGBO(0, 0, 0, 0.8),
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle productRowItemPrice = TextStyle(
    //  color: Color(0xFF8E8E93),
    fontSize: 13,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle searchText = TextStyle(
    //  color: Color.fromRGBO(0, 0, 0, 1),
    fontSize: 14,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle deliveryTimeLabel = TextStyle(
    //   color: Color(0xFFC2C2C2),
    fontWeight: FontWeight.w300,
  );

  static const TextStyle deliveryTime = TextStyle(
    color: CupertinoColors.inactiveGray,
  );



  static const BoxShadow cardShadow =   BoxShadow(
      offset: Offset(0, 0),
      color: Colors.black54,
      blurRadius: 4.0);



  static const BorderRadius cardBorderRadius = BorderRadius.all(Radius.circular(4));

  static const Color productRowDivider = Color(0xFFD9D9D9);

  static const Color scaffoldBackground = Color(0xfff0f0f0);

  static const Color searchBackground = Color(0xffe0e0e0);

  static const Color searchCursorColor = Color.fromRGBO(0, 122, 255, 1);

  static const Color searchIconColor = Color.fromRGBO(128, 128, 128, 1);

  static Color randomColor(){

    var colors = [Colors.red,Colors.orange,Colors.purple,Colors.blue,Colors.green,];
    var random = new Random();
    return colors[random.nextInt(5)];

  }
}
