import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wedding_planner/authentication/screens/phone_login_page.dart';
import 'package:wedding_planner/modelClasses/employee_info.dart';
import 'package:wedding_planner/repository/utils/custom_widgets.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import 'package:wedding_planner/service_provider_interface/service_provider_dashboard.dart';
import '../../modelClasses/model_personal_login_info.dart';
import '../../user_interface/bottom_navigationBar_screen.dart';

class LoginPage extends StatefulWidget {
  final String status;

  LoginPage({Key? key, required this.status}) : super(key: key);

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
      resizeToAvoidBottomInset: true,
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
                    left: ScreenPading.topPading,
                    right: ScreenPading.topPading),
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
                                  child: InkWell(
                                    onTap: () async {
                                      if (_emailController.text
                                                  .toString()
                                                  .length !=
                                              0 &&
                                          _passwordController.text
                                                  .toString()
                                                  .length !=
                                              0) {
                                        if (_emailController.text
                                            .toString()
                                            .contains('@gmail.com')) {
                                          String status = await signInWithEmail(
                                              password: _passwordController.text
                                                  .toString(),
                                              email: _emailController.text
                                                  .toString());
                                          if (status == 'Login Successful') {
                                            ShowCustomToast(msg: status);
                                            if (widget.status ==
                                                Strings.serviceProvider) {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ServiceProviderDashBoard(status: widget.status),
                                                  ),
                                                  (route) => false);
                                            } else if (widget.status ==
                                                Strings.serviceUser) {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BottomNavigationBarForUser(
                                                            status:
                                                                widget.status,
                                                          )),
                                                  (route) => false);
                                            }
                                          } else {
                                            ShowCustomToast(msg: status);
                                          }
                                        } else {
                                          ShowCustomToast(msg: 'inValid Email');
                                        }
                                      } else {
                                        ShowCustomToast(
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
                                                        .length !=
                                                    0 &&
                                                _passwordController.text
                                                        .toString()
                                                        .length !=
                                                    0) {
                                              if (_emailController.text
                                                  .toString()
                                                  .contains('@gmail.com')) {
                                                if (snapshot
                                                        .data!.docs.length ==
                                                    0) {
                                                  ShowCustomToast(
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

                                                  var employeeInfo = ModelEmployeeInfo(
                                                    business: snapshot
                                                        .data!.docs[0][
                                                    ModelEmployeeInfo
                                                        .businessKey].toString(),
                                                      firstName: snapshot
                                                              .data!.docs[0][
                                                          ModelEmployeeInfo
                                                              .firstNameKey],
                                                      lastName:
                                                          snapshot.data!.docs[0]
                                                              [ModelEmployeeInfo
                                                                  .lastNameKey],
                                                      number: snapshot
                                                              .data!.docs[0]
                                                          [ModelEmployeeInfo.numberKey],
                                                      email: snapshot.data!.docs[0][ModelEmployeeInfo.emailKey],
                                                      address: snapshot.data!.docs[0][ModelEmployeeInfo.addressKey],
                                                      password: snapshot.data!.docs[0][ModelEmployeeInfo.passwordKey],
                                                      UID: snapshot.data!.docs[0][ModelEmployeeInfo.UIDKey]);

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
                                                      .set(employeeInfo.toMap());

                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ServiceProviderDashBoard(status: widget.status,),
                                                      ),
                                                      (route) => false);
                                                }
                                              } else {
                                                ShowCustomToast(
                                                    msg: 'inValid Email');
                                              }
                                            } else {
                                              ShowCustomToast(
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
                                            padding: EdgeInsets.all(10.0),
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
                                        onPressed: () {},
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

                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       left: 36.0, right: 36.0, top: 24),
                    //   child: TextFormField(
                    //     decoration: const InputDecoration(
                    //         enabledBorder: UnderlineInputBorder(
                    //             borderSide: BorderSide(
                    //                 color: Colors.grey, width: 1)),
                    //         labelText: 'Password',
                    //         labelStyle: TextStyle(color: Colors.black),
                    //         prefixIcon: Icon(
                    //           Icons.lock,
                    //           color: CustomColors.textFontColor,
                    //         ),
                    //         suffix: Text(
                    //           'Hide',
                    //           style: TextStyle(
                    //               color: CustomColors.textFontColor),
                    //         )),
                    //     obscureText: true,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Future<String> signInWithEmail(
    {required String password, required String email}) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return 'Login Successful';
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return 'No user found for that email';
    } else if (e.code == 'wrong-password') {
      return 'Wrong password provided for that user';
    }
  }
  return 'SomeThing Went Wrong';
}
