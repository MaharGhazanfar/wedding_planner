
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedding_planner/repository/utils/custom_widgets.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

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
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Image.asset(
                'assets/images/login.jpg',
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Form(
                      key: globalKey,
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 200,
                            child: Image.asset('assets/images/white_logo.png',
                                fit: BoxFit.cover),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height < 800
                                ? 100
                                : 250,
                          ),
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
                                  suffix: Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: Text(
                                      'Hide',
                                      style: GoogleFonts.tinos(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                          color: CustomColors.textFontColor,
                                          fontSize: 18),
                                    ),
                                  ),
                                  titleName: 'Password',
                                  obscureText: true,
                                  context: context)),
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
                          Container(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot Password?',
                                style: GoogleFonts.tinos(
                                    textStyle:
                                    Theme.of(context).textTheme.bodyText1,
                                    color: CustomColors.buttonTextFontColor,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: InkWell(
                              onTap: () async {
                                // var status =
                                // await LoginProviders.userLoginWithEmail(
                                //   userName: _emailController.text.trim(),
                                //   password: _passwordController.text.trim(),
                                // );
                                // print(
                                //     '///////////////////$status///////////////////////////');
                                // if (status == 'login') {
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (context) =>
                                //             BottomNavigationBarForDating(),
                                //       ));
                                // } else {
                                //   ScaffoldMessenger.of(context)
                                //       .showSnackBar(const SnackBar(
                                //     content: Text(
                                //       'Some Thing wentWrong',
                                //     ),backgroundColor: Colors.red,));
                                // }
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
                                  child: Text(
                                    'Login',
                                    style: GoogleFonts.tinos(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
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
                                  color: Colors.white,
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
                                    const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child:  Icon(Icons.phone_android,size: 32,color: CustomColors.signupOptionColors,),
                                      ),

                                    Text(
                                      'Login with Phone',
                                      style: GoogleFonts.tinos(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                          color:
                                          CustomColors.headingTextFontColor,
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
                                style: GoogleFonts.tinos(
                                    textStyle:
                                    Theme.of(context).textTheme.bodyText1,
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
                                  child: Text(
                                    'Sign Up',
                                    style: GoogleFonts.tinos(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        color: CustomColors.buttonTextFontColor,
                                        fontSize: 18),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
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
