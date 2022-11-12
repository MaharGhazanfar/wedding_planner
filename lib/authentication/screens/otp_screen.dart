import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rive/rive.dart';

import '../../repository/utils/data_constants.dart';
import '../../service_provider_interface/personal_info.dart';
import '../../service_provider_interface/service_provider_dashboard.dart';

class OTPScreen extends StatefulWidget {
  final String verificationID;
  final String status;
  final String signFor;
  final String number;

  const OTPScreen({
    Key? key,
    required this.status,
    required this.signFor,
    required this.number,
    required this.verificationID,
  }) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController codeController = TextEditingController();

  final globalKey = GlobalKey<FormState>();
  int counter = 60;

  timer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (counter == 0) {
        timer.cancel();
      } else {
        if (mounted) {
          setState(() {
            counter--;
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    timer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: globalKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * .45,
                      child: const RiveAnimation.asset(
                        'assets/rive/login.riv',
                        animations: ['Appearing'],
                      )),

                  ///          textField for code .........................................................

                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Card(
                      elevation: 8,
                      // color: ConstValue.frontColor,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            PinCodeTextField(
                              length: 6,
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              animationType: AnimationType.scale,
                              textStyle: TextStyle(color: Colors.black),
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(8),
                                fieldHeight: 50,
                                fieldWidth: 40,
                                inactiveColor: Colors.tealAccent,
                              ),
                              animationDuration:
                                  const Duration(milliseconds: 300),
                              controller: codeController,
                              onChanged: (value) {},
                              appContext: context,
                            ),
                            GestureDetector(
                              onTap: () async {
                                PhoneAuthCredential credential =
                                    PhoneAuthProvider.credential(
                                        verificationId: widget.verificationID,
                                        smsCode:
                                            codeController.text.toString());
                                await FirebaseAuth.instance
                                    .signInWithCredential(credential)
                                    .then((value) {
                                  if (widget.signFor == 'login') {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ServiceProviderDashBoard(
                                            status: Strings.normalMode,
                                          ),
                                        ),
                                        (route) => false);
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PersonalInfoPage(
                                            status: widget.status,
                                            mode: Strings.normalMode,
                                          ),
                                        ));
                                  }
                                });
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  decoration: BoxDecoration(
                                      color: CustomColors.buttonBackgroundColor,
                                      borderRadius: BorderRadius.circular(50),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.06),
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
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: Center(
                                  child: Text(
                                'Do not receive the code?',
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                            counter != 0
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: Center(
                                        child: Text(
                                      'Time out :  $counter',
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    )),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: CupertinoButton(
                                        color: Colors.indigo,
                                        onPressed: () async {
                                          setState(() {
                                            counter = 60;
                                            timer();
                                          });
                                          await phoneAuthentication(
                                              status: widget.status,
                                              signFor: widget.signFor,
                                              number: widget.number,
                                              context: context);
                                        },
                                        child: const Text(
                                          'Resend',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> phoneAuthentication(
    {required String status,
    required String number,
    required String signFor,
    required BuildContext context}) async {
  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: number,
    verificationCompleted: (PhoneAuthCredential credential) {},
    verificationFailed: (FirebaseAuthException e) {},
    codeSent: (String verificationId, int? resendToken) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPScreen(
              verificationID: verificationId,
              status: status,
              number: number,
              signFor: signFor,
            ),
          ));
    },
    codeAutoRetrievalTimeout: (String verificationId) {},
  );
}
