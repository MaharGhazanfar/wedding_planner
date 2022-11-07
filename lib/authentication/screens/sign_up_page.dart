import 'package:flutter/material.dart';
import 'package:wedding_planner/authentication/screens/email_login_page.dart';
import 'package:wedding_planner/authentication/screens/login_page.dart';
import 'package:wedding_planner/authentication/screens/phone_login_page.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';

class SignUpPage extends StatefulWidget {
  final String status;
  SignUpPage({Key? key, required this.status}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Image(
            image: AssetImage('assets/images/signup.png'),
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: ScreenPading.topPading,
              right: ScreenPading.topPading,
              // bottom: Pading.bottomPading,
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
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

                      /// sign up with email.........................

                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EmailLoginPage(status: widget.status),
                              ));
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.email,
                                size: 30,
                                color: CustomColors.backGroundColor,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Sign up with Email',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.backGroundColor,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// sign up with phone.........................
                      InkWell(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PhoneLoginPage(
                                  signFor: 'create',
                                  status: widget.status,
                                ),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12.0, bottom: 12),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.phone_android,
                                  size: 32,
                                  color: CustomColors.backGroundColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Sign up with Phone',
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



                      SizedBox(
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(left: 2.0),
                              child: Text(
                                'Terms & Conditions',
                                style: TextStyle(
                                    color: CustomColors.buttonTextFontColor,
                                    fontSize: 15),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 2.0),
                              child: Text(
                                'Privacy policy',
                                style: TextStyle(
                                    color: CustomColors.buttonTextFontColor,
                                    fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),



                      SizedBox(
                        //width: MediaQuery.of(context).size.width*0.7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                top: 12.0,
                              ),
                              child: Text(
                                'Already have an account?',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.buttonTextFontColor,
                                    fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 16.0,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            LoginPage(status: widget.status),
                                      ));
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 90,
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
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(
                                        color: CustomColors.backGroundColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            )
                          ],
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
    );
  }
}
