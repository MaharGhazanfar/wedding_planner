import 'package:flutter/material.dart';

import '../repository/utils/data_constants.dart';

class CustomSplash extends StatelessWidget {
  const CustomSplash({super.key});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return  SizedBox(
        height: mq!.height,
        width: mq!.width,
        child: Image.asset('assets/images/Mayaring_splash.png'));
  }
}
