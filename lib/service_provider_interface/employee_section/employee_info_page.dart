import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:wedding_planner/repository/utils/custom_widgets.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';

import '../../modelClasses/employee_info.dart';

class EmployeeInfoPage extends StatefulWidget {
  final String serviceProviderBusiness;
   static const pageName = '/EmployeeInfoPage';
  const EmployeeInfoPage({required this.serviceProviderBusiness, Key? key})
      : super(key: key);

  @override
  State<EmployeeInfoPage> createState() => _EmployeeInfoPageState();
}

class _EmployeeInfoPageState extends State<EmployeeInfoPage> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneNameController;
  late TextEditingController addressNameController;
  late TextEditingController emailNameController;
  late TextEditingController passwordNameController;
  String countryCode = '+94';
  var globalKey = GlobalKey<FormState>();
  late ModelEmployeeInfo _provider;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneNameController = TextEditingController();
    addressNameController = TextEditingController();
    emailNameController = TextEditingController();
    passwordNameController = TextEditingController();
    _provider = Provider.of(context, listen: false);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNameController.dispose();
    addressNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SizedBox(
          height: mq!.height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset("assets/images/front_page.png",
                  alignment: Alignment.center, fit: BoxFit.fill),
              Form(
                key: globalKey,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: ScreenPadding.leftPadding,
                      right: ScreenPadding.leftPadding),
                  child: Column(
                    children: [
                      SizedBox(
                        height: mq!.height * .3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 32.0),
                              child: IconButton(
                                  padding: const EdgeInsets.only(top: 8),
                                  alignment: Alignment.topLeft,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: CustomColors.backGroundColor,
                                  )),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Add few details about \nyour Employee...',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mq!.height * .7,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: CustomWidget.customTextField3(
                                  titleName: 'First Name',
                                  controller: firstNameController,
                                  context: context),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: CustomWidget.customTextField3(
                                  titleName: 'Last Name',
                                  controller: lastNameController,
                                  context: context),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                height: 55,
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
                                    flagsButtonPadding:
                                        const EdgeInsets.only(left: 5, top: 5),
                                    initialValue: countryCode,
                                    decoration: const InputDecoration(
                                        prefixStyle:
                                            TextStyle(color: Colors.black54),
                                        errorStyle: TextStyle(
                                            color: CustomColors.blackText,
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
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black54),
                                    controller: phoneNameController,
                                    onCountryChanged: (country) {
                                      countryCode = '+${country.dialCode}';

                                    },
                                    autovalidateMode: AutovalidateMode.disabled,
                                    dropdownTextStyle:
                                        const TextStyle(color: Colors.black54),
                                    pickerDialogStyle: PickerDialogStyle(
                                        countryCodeStyle:
                                            const TextStyle(color: Colors.black54)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: CustomWidget.customTextField3(
                                  titleName: 'Email',
                                  controller: emailNameController,
                                  context: context),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8.0,
                              ),
                              child: CustomWidget.customTextField3(
                                  titleName: 'Address',
                                  controller: addressNameController,
                                  context: context),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: CustomWidget.customTextField3(
                                  titleName: 'password',
                                  controller: passwordNameController,
                                  context: context),
                            ),
                            InkWell(
                              onTap: () async {
                                if (firstNameController.text.toString().isNotEmpty &&
                                    lastNameController.text.toString().isNotEmpty &&
                                    phoneNameController.text
                                            .toString().isNotEmpty &&
                                    emailNameController.text
                                            .toString().isNotEmpty &&
                                    addressNameController.text
                                            .toString().isNotEmpty &&
                                    passwordNameController.text
                                            .toString().isNotEmpty) {
                                  var employeeInfo = ModelEmployeeInfo(
                                      business: widget.serviceProviderBusiness,
                                      firstName:
                                          firstNameController.text.toString(),
                                      address:
                                          addressNameController.text.toString(),
                                      email:
                                          emailNameController.text.toString(),
                                      lastName:
                                          lastNameController.text.toString(),
                                      number:
                                          phoneNameController.text.toString(),
                                      password: passwordNameController.text
                                          .toString(),
                                      UID: FirebaseAuth
                                          .instance.currentUser!.uid,
                                      countryCode: countryCode);
                                  _provider.isLoading = true;
                                 await FirebaseFirestore.instance
                                      .collection('Employee')
                                      .doc()
                                      .set(employeeInfo.toMap());
                                  _provider.isLoading = false;

                                  showCustomToast(msg: 'Successful Added');
                                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                    Navigator.pop(context);
                                  });

                                } else {
                                  showCustomToast(
                                      msg: 'Fields are Must Filled');
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 16.0),
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
                                        child: Consumer<ModelEmployeeInfo>(
                                          builder: (context, value, child) => value
                                                  .isLoading
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                  color: CustomColors.greenish,
                                                ))
                                              : Text('Save',
                                                  style: ButtonsStyle
                                                      .buttonTextStyle(
                                                          context)),
                                        )),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
