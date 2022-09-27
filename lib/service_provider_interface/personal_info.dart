import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:wedding_planner/repository/utils/custom_widgets.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import 'package:wedding_planner/repository/utils/model_location.dart';
import 'package:wedding_planner/service_provider_interface/category_dialogue.dart';
import 'package:wedding_planner/service_provider_interface/employee_section/employee_info_page.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({Key? key}) : super(key: key);

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneNameController;
  late TextEditingController addressNameController;
  late TextEditingController businessNameController;
  late TextEditingController categoryNameController;
  var globalKey = GlobalKey<FormState>();
  late LocationPicker getLocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation = Provider.of<LocationPicker>(context, listen: false);
    getLocation.getCurrentPosition(context);
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneNameController = TextEditingController();
    addressNameController = TextEditingController();
    businessNameController = TextEditingController();
    categoryNameController = TextEditingController();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNameController.dispose();
    addressNameController.dispose();
    businessNameController.dispose();
    categoryNameController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    addressNameController.addListener(() {
      addressNameController.text = getLocation.currentAddress;
    });

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
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Form(
              key: globalKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'A few more details\nabout you...',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: CustomWidget.customTextField3(
                        titleName: 'First Name',
                        controller: firstNameController,
                        context: context),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: CustomWidget.customTextField3(
                        titleName: 'Last Name',
                        controller: lastNameController,
                        context: context),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: IntlPhoneField(
                      dropdownIconPosition: IconPosition.trailing,
                      flagsButtonPadding: EdgeInsets.only(left: 5),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(top: 17, bottom: 0),
                        hintText: 'Phone Number',
                        fillColor: Colors.white,
                        filled: true,
                        //enabledBorder: InputBorder.none,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(width: 0)),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black54),
                      onCountryChanged: (country) {
                        print('Country changed to: ' + country.name);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: CustomWidget.customTextField3(
                        titleName: 'Business',
                        controller: businessNameController,
                        context: context),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      child: CustomWidget.customTextField3(
                          onTap: () => getLocation.getCurrentPosition(context),
                          titleName: 'Location',
                          controller: addressNameController,
                          context: context)
                      // Consumer<LocationPicker>(
                      //   builder: (BuildContext context, value, Widget? child) {
                      //     addressNameController.text = value.currentAddress;
                      //     return CustomWidget.customTextField3(
                      //         onTap: () =>
                      //             getLocation.getCurrentPosition(context),
                      //         titleName: 'Location',
                      //         controller: addressNameController,
                      //         context: context);
                      //   },
                      // ),
                      ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: CustomWidget.customTextField3(
                        onTap: () {
                          CategoryBottomSheetBar.categoryBottomSheet(context);
                        },
                        titleName: 'Categories',
                        inputType: TextInputType.none,
                        controller: categoryNameController,
                        context: context),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EmployeeInfoPage(),
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
                              child: Text('Continue',
                                  style:
                                      ButtonsStyle.buttonTextStyle(context))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
