import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import 'package:wedding_planner/service_provider_interface/personal_info.dart';

class PhoneLoginPage extends StatefulWidget {
  final String status;
  const PhoneLoginPage({Key? key, required this.status}) : super(key: key);

  @override
  State<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  late TextEditingController phoneController;
  GlobalKey globalKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: CustomColors.headingTextFontColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        backgroundColor: CustomColors.appBarColor,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                Text(
                  "Great!\nLets get you started…",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.tinos(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.headingTextFontColor,
                  ),
                ),
                const SizedBox(
                  height: 150,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: Container(
                    height: 60,
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
                        dropdownIconPosition: IconPosition.trailing,
                        flagsButtonPadding: EdgeInsets.only(left: 5, top: 5),
                        decoration: const InputDecoration(
                            errorStyle: TextStyle(
                                color: CustomColors.buttonBackgroundColor,
                                leadingDistribution:
                                    TextLeadingDistribution.even),
                            contentPadding: EdgeInsets.only(top: 17, bottom: 0),
                            hintText: 'Phone Number',
                            fillColor: Colors.white,
                            filled: true,
                            border: InputBorder.none

                            //enabledBorder: InputBorder.none,
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(10),
                            //   borderSide: const BorderSide(
                            //       width: 0, color: Colors.transparent),
                            // ),
                            // focusedBorder: OutlineInputBorder(
                            //   borderSide: BorderSide(color: Colors.transparent),
                            //   borderRadius: BorderRadius.circular(10),
                            // ),
                            // errorBorder: OutlineInputBorder(
                            //   borderSide: BorderSide(color: Colors.transparent),
                            //   borderRadius: BorderRadius.circular(10),
                            // ),
                            ),
                        onChanged: (phone) {
                          print(phone.completeNumber);
                        },
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black54),
                        onCountryChanged: (country) {
                          print('Country changed to: ' + country.name);
                        },
                        autovalidateMode: AutovalidateMode.disabled,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PersonalInfoPage(status: widget.status),
                          ));
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                            color: CustomColors.buttonBackgroundColor,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  offset: const Offset(
                                    0,
                                    2,
                                  ),
                                  spreadRadius: 3,
                                  blurRadius: 1),
                            ]),
                        child: Text('Create Account',
                            style: ButtonsStyle.buttonTextStyle(context))),
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
