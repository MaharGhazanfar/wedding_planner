import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:wedding_planner/authentication/screens/otp_screen.dart';
import 'package:wedding_planner/repository/utils/custom_widgets.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import '../../modelClasses/model_personal_login_info.dart';

class PhoneLoginPage extends StatefulWidget {
  final String status;
  final String signFor;

  const PhoneLoginPage({Key? key, required this.status, required this.signFor})
      : super(key: key);

  @override
  State<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  late TextEditingController phoneController;
  GlobalKey globalKey = GlobalKey<FormFieldState>();
  double? width;
  late String countryCode;
  double? height;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    countryCode = '+94';
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/front_page.png",
              alignment: Alignment.center, fit: BoxFit.fill),
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16, top: ScreenPadding.topPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    padding: const EdgeInsets.only(right: 24),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: CustomColors.backGroundColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                const Padding(
                  padding: EdgeInsets.only(top: 32.0),
                  child: Text(
                    "Great!\nLets get you started…",
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.headingTextFontColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: mq!.height*0.07,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.09),
                                offset: const Offset(
                                  0.1,
                                  1.5,
                                ),
                                spreadRadius: 1,
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
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: IntlPhoneField(
                            initialValue: countryCode,
                            controller: phoneController,
                            dropdownIconPosition: IconPosition.trailing,
                            flagsButtonPadding:
                                const EdgeInsets.only(left: 5, top: 5),
                            decoration: const InputDecoration(
                                prefixStyle: TextStyle(color: Colors.black54),
                                errorStyle: TextStyle(
                                    color: Colors.red,
                                    leadingDistribution:
                                        TextLeadingDistribution.even),
                                contentPadding:
                                    EdgeInsets.only(top: 17, bottom: 0),
                                hintText: 'Phone Number',
                                fillColor: Colors.white,
                                filled: true,
                                border: InputBorder.none),
                            onChanged: (phone) {
                              countryCode = phone.countryCode;
                            },
                            onCountryChanged: (country) {
                              countryCode = '+${country.dialCode}';
                            },
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black54),
                            autovalidateMode: AutovalidateMode.disabled,
                            dropdownTextStyle:
                                const TextStyle(color: Colors.black54),
                            pickerDialogStyle: PickerDialogStyle(
                                countryCodeStyle:
                                    const TextStyle(color: Colors.black54)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: FutureBuilder(
                          future: widget.signFor == 'login'
                              ? FirebaseFirestore.instance
                                  .collection(
                                      Strings.serviceProvider == widget.status
                                          ? Strings.serviceProvider
                                          : Strings.serviceUser)
                                  .where(ModelPersonalLoginInfo.numberKey,
                                      isEqualTo:
                                          phoneController.text.toString())
                                  .where(ModelPersonalLoginInfo.countryCodeKey,
                                      isEqualTo: countryCode)
                                  .get()
                              : Future.delayed(Duration.zero),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return InkWell(
                                onTap: () {
                                  if (phoneController.text
                                      .toString()
                                      .isNotEmpty) {
                                    if (widget.signFor == 'login'
                                        ? snapshot.data!.docs.isEmpty
                                        : false) {
                                      showCustomToast(
                                          msg:
                                              'Please Fill Correct Information');
                                    } else {
                                      phoneAuthentication(
                                          number:
                                              phoneController.text.toString(),
                                          countryCode: countryCode,
                                          signFor: widget.signFor,
                                          context: context,
                                          status: widget.status);
                                    }
                                  } else {
                                    showCustomToast(
                                        msg: 'Field Must Be Filled');
                                  }
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    decoration: BoxDecoration(
                                        color:
                                            CustomColors.buttonBackgroundColor,
                                        borderRadius: BorderRadius.circular(50),
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
                                    child: Text(
                                        widget.signFor == 'login'
                                            ? 'Login Account'
                                            : 'Create Account',
                                        style: ButtonsStyle.buttonTextStyle(
                                            context))),
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
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
