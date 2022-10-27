import 'package:flutter/material.dart';
import 'package:wedding_planner/repository/utils/custom_widgets.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import 'package:wedding_planner/service_provider_interface/service_provider_dashboard.dart';

class LoginPage extends StatefulWidget {
  String? status;

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
                                // validate: (value) =>
                                //     ModelValidation.gmailValidation(value!),
                                controller: _emailController,
                                titleName: 'Email',
                                context: context),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                              ),
                              child: CustomWidget.customTextField3(
                                  // validate: (value) =>
                                  //     ModelValidation.passwordValidation(
                                  //         value!),
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
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: InkWell(
                              onTap: () async {
                                if (widget.status == Strings.serviceProvider) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ServiceProviderDashBoard(),
                                      ));
                                } else if (widget.status ==
                                    Strings.serviceUser) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ServiceProviderDashBoard(),
                                      ));
                                } else if (widget.status == Strings.employee) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ServiceProviderDashBoard(),
                                      ));
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return SizedBox();
                                    },
                                  );
                                }
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: CustomColors.buttonBackgroundColor,
                                      borderRadius: BorderRadius.circular(40),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.09),
                                          offset: const Offset(
                                            0.1,
                                            1.5,
                                          ),
                                        ),
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.09),
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
                                        color: CustomColors.buttonTextFontColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: CustomColors.buttonBackgroundColor,
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.09),
                                      offset: const Offset(
                                        0.1,
                                        1.5,
                                      ),
                                    ),
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.09),
                                      offset: const Offset(
                                        -0.1,
                                        -0.001,
                                      ),
                                      spreadRadius: -1,
                                    ),
                                  ]),
                              child: InkWell(
                                onTap: () async {
                                  // await LoginProviders.signInWithGoogle();
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           BottomNavigationBarForDating(),
                                  //     ));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.phone_android,
                                        size: 32,
                                        color: CustomColors.backGroundColor,
                                      ),
                                    ),
                                    Text(
                                      'Login with Phone',
                                      style: TextStyle(
                                          color: CustomColors.backGroundColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                    color: CustomColors.buttonTextFontColor
                                        .withOpacity(0.9),
                                    fontSize: 18),
                              ),
                              TextButton(
                                  onPressed: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) =>
                                    //       const SignUpPage(),
                                    //     ));
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.buttonTextFontColor,
                                        fontSize: 18),
                                  ))
                            ],
                          )
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
// TextFormField(
// decoration: const InputDecoration(
// enabledBorder: UnderlineInputBorder(
// borderSide: BorderSide(
// color: CustomColors.textFontColor,
// width: 1)),
// labelText: 'Email',
// labelStyle: TextStyle(
// color: CustomColors.textFontColor),
// prefixIcon: Icon(
// Icons.person,
// color: CustomColors.textFontColor,
// )),
// ),
