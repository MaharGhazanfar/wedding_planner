import 'package:flutter/material.dart';
import 'package:wedding_planner/authentication/screens/sign_up_page.dart';
import 'package:wedding_planner/repository/utils/custom_widgets.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import '../authentication/screens/login_page.dart';
import '../modelClasses/model_personal_login_info.dart';

class UserSelectionPage extends StatefulWidget {
  const UserSelectionPage({Key? key}) : super(key: key);
  static const pageName = '/UserSelectionPage';

  @override
  State<UserSelectionPage> createState() => _GenderCheckPageState();
}

class _GenderCheckPageState extends State<UserSelectionPage> {


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
                left: ScreenPadding.leftPadding,
                right: ScreenPadding.rightPadding),
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
                              Strings.serviceProvider,
                              style: TextStyle(
                                  color: 
                                      CustomColors.backGroundColor,
                                      
                                  fontSize: 18),
                            ),
                            height: 50,
                           
                            onTap: () {
                              // showSheet(context: context);
                              showUserDialogue(context: context);
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                        child: CustomWidget.customContainer(
                            child: Text(
                              Strings.serviceUser,
                              style: TextStyle(
                                  color: 
                                       CustomColors.backGroundColor,
                                  fontSize: 18),
                            ),
                            height: 50,
                            
                            onTap: () {
                              ModelPersonalLoginInfo.prefs!.setString(
                                  Strings.servicePref, Strings.serviceUser);
                             

                              Navigator.pushNamed(context, SignUpPage.pageName,
                                  arguments: {
                                    Strings.status: Strings.serviceUser,
                                  });
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

void showUserDialogue({required BuildContext context}) {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
        backgroundColor: CustomColors.greenish,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: const EdgeInsets.all(12),
        children: [
          CustomWidget.customContainer(
              child: Text(
                Strings.continueAs + Strings.serviceProvider,
                style: TextStyle(
                    color: CustomColors.backGroundColor, fontSize: 18),
              ),
              height: mq!.height * 0.06,
              onTap: () {
                ModelPersonalLoginInfo.prefs!
                    .setString(Strings.status, Strings.serviceProvider);
                Navigator.pop(context);
                Navigator.pushNamed(context, SignUpPage.pageName,
                    arguments: {
                      Strings.status: Strings.serviceProvider
                    });
              }),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: CustomWidget.customContainer(
                child: Text(
                  Strings.continueAs + Strings.employee,
                  style: TextStyle(
                      color: CustomColors.backGroundColor, fontSize: 18),
                ),
                height: mq!.height * 0.06,
                onTap: () {
                  Navigator.pushNamed(context, LoginPage.pageName,
                      arguments: {
                        Strings.status: Strings.employee
                      });
                }),
          ),
          CustomWidget.customContainer(
              child: Text(
                Strings.cancel,
                style: TextStyle(
                    color: CustomColors.backGroundColor, fontSize: 18),
              ),
              height: mq!.height * 0.06,
              onTap: () {
                Navigator.pop(context);
              }),
        ]),
  );
}
