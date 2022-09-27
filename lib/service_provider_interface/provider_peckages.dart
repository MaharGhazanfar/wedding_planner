import 'package:flutter/material.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import 'package:wedding_planner/repository/utils/my_custom_card.dart';

class ProviderPackages extends StatefulWidget {
  const ProviderPackages({Key? key}) : super(key: key);

  @override
  State<ProviderPackages> createState() => _ProviderPackagesState();
}

class _ProviderPackagesState extends State<ProviderPackages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: CustomColors.headingTextFontColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        backgroundColor: CustomColors.appBarColor,
      ),
      body: Center(
        child: ListView(
          children: [
            SizedBox(
              // width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  MyCustomCard.customCard(
                    color: CustomColors.buttonBackgroundColor,
                    height: 250.0,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: Text(
                        'Aweasom deals ready to\ndeliverd for you...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  MyCustomCard.customCard(
                    height: 250.0,
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Premium Peckage',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  MyCustomCard.customCard(
                    height: 250.0,
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Standard Peckage',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: MyCustomCard.customCard(
                      height: 250.0,
                      width: MediaQuery.of(context).size.width,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Basic Peckage',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
