import 'package:flutter/material.dart';
import 'package:wedding_planner/common_screens/package_details.dart';
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
        elevation: 1,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: CustomColors.backGroundColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        backgroundColor: CustomColors.buttonBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                // height: MediaQuery.of(context).size.height * 0.20,
                color: CustomColors.buttonBackgroundColor,
              ),
            ),
            // MyCustomCard.customCard(
            //   color: CustomColors.buttonBackgroundColor,
            //   height: 250.0,
            //   width: MediaQuery.of(context).size.width,
            //   child: Center(
            //     child: Text(
            //       'Awesome deals ready to\n delivered for you...',
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //           fontSize: 30,
            //           fontWeight: FontWeight.bold,
            //           color: CustomColors.backGroundColor),
            //     ),
            //   ),
            // ),

            Expanded(
              flex: 1,
              child: const Padding(
                padding: EdgeInsets.only(left: 16.0, top: 16, bottom: 16),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Provider Packages!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 6,
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return MyCustomCard.customCard(
                      height: MediaQuery.of(context).size.height * 0.30,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 4,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 2,
                              color: Colors.white,
                              child: Container(
                                height: MediaQuery.of(context).size.width * 0.6,
                                width: MediaQuery.of(context).size.width * 0.40,
                                decoration: BoxDecoration(
                                    //color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Icon(
                                  Icons.camera_alt,
                                  size: 100,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 6,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0, left: 6.0, right: 6.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Offer Name',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.textFontColor),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: const [
                                        Text(
                                          'Offer Price',
                                          style: TextStyle(
                                              // fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  CustomColors.textFontColor),
                                        ),
                                        Text(
                                          'Discount %',
                                          style: TextStyle(
                                              // fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  CustomColors.textFontColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      'Description',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: CustomColors.textFontColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ));
                },
              ),
            ),
            // MyCustomCard.customCard(
            //   height: 250.0,
            //   width: MediaQuery.of(context).size.width,
            //   child: const Align(
            //     alignment: Alignment.bottomCenter,
            //     child: Text(
            //       'Standard Peckage',
            //       textAlign: TextAlign.center,
            //       style:
            //           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: MyCustomCard.customCard(
            //     height: 250.0,
            //     width: MediaQuery.of(context).size.width,
            //     child: Align(
            //       alignment: Alignment.bottomCenter,
            //       child: Text(
            //         'Basic Peckage',
            //         textAlign: TextAlign.center,
            //         style: TextStyle(
            //             fontSize: 20, fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.buttonBackgroundColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PackageDetails(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
