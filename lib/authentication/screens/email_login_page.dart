import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wedding_planner/authentication/authentication_services.dart';
import 'package:wedding_planner/modelClasses/model_personal_login_info.dart';
import 'package:wedding_planner/repository/utils/custom_widgets.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import 'package:wedding_planner/repository/utils/db_handler.dart';
import 'package:wedding_planner/service_provider_interface/personal_info.dart';

class EmailLoginPage extends StatefulWidget {
  final String status;
  final String loginWithEmail;

  const EmailLoginPage(
      {Key? key, required this.loginWithEmail, required this.status})
      : super(key: key);
  static const pageName = '/EmailLoginPage';

  @override
  State<EmailLoginPage> createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late ModelPersonalLoginInfo _provider;
  bool _isObscure = true;
  var globalKey = GlobalKey<FormState>();
  double? width;
  double? height;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<ModelPersonalLoginInfo>(context, listen: false);
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
    _provider = Provider.of<ModelPersonalLoginInfo>(context,listen: false);
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Stack(
         fit: StackFit.expand,
        children: [
          Image.asset("assets/images/front_page.png",
              alignment: Alignment.center, fit: BoxFit.fill),
          SingleChildScrollView(
            child: Form(
              key: globalKey,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: ScreenPadding.leftPadding,
                    right: ScreenPadding.rightPadding,
                    top: ScreenPadding.topPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        padding: const EdgeInsets.only(top: 8),
                        alignment: Alignment.topLeft,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: CustomColors.backGroundColor,
                        )),
                    const Padding(
                      padding: EdgeInsets.only(top: 32),
                      child: Text(
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

                              context: context,
                              suffix: Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: IconButton(
                                  icon: Consumer<ModelPersonalLoginInfo>(

                                    builder: (BuildContext context, value, Widget? child) =>
                                        Icon(value.isObscure
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                  ),
                                  onPressed: () {

                                    _provider.isObscure = !_provider.isObscure;

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
                                  icon: Consumer<ModelPersonalLoginInfo>(

                                    builder: (BuildContext context, value, Widget? child) =>
                                    Icon(value.isObscure
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                  ),
                                  onPressed: () {

                                    _provider.isObscure = !_provider.isObscure;

                                  },
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 16.0),
                          ),
                          InkWell(
                            onTap: () async {
                              if (emailController.text
                                      .toString()
                                      .isNotEmpty &&
                                  passwordController.text
                                      .toString()
                                      .isNotEmpty &&
                                  confirmPasswordController.text
                                      .toString()
                                      .isNotEmpty) {
                                if (emailController.text
                                    .toString()
                                    .toLowerCase()
                                    .contains('@gmail.com')) {
                                  if (passwordController.text.toString() ==
                                      confirmPasswordController.text
                                          .toString()) {
                                    _provider.isLoading = true;
                                    String status = await loginWithEmailPas(
                                        email: emailController.text
                                          ..toString(),
                                        password: passwordController.text
                                            .toString());
                                    _provider.isLoading = false;

                                    if (status == 'Login Successful') {
                                      print('/////user///${DBHandler.user}');
                                      print('/////uid///${DBHandler.user!.uid}');
                                      showCustomToast(msg: status);
                                          ModelPersonalLoginInfo.prefs!
                                                      .setString(
                                                          Strings.status , widget.status);
                                        Navigator.pushNamed(
                                            context, PersonalInfoPage.pageName,

                                            arguments: {
                                              Strings.loginWithEmail:
                                                  widget.loginWithEmail,
                                              Strings.userEmail:
                                                  emailController.text,
                                              Strings.status: widget.status,
                                              Strings.mode:
                                                  Strings.normalMode,
                                              Strings.doc: null
                                            });


                                    } else {
                                      showCustomToast(msg: status);
                                    }
                                  } else {
                                    showCustomToast(
                                        msg: "Password Not Match");
                                  }
                                } else {
                                  showCustomToast(msg: "Invalid Gmail");
                                }
                              } else {
                                showCustomToast(
                                    msg: "All Field Must Be Filled");
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 24.0),
                              child: Container(
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
                                  child: Consumer<ModelPersonalLoginInfo>(
                                    builder: (context, value, child) => value
                                            .isLoading
                                        ? const Center(
                                            child:
                                                CircularProgressIndicator(
                                            color: CustomColors.greenish,
                                          ))
                                        : Text('Create Account',
                                            style: ButtonsStyle
                                                .buttonTextStyle(
                                                    context)),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
