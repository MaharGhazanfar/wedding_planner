import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomColors {
  static const Color textFontColor = Colors.black54;
  static const Color headingTextFontColor = Colors.black;
  static const Color signupOptionColors = Colors.red;

  static const Color buttonTextFontColor = Colors.white;
  static const Color buttonBackgroundColor = Color(0xFF4baa97);

  static  Color backGroundColor = Colors.white;

  static const Color iconsColor = Colors.black54;
  static const Color appBarColor = Colors.transparent;
  static const Color outLineBorderColor = Colors.black;
  static const Color outLineBorderColor2 = Colors.black;
 // static const Color clipperColor = Color(0xFFFD00D4);
  //static const Color frameColor = Colors.black12;
  //static const Color personIconColor = Colors.black26;

////////////////////////////////////////////////////////////////

}

class DataList{
  static final List<String> listImages = [
    'assets/images/signup1.jpg',
    'assets/images/signup3.jpg',
    'assets/images/signup4.jpg',
    'assets/images/signup2.jpg',


  ];
}
//////////////////////////////////////////////////////

class ButtonsStyle{
  static TextStyle buttonTextStyle(
      BuildContext context,
      ) {
    return GoogleFonts.tinos(
        textStyle: Theme.of(context).textTheme.headline6,
        color: CustomColors.buttonTextFontColor,
        fontWeight: FontWeight.bold);
  }

}