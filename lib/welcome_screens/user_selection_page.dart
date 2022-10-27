import 'package:flutter/material.dart';
import 'package:wedding_planner/authentication/screens/sign_up_page.dart';
import 'package:wedding_planner/repository/utils/custom_widgets.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';

class UserSelectionPage extends StatefulWidget {
  const UserSelectionPage({Key? key}) : super(key: key);

  @override
  State<UserSelectionPage> createState() => _GenderCheckPageState();
}

class _GenderCheckPageState extends State<UserSelectionPage> {
  // ModelPersonalInfo personalInfo= ModelPersonalInfo();
  // final googleSignIn = GoogleSignIn();
  bool borderEnabled1 = false;
  bool borderEnabled2 = false;
  bool borderEnabled3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   // leading: Padding(
      //   //   padding: const EdgeInsets.only(left: 8.0),
      //   //   child: IconButton(
      //   //       icon: const Icon(
      //   //         Icons.arrow_back_ios,
      //   //         color: CustomColors.headingTextFontColor,
      //   //       ),
      //   //       onPressed: () {
      //   //         Navigator.of(context).pop();
      //   //       }),
      //   // ),
      //   backgroundColor: CustomColors.appBarColor,
      // ),

      body: Stack(
        fit: StackFit.expand,
        children: [
          const Image(
            image: AssetImage('assets/images/front_page.png'),
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.only(
                //top: Pading.topPading,
                left: ScreenPading.leftPading,
                right: ScreenPading.rightPading),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Image.asset(
                    'assets/images/Mayaringbar_logo.png',
                  ),
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.4,
                //   child: Align(
                //     alignment: Alignment.centerLeft,
                //     child: Text(
                //       "I'm a... ",
                //       textAlign: TextAlign.start,
                //       style: TextStyle(
                //           fontSize: 30,
                //           fontWeight: FontWeight.bold,
                //           color: Colors.white),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                        child: CustomWidget.customContainer(
                            child: Text(
                              'Service Provider',
                              style: TextStyle(
                                  color: borderEnabled1
                                      ? CustomColors.backGroundColor
                                      : CustomColors.backGroundColor,
                                  fontSize: 18),
                            ),
                            height: 50,
                            borderEnabled: borderEnabled1,
                            onTap: () {
                              // showDialog(
                              //   context: context,
                              //   builder: (context) => TOdoDialog(),
                              // );
                              setState(() {
                                borderEnabled1 = true;
                                borderEnabled2 = false;
                                borderEnabled3 = false;
                              });
                              print('${Strings.serviceProvider}');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpPage(
                                      status: Strings.serviceProvider,
                                    ),
                                  ));
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                        child: CustomWidget.customContainer(
                            child: Text(
                              'Service User',
                              style: TextStyle(
                                  color: borderEnabled2
                                      ? CustomColors.backGroundColor
                                      : CustomColors.backGroundColor,
                                  fontSize: 18),
                            ),
                            height: 50,
                            borderEnabled: borderEnabled2,
                            onTap: () {
                              setState(() {
                                borderEnabled1 = false;
                                borderEnabled2 = true;
                                borderEnabled3 = false;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpPage(
                                      status: Strings.serviceUser,
                                    ),
                                  ));
                            }),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      //   child: CustomWidget.customContainer(
                      //       child: Text(
                      //         'Employee',
                      //         style: TextStyle(
                      //             color: borderEnabled3
                      //                 ? CustomColors.yellowIconsColor
                      //                 : CustomColors.backGroundColor,
                      //             fontSize: 18),
                      //       ),
                      //       height: 50,
                      //       borderEnabled: borderEnabled3,
                      //       onTap: () {
                      //         setState(() {
                      //           borderEnabled1 = false;
                      //           borderEnabled2 = false;
                      //           borderEnabled3 = true;
                      //         });
                      //         // Navigator.push(
                      //         //     context,
                      //         //     MaterialPageRoute(
                      //         //       builder: (context) =>
                      //         //           LoginPage(status: Strings.employee),
                      //         //     ));
                      //       }),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
