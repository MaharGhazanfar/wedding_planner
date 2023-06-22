import 'package:flutter/material.dart';

class MyCustomCard {
  static Widget customCard(
      {double height = double.infinity,
      double width = double.infinity,
      void Function()? onTap,
      Color? color,
      required Widget? child}) {
    return InkWell(
        onTap: onTap,
        child: SizedBox(
          height: height,
          width: width,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: color,
            elevation: 5,
            child: child,
          ),
        ));
  }
}
