import 'dart:ui';

import 'package:flutter/material.dart';

class CustomColors {
  static const Color textFontColor = Colors.black54;
  static const Color headingTextFontColor = Colors.white;
  static const Color signupOptionColors = Colors.red;

  static const Color buttonTextFontColor = Colors.white;
  static const Color greenish = Color(0xFF48B7B1);
  static const Color buttonBackgroundColor = Color(0xFFFFC000);

  static Color backGroundColor = Colors.white;

  static const Color yellowIconsColor = Color(0xFFFFC000);

  static const Color appBarColor = Colors.transparent;
  static const Color blackText = Colors.black;
  static const Color outLineBorderColor2 = Colors.black;
  // static const Color clipperColor = Color(0xFFFD00D4);
  //static const Color frameColor = Colors.black12;
  //static const Color personIconColor = Colors.black26;

////////////////////////////////////////////////////////////////

}

class DataList {
  static final List<String> listImages = [
    'assets/images/signup1.jpg',
    'assets/images/signup3.jpg',
    'assets/images/signup4.jpg',
    'assets/images/signup2.jpg',
  ];
}
//////////////////////////////////////////////////////

class ButtonsStyle {
  static TextStyle buttonTextStyle(
    BuildContext context,
  ) {
    return TextStyle(
        fontSize: 20,
        color: CustomColors.buttonTextFontColor,
        fontWeight: FontWeight.bold);
  }
}

class Categories {
  static final categoriesList = [
    'cooker',
    'Flower',
    'beautification',
    'jeweler'
  ];

  static var categoryList = [
    'accessories',
    'Beauty',
    'ceremony',
    'accessories',
    'Beauty',
    'ceremony'
  ];
}

class Strings {
  static const String serviceProvider = 'ServiceProvider';
  static const String serviceUser = 'ServiceUser';
  static const String employee = 'Employee';
}

class ScreenPading {
  static const double topPading = 32;
  static const double leftPading = 16;
  static const double rightPading = 16;
  static const double bottomPading = 16;
}
