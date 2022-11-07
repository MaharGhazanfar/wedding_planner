import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wedding_planner/repository/utils/custom_widgets.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import 'package:wedding_planner/service_provider_interface/personal_info.dart';

class EmailLoginPage extends StatefulWidget {
  final String status;

  const EmailLoginPage({Key? key, required this.status}) : super(key: key);

  @override
  State<EmailLoginPage> createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  bool _isObscure = true;
  var globalKey = GlobalKey<FormState>();
  double? width;
  double? height;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: globalKey,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset("assets/images/front_page.png",
                    alignment: Alignment.center, fit: BoxFit.fill),
                Padding(
                  padding: const EdgeInsets.only(
                      left: ScreenPading.leftPading,
                      right: ScreenPading.rightPading,
                      top: ScreenPading.topPading),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          padding: EdgeInsets.only(top: 8),
                          alignment: Alignment.topLeft,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: CustomColors.backGroundColor,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: const Text(
                          "Great!\nLets get you started…",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: CustomColors.headingTextFontColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.55,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: CustomWidget.customTextField3(
                                titleName: 'Email',
                                context: context,
                                controller: emailController,
                                textInputType: TextInputType.emailAddress,
                                //   validate: (value) =>
                                //       ModelValidation.gmailValidation(value!)
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: CustomWidget.customTextField3(
                                titleName: 'Password',
                                obscureText: _isObscure,
                                textInputType: TextInputType.visiblePassword,
                                controller: passwordController,
                                // validate: (value) =>
                                //     ModelValidation.passwordValidation(value!),
                                context: context,
                                suffix: Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: IconButton(
                                    icon: Icon(_isObscure
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                        print('$_isObscure/////////////////');
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: CustomWidget.customTextField3(
                                titleName: 'ConfirmPassword',
                                obscureText: _isObscure,
                                textInputType: TextInputType.visiblePassword,
                                controller: confirmPasswordController,
                                // validate: (value) =>
                                //     ModelValidation.passwordValidation(value!),
                                context: context,
                                suffix: Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: IconButton(
                                    icon: Icon(_isObscure
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                        print('$_isObscure/////////////////');
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (emailController.text.toString().length !=
                                        0 &&
                                    passwordController.text.toString().length !=
                                        0 &&
                                    confirmPasswordController.text
                                            .toString()
                                            .length !=
                                        0) {
                                  if (emailController.text
                                      .toString()
                                      .toLowerCase()
                                      .contains('@gmail.com')) {
                                    if (passwordController.text.toString() ==
                                        confirmPasswordController.text
                                            .toString()) {
                                      String status = await loginWithEmailPas(
                                          email: emailController.text
                                            ..toString(),
                                          password: passwordController.text
                                              .toString());
                                      if (status == 'Login Successful') {
                                        ShowCustomToast(msg: status);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PersonalInfoPage(
                                                      status: widget.status),
                                            ));
                                      } else {
                                        ShowCustomToast(msg: status);

                                      }
                                    } else {
                                      ShowCustomToast(msg: "Password Not Match");

                                    }
                                  } else {
                                    ShowCustomToast(msg: "Invalid Gmail");

                                  }
                                } else {
                                  ShowCustomToast(msg: "All Field Must Be Filled");
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 24.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        alignment: Alignment.center,
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        decoration: BoxDecoration(
                                            color: CustomColors
                                                .buttonBackgroundColor,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.06),
                                                  offset: const Offset(
                                                    0,
                                                    2,
                                                  ),
                                                  spreadRadius: 3,
                                                  blurRadius: 1),
                                            ]),
                                        child: Text('Create Account',
                                            style: ButtonsStyle.buttonTextStyle(
                                                context))),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<String> loginWithEmailPas(
    {required String email, required String password}) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return 'Login Successful';
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'The password provided is too weak';
    } else if (e.code == 'email-already-in-use') {
      return 'The account already exists for that email.';
    }
  } catch (e) {
    print(e);
    return 'SomeThing went wrong';
  }
  return 'Please try again later';
}
