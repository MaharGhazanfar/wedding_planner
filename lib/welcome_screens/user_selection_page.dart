import 'package:flutter/material.dart';
import 'package:wedding_planner/authentication/screens/sign_up_page.dart';
import 'package:wedding_planner/repository/utils/custom_widgets.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import '../authentication/screens/login_page.dart';
import '../modelClasses/model_personal_login_info.dart';

class UserSelectionPage extends StatefulWidget {
  const UserSelectionPage({Key? key}) : super(key: key);

  @override
  State<UserSelectionPage> createState() => _GenderCheckPageState();
}

class _GenderCheckPageState extends State<UserSelectionPage> {
  bool borderEnabled1 = false;
  bool borderEnabled2 = false;
  bool borderEnabled3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Image(
            image: AssetImage('assets/images/front_page.png'),
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: ScreenPading.leftPading, right: ScreenPading.rightPading),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Image.asset(
                    'assets/images/Mayaringbar_logo.png',
                  ),
                ),
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
                              showSheet(context: context);

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
                              ModelPersonalLoginInfo.prefs!
                                  .setString(Strings.servicePref, Strings.serviceUser);
                              setState(() {
                                borderEnabled1 = false;
                                borderEnabled2 = true;
                                borderEnabled3 = false;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpPage(
                                      status: Strings.serviceUser,
                                    ),
                                  ));
                            }),
                      ),
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

void showSheet({required BuildContext context}) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => SizedBox(
      height: 160,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Padding(
          padding:  const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(CustomColors.buttonBackgroundColor)),
                    onPressed: () {
                      ModelPersonalLoginInfo.prefs!.setString(
                          Strings.servicePref, Strings.serviceProvider);
                       Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(
                              status: Strings.serviceProvider,
                            ),
                          ));

                    }, child: const Text('Continue As Service Provider')),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(CustomColors.buttonBackgroundColor)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                LoginPage(status: Strings.employee),
                          ));
                    }, child: const Text('Continue As Employee')),
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(CustomColors.buttonBackgroundColor)),
                      onPressed: () {
                    Navigator.pop(context);
                  }, child: const Text('Cancel'))),
            ],
          ),
        ),
      ),
    ),
  );
}
