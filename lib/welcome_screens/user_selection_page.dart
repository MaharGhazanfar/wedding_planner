import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedding_planner/authentication/screens/sign_up_page.dart';
import 'package:wedding_planner/repository/utils/custom_widgets.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';

import '../authentication/screens/login_page.dart';

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
      //   leading: Padding(
      //     padding: const EdgeInsets.only(left: 8.0),
      //     child: IconButton(
      //         icon: const Icon(
      //           Icons.arrow_back_ios,
      //           color: CustomColors.headingTextFontColor,
      //         ),
      //         onPressed: () async {
      //           // googleSignIn.disconnect().whenComplete(() async {
      //           //   await FirebaseAuth.instance.signOut();
      //           // });
      //           //
      //           //
      //           // Navigator.of(context).pop();
      //         }),
      //   ),
      //   backgroundColor: CustomColors.backGroundColor,
      // ),
      //backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image(
            image: const AssetImage('assets/images/login.jpg'),
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "I'm a... ",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                  child: CustomWidget.customContainer(
                      child: Text(
                        'Service Provider',
                        style: GoogleFonts.tinos(
                            textStyle: Theme.of(context).textTheme.bodyText1,
                            color: borderEnabled1
                                ? Colors.red
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
                        style: GoogleFonts.tinos(
                            textStyle: Theme.of(context).textTheme.bodyText1,
                            color: borderEnabled2
                                ? Colors.red
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
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: CustomWidget.customContainer(
                      child: Text(
                        'Employee',
                        style: GoogleFonts.tinos(
                            textStyle: Theme.of(context).textTheme.bodyText1,
                            color: borderEnabled3
                                ? Colors.red
                                : CustomColors.backGroundColor,
                            fontSize: 18),
                      ),
                      height: 50,
                      borderEnabled: borderEnabled3,
                      onTap: () {
                        setState(() {
                          borderEnabled1 = false;
                          borderEnabled2 = false;
                          borderEnabled3 = true;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  LoginPage(status: Strings.employee),
                            ));
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
