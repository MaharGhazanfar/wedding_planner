import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:wedding_planner/repository/utils/custom_widgets.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';

import '../add_images.dart';

class EmployeeInfoPage extends StatefulWidget {
  const EmployeeInfoPage({Key? key}) : super(key: key);

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
  var globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneNameController = TextEditingController();
    addressNameController = TextEditingController();
    emailNameController = TextEditingController();
    passwordNameController = TextEditingController();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNameController.dispose();
    addressNameController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   leading: Padding(
      //     padding: const EdgeInsets.only(left: 8.0),
      //     child: IconButton(
      //         icon: const Icon(
      //           Icons.arrow_back_ios,
      //           color: CustomColors.headingTextFontColor,
      //         ),
      //         onPressed: () {
      //           Navigator.of(context).pop();
      //         }),
      //   ),
      //   backgroundColor: CustomColors.appBarColor,
      // ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset("assets/images/front_page.png",
                  alignment: Alignment.center, fit: BoxFit.fill),
              Form(
                key: globalKey,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: ScreenPading.leftPading,
                      right: ScreenPading.leftPading),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 32.0),
                              child: IconButton(
                                  padding: EdgeInsets.only(top: 8),
                                  alignment: Alignment.topLeft,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: CustomColors.backGroundColor,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: const Align(
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
                        height: MediaQuery.of(context).size.height * .7,
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
                                    flagsButtonPadding:
                                        EdgeInsets.only(left: 5, top: 5),
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
                                      print('Country changed to: ' +
                                          country.name);
                                    },
                                    autovalidateMode: AutovalidateMode.disabled,
                                    dropdownTextStyle:
                                        TextStyle(color: Colors.black54),
                                    pickerDialogStyle: PickerDialogStyle(
                                        countryCodeStyle:
                                            TextStyle(color: Colors.black54)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: CustomWidget.customTextField3(
                                  titleName: 'Email',
                                  controller: addressNameController,
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
                                  controller: addressNameController,
                                  context: context),
                            ),
                            GestureDetector(
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AddImages(),
                                    ));
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
                                        child: Text('Save',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
