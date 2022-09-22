import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: CustomColors.headingTextFontColor,
              ),
              onPressed: () async {
                // googleSignIn.disconnect().whenComplete(() async {
                //   await FirebaseAuth.instance.signOut();
                // });
                //
                //
                // Navigator.of(context).pop();
              }),
        ),
        backgroundColor: CustomColors.backGroundColor,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "I'm a... ",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                // CustomWidget.dropdownButton4(
                //     items: DataLists.sports,
                //     onChanged: (value) {},
                //     selectedValues: [],
                //     titleName: 'Sports'),
                const SizedBox(
                  height: 150,
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
                                : CustomColors.textFontColor,
                            fontSize: 18),
                      ),
                      height: 50,
                      borderEnabled: borderEnabled1,
                      onTap: () {
                        setState(() {
                          borderEnabled1 = true;
                          borderEnabled2 = false;
                          borderEnabled3 = false;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
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
                                : CustomColors.textFontColor,
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
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const UserAgePage(),
                        //     ));
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
                                : CustomColors.textFontColor,
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
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const UserAgePage(),
                        //     ));
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
