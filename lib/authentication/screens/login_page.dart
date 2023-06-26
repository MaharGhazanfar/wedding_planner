import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wedding_planner/authentication/authentication_services.dart';
import 'package:wedding_planner/authentication/screens/phone_login_page.dart';
import 'package:wedding_planner/authentication/screens/sign_up_page.dart';
import 'package:wedding_planner/modelClasses/employee_info.dart';
import 'package:wedding_planner/repository/utils/custom_widgets.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import 'package:wedding_planner/service_provider_interface/service_provider_dashboard.dart';
import '../../modelClasses/model_personal_login_info.dart';
import '../../repository/utils/db_handler.dart';
import '../../user_interface/bottom_navigationBar_screen.dart';

class LoginPage extends StatefulWidget {
  final String status;

  const LoginPage({Key? key, required this.status}) : super(key: key);
  static const pageName = '/LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var globalKey = GlobalKey<FormFieldState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Image(
            image: AssetImage('assets/images/signup.png'),
            fit: BoxFit.fill,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: globalKey,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: ScreenPadding.topPadding,
                    right: ScreenPadding.topPadding),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Image.asset(
                        'assets/images/Mayaringbar_logo.png',
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: CustomWidget.customTextField3(
                                controller: _emailController,
                                titleName: 'Email',
                                context: context),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                              ),
                              child: CustomWidget.customTextField3(
                                  controller: _passwordController,
                                  suffix: const Padding(
                                    padding: EdgeInsets.only(right: 16.0),
                                    child: Text(
                                      'Hide',
                                      style: TextStyle(
                                          color: CustomColors
                                              .buttonBackgroundColor,
                                          fontSize: 18),
                                    ),
                                  ),
                                  titleName: 'Password',
                                  obscureText: true,
                                  context: context)),
                          Container(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                    color: CustomColors.buttonTextFontColor,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                          widget.status != Strings.employee
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: FutureBuilder(
                                    future: FirebaseFirestore.instance
                                        .collection(Strings.serviceProvider ==
                                                widget.status
                                            ? Strings.serviceProvider
                                            : Strings.serviceUser)
                                        .where(ModelPersonalLoginInfo.emailKey,
                                            isEqualTo: _emailController.text
                                                .toString())
                                        .get(),
                                    builder: (context, snapshot) {
                                      
                                      if (snapshot.hasData) {
                                        return InkWell(
                                          onTap: () async {

                                            if (_emailController.text
                                                    .toString()
                                                    .isNotEmpty &&
                                                _passwordController.text
                                                    .toString()
                                                    .isNotEmpty) {
                                              if (_emailController.text
                                                  .toString()
                                                  .trim()
                                                  .contains('@gmail.com')) {
                                                // if (snapshot
                                                //     .data!.docs.isEmpty) {
                                                //   showCustomToast(
                                                //       msg:
                                                //           'Please Fill Correct Information');
                                                //} else {
                                                  String status =
                                                      await signInWithEmail(
                                                          password:
                                                              _passwordController
                                                                  .text
                                                                  .toString(),
                                                          email:
                                                              _emailController
                                                                  .text
                                                                  .toString()
                                                                  .trim());
                                                  if (status ==
                                                      'Login Successful') {
                                                    //print('///user/////${FirebaseAuth.instance.currentUser}');
                                                   // print('///uid/////${DBHandler.user!.uid}');
                                                    showCustomToast(
                                                        msg: status);
                                                    if (widget.status ==
                                                        Strings
                                                            .serviceProvider) {
                                                               ModelPersonalLoginInfo.prefs!
                                                      .setString(
                                                          Strings.status , widget.status);
                                                      Navigator
                                                          .pushNamedAndRemoveUntil(
                                                              context,
                                                              ServiceProviderDashBoard
                                                                  .pageName,
                                                              arguments: {
                                                                Strings.status:
                                                                    widget
                                                                        .status
                                                              },
                                                              (route) => false);
                                                    } else if (widget.status ==
                                                        Strings.serviceUser) {
                                                           ModelPersonalLoginInfo.prefs!
                                                      .setString(
                                                          Strings.status , widget.status);
                                                      Navigator
                                                          .pushNamedAndRemoveUntil(
                                                              context,
                                                              BottomNavigationBarForUser
                                                                  .pageName,
                                                              arguments: {
                                                                Strings.status:
                                                                    widget
                                                                        .status
                                                              },
                                                              (route) => false);
                                                    }
                                                  } else {
                                                    showCustomToast(
                                                        msg: status);
                                                  }
                                               // }
                                              } else {
                                                showCustomToast(
                                                    msg: 'inValid Email');
                                              }
                                            } else {
                                              showCustomToast(
                                                  msg: 'Field Must BE Filled');
                                            }
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: CustomColors
                                                      .buttonBackgroundColor,
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.09),
                                                      offset: const Offset(
                                                        0.1,
                                                        1.5,
                                                      ),
                                                    ),
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.09),
                                                      offset: const Offset(
                                                        -0.1,
                                                        -0.001,
                                                      ),
                                                      spreadRadius: -1,
                                                    ),
                                                  ]),
                                              child: const Text(
                                                'Login',
                                                style: TextStyle(
                                                    color: CustomColors
                                                        .buttonTextFontColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              )),
                                        );
                                      } else {
                                        return const SizedBox();
                                      }
                                    },
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: FutureBuilder(
                                    future: FirebaseFirestore.instance
                                        .collection(Strings.employee)
                                        .where(ModelEmployeeInfo.emailKey,
                                            isEqualTo: _emailController.text
                                                .toString())
                                        .where(ModelEmployeeInfo.passwordKey,
                                            isEqualTo: _passwordController.text
                                                .toString())
                                        .get(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return InkWell(
                                          onTap: () {
                                            if (_emailController.text
                                                    .toString()
                                                    .isNotEmpty &&
                                                _passwordController.text
                                                    .toString()
                                                    .isNotEmpty) {
                                              if (_emailController.text
                                                  .toString()
                                                  .contains('@gmail.com')) {
                                                if (snapshot
                                                    .data!.docs.isEmpty) {
                                                  showCustomToast(
                                                      msg:
                                                          'Please Fill Correct Information');
                                                } else {
                                                  ModelPersonalLoginInfo.prefs!
                                                      .setString(
                                                          Strings.UIDPref,
                                                          snapshot.data!.docs[0]
                                                              [ModelEmployeeInfo
                                                                  .UIDKey]);
                                                  ModelPersonalLoginInfo.prefs!
                                                      .setString(
                                                          Strings.EIDPref,
                                                          snapshot.data!.docs[0]
                                                              .id);

                                                  var employeeInfo =
                                                      ModelEmployeeInfo(
                                                    business: snapshot
                                                        .data!
                                                        .docs[0][
                                                            ModelEmployeeInfo
                                                                .businessKey]
                                                        .toString(),
                                                    firstName:
                                                        snapshot.data!.docs[0][
                                                            ModelEmployeeInfo
                                                                .firstNameKey],
                                                    lastName:
                                                        snapshot.data!.docs[0]
                                                            [ModelEmployeeInfo
                                                                .lastNameKey],
                                                    number:
                                                        snapshot.data!.docs[0][
                                                            ModelEmployeeInfo
                                                                .numberKey],
                                                    email:
                                                        snapshot.data!.docs[0][
                                                            ModelEmployeeInfo
                                                                .emailKey],
                                                    address:
                                                        snapshot.data!.docs[0][
                                                            ModelEmployeeInfo
                                                                .addressKey],
                                                    password:
                                                        snapshot.data!.docs[0]
                                                            [ModelEmployeeInfo
                                                                .passwordKey],
                                                    UID: snapshot.data!.docs[0][
                                                        ModelEmployeeInfo
                                                            .UIDKey],
                                                    countryCode: snapshot
                                                            .data!.docs[0][
                                                        ModelEmployeeInfo
                                                            .countryCodeKey],
                                                  );

                                                  FirebaseFirestore.instance
                                                      .collection(Strings
                                                          .serviceProvider)
                                                      .doc(
                                                          snapshot.data!.docs[0]
                                                              [ModelEmployeeInfo
                                                                  .UIDKey])
                                                      .collection(
                                                          Strings.employee)
                                                      .doc(snapshot
                                                          .data!.docs[0].id
                                                          .toString())
                                                      .set(
                                                          employeeInfo.toMap());

                                                

                                                  Navigator
                                                      .pushNamedAndRemoveUntil(
                                                          context,
                                                          ServiceProviderDashBoard
                                                              .pageName,
                                                          arguments: {
                                                            Strings.status:
                                                                widget.status
                                                          },
                                                          (route) => false);
                                                }
                                              } else {
                                                showCustomToast(
                                                    msg: 'inValid Email');
                                              }
                                            } else {
                                              showCustomToast(
                                                  msg: 'Field Must BE Filled');
                                            }
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: CustomColors
                                                      .buttonBackgroundColor,
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.09),
                                                      offset: const Offset(
                                                        0.1,
                                                        1.5,
                                                      ),
                                                    ),
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.09),
                                                      offset: const Offset(
                                                        -0.1,
                                                        -0.001,
                                                      ),
                                                      spreadRadius: -1,
                                                    ),
                                                  ]),
                                              child: const Text(
                                                'Login',
                                                style: TextStyle(
                                                    color: CustomColors
                                                        .buttonTextFontColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              )),
                                        );
                                      } else {
                                        return const SizedBox();
                                      }
                                    },
                                  ),
                                ),
                          widget.status != Strings.employee
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color:
                                            CustomColors.buttonBackgroundColor,
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.09),
                                            offset: const Offset(
                                              0.1,
                                              1.5,
                                            ),
                                          ),
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.09),
                                            offset: const Offset(
                                              -0.1,
                                              -0.001,
                                            ),
                                            spreadRadius: -1,
                                          ),
                                        ]),
                                    child: InkWell(
                                      onTap: () async {
                                        
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PhoneLoginPage(
                                                      status: widget.status,
                                                      signFor: 'login'),
                                            ));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Icon(
                                              Icons.phone_android,
                                              size: 32,
                                              color:
                                                  CustomColors.backGroundColor,
                                            ),
                                          ),
                                          Text(
                                            'Login with Phone',
                                            style: TextStyle(
                                                color: CustomColors
                                                    .backGroundColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          widget.status != Strings.employee
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have an account?",
                                      style: TextStyle(
                                          color: CustomColors
                                              .buttonTextFontColor
                                              .withOpacity(0.9),
                                          fontSize: 18),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pushReplacementNamed(
                                              context, SignUpPage.pageName,
                                              arguments: {
                                                Strings.status: widget.status
                                              });
                                        },
                                        child: const Text(
                                          'Sign Up',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: CustomColors
                                                  .buttonTextFontColor,
                                              fontSize: 18),
                                        ))
                                  ],
                                )
                              : const SizedBox(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(top: 32, left: 15, child: backButton(context))
        ],
      ),
    );
  }
}
