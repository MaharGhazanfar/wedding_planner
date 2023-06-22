import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:wedding_planner/modelClasses/model_personal_login_info.dart';
import 'package:wedding_planner/repository/utils/custom_widgets.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import 'package:wedding_planner/repository/utils/db_handler.dart';
import 'package:wedding_planner/repository/utils/model_location.dart';
import 'package:wedding_planner/service_provider_interface/service_provider_dashboard.dart';
import 'package:wedding_planner/user_interface/bottom_navigationBar_screen.dart';


import 'category_dialogue.dart';

class PersonalInfoPage extends StatefulWidget {
  final String? status;
  final String? mode;
  final String? loginWith;
  final String? emailOrNumber;
  final String? countryCode;
  final Map<String, dynamic>? doc;
  static const pageName = '/PersonalInfoPage';

  const PersonalInfoPage(
      {Key? key,
      required this.status,
      this.emailOrNumber = '',
      this.countryCode = '',
      this.loginWith = '',
      required this.mode,
      this.doc})
      : super(key: key);

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  late TextEditingController businessNameController;
  late TextEditingController categoryNameController;
  late TextEditingController locationController;
  late CollectionReference collectionInfo;
  late ModelPersonalLoginInfo _provider;
  late String countryCode;
  late String imgUrl;
  bool isLoading = false;
  final int index = 0;

  var globalKey = GlobalKey<FormState>();
  late LocationPicker getLocation;
  double? width;
  double? height;
  String queryValue = '';

  @override
  void initState() {
    
    super.initState();
    _provider = Provider.of<ModelPersonalLoginInfo>(context, listen: false);
    if (widget.status == Strings.serviceProvider) {
      collectionInfo = DBHandler.personalInfoCollectionForProvider();
    } else {
      collectionInfo = DBHandler.personalInfoCollectionForServiceUser();
    }
    getLocation = Provider.of<LocationPicker>(context, listen: false);
    if (widget.mode != Strings.editMode) {
      getLocation.getCurrentPosition(context);
    }
    if (Strings.loginWithEmail == widget.loginWith) {
      emailController = TextEditingController(text: widget.emailOrNumber);
    } else {
      emailController = TextEditingController();
    }

    firstNameController = TextEditingController(
        text: widget.mode == Strings.editMode
            ? widget.doc![ModelPersonalLoginInfo.firstNameKey]
            : null);
    lastNameController = TextEditingController(
        text: widget.mode == Strings.editMode
            ? widget.doc![ModelPersonalLoginInfo.lastNameKey]
            : null);
    phoneNumberController = TextEditingController(
        text: widget.mode == Strings.editMode
            ? widget.doc![ModelPersonalLoginInfo.numberKey]
            : Strings.loginWithNumber == widget.loginWith
                ? widget.emailOrNumber
                : null);
    businessNameController = TextEditingController(
        text: widget.mode == Strings.editMode
            ? widget.doc![ModelPersonalLoginInfo.businessKey]
            : null);
    categoryNameController = TextEditingController(
        text: widget.mode == Strings.editMode
            ? widget.doc![ModelPersonalLoginInfo.categoryKey]
            : null);
    locationController = TextEditingController(
        text: widget.mode == Strings.editMode
            ? widget.doc![ModelPersonalLoginInfo.locationKey]
            : null);
    imgUrl = widget.mode == Strings.editMode
        ? widget.doc![ModelPersonalLoginInfo.imgUrlKey]
        : '';
    countryCode = widget.mode == Strings.editMode
        ? widget.doc![ModelPersonalLoginInfo.countryCodeKey]
        : Strings.loginWithNumber == widget.loginWith
            ? widget.countryCode
            : '+94';

    locationController.addListener(() {
      if (getLocation.sessionToken == null) {
        getLocation.sessionToken = getLocation.uuid.v4();
        locationController.text = getLocation.currentAddress;
      } else {
        getLocation.getSuggestions(locationController.text);
      }
    });
  }

  // void getSuggestions(String input) async {
  //   const kGoogleApiKey = 'AIzaSyCuPO4QpbmH7zZ3Q-FmyBfQMZQjC0I5vns';
  //   String baseURL =
  //       'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  //   String request =
  //       '$baseURL?input=$input&key=$kGoogleApiKey&sessiontoken=$sessionToken';
  //   var response = await http.get(Uri.parse(request));
  //   if (response.statusCode == 200) {
  //     print(
  //         '///////////////////${response.body.toString()}/////////////////////////');
  //     setState(() {
  //       placesList = jsonDecode(response.body.toString())['predictions'];
  //     });
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    businessNameController.dispose();
    categoryNameController.dispose();
    locationController.dispose();
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext mainContext) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    log('profilepage');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/signup.png",
              alignment: Alignment.center, fit: BoxFit.fill),
          Form(
            key: globalKey,
            child: Padding(
              padding: const EdgeInsets.only(
                left: ScreenPadding.leftPadding,
                right: ScreenPadding.rightPadding,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: IconButton(
                            padding: const EdgeInsets.only(top: 8),
                            alignment: Alignment.topLeft,
                            onPressed: () {
                              Navigator.pop(context);
                              // context.pop();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: CustomColors.backGroundColor,
                            )),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2, bottom: 20),
                        child: Text(
                          'A few more details\nabout you...',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * .07,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mq!.height * 0.1,
                    ),
                    CustomWidget.customTextField3(
                        titleName: 'First Name',
                        controller: firstNameController,
                        context: mainContext),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: CustomWidget.customTextField3(
                          titleName: 'Last Name',
                          controller: lastNameController,
                          context: mainContext),
                    ),
                    widget.loginWith != Strings.loginWithNumber
                        ? Padding(
                            padding: const EdgeInsets.only(top: 12.0),
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
                                  initialValue: countryCode,
                                  controller: phoneNumberController,
                                  dropdownIconPosition: IconPosition.trailing,
                                  flagsButtonPadding:
                                      const EdgeInsets.only(left: 5, top: 5),
                                  decoration: const InputDecoration(
                                    prefixStyle:
                                        TextStyle(color: Colors.black54),
                                    errorStyle: TextStyle(
                                        color:
                                            CustomColors.buttonBackgroundColor,
                                        leadingDistribution:
                                            TextLeadingDistribution.even),
                                    contentPadding:
                                        EdgeInsets.only(top: 17, bottom: 0),
                                    hintText: 'Phone Number',
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (phone) {
                                    countryCode = phone.countryCode;
                                  },
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black54),
                                  onCountryChanged: (country) {
                                    countryCode = '+${country.dialCode}';
                                  },
                                  autovalidateMode: AutovalidateMode.disabled,
                                  dropdownTextStyle:
                                      const TextStyle(color: Colors.black54),
                                  pickerDialogStyle: PickerDialogStyle(
                                      countryCodeStyle: const TextStyle(
                                          color: Colors.black54)),
                                ),
                              ),
                            ),
                          )
                        : Padding(
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
                    widget.status == Strings.serviceProvider
                        ? Padding(
                            padding: const EdgeInsets.only(
                              top: 12.0,
                            ),
                            child: CustomWidget.customTextField3(
                                titleName: 'Business',
                                controller: businessNameController,
                                context: mainContext),
                          )
                        : const SizedBox(),
                    widget.status == Strings.serviceProvider
                        ? Padding(
                            padding: const EdgeInsets.only(
                              top: 12.0,
                            ),
                            child: CustomWidget.customTextField3(
                                onTap: () async {
                                  categoryNameController.text =
                                      await CategoryBottomSheetBar
                                          .categoryBottomSheet(
                                    context: mainContext,
                                  );
                                },
                                titleName: 'Categories',
                                textInputType: TextInputType.none,
                                controller: categoryNameController,
                                context: mainContext),
                          )
                        : const SizedBox(),
                    Padding(
                        padding: const EdgeInsets.only(
                          top: 12.0,
                        ),
                        child: Column(
                          children: [
                            getLocation.isSearching
                                ? Consumer<LocationPicker>(
                                    builder: (context, value, child) =>
                                        ListView.builder(
                                            itemCount: value.placesList.length,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                  title: Text(
                                                    value.placesList[index]
                                                        ['description'],
                                                  ),
                                                  //     tileColor: Colors.white70,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  onTap: () async {
                                                    locationController.text =
                                                        value.placesList[index]
                                                            ['description'];

                                                    value.isSearching = false;
                                                    value.placesList = [];
                                                    FocusScopeNode
                                                        currentFocus =
                                                        FocusScope.of(context);

                                                    if (!currentFocus
                                                        .hasPrimaryFocus) {
                                                      currentFocus.unfocus();
                                                    }
                                                  });
                                            }),
                                  )
                                : const SizedBox(),
                            CustomWidget.customTextField3(
                                contentPadding: const EdgeInsets.all(10),
                                onChanged: (value) async {
                                  getLocation.isSearching = true;
                                },
                                onTap: () {
                                  if (locationController.text.isNotEmpty) {
                                    getLocation.getCurrentPosition(context);
                                  }
                                },
                                titleName: 'Location',
                                maxLines: 5,
                                minLines: 1,
                                textInputType: TextInputType.multiline,
                                controller: locationController,
                                context: mainContext),
                          ],
                        )),
                    InkWell(
                      splashColor: Colors.white70,
                      onTap: () async {
                        // print('${phoneNumberController.text}');
                        if (firstNameController.text.toString().isNotEmpty &&
                                lastNameController.text.toString().isNotEmpty &&
                                widget.loginWith == Strings.loginWithEmail
                            ? emailController.toString().isNotEmpty
                            : phoneNumberController.text
                                        .toString()
                                        .isNotEmpty &&
                                    widget.status == Strings.serviceProvider
                                ? businessNameController.text
                                    .toString()
                                    .isNotEmpty
                                : true &&
                                        widget.status == Strings.serviceProvider
                                    ? categoryNameController.text
                                        .toString()
                                        .isNotEmpty
                                    : true &&
                                        locationController.text
                                            .toString()
                                            .isNotEmpty) {
                          var personalInfo = ModelPersonalLoginInfo(
                              firstName: firstNameController.text.toString(),
                              email: emailController.text.toString(),
                              lastName: lastNameController.text.toString(),
                              number: phoneNumberController.text.toString(),
                              countryCode: countryCode,
                              business: widget.status == Strings.serviceProvider
                                  ? businessNameController.text.toString()
                                  : '',
                              category: widget.status == Strings.serviceProvider
                                  ? categoryNameController.text.toString()
                                  : '',
                              location: locationController.text.toString(),
                              imgUrl: imgUrl);
                          _provider.isLoading = true;
                          await collectionInfo.doc(DBHandler.user!.uid).set(
                              widget.status == Strings.serviceProvider
                                  ? personalInfo.toMapForProvider()
                                  : personalInfo.toMapForUser());
                          _provider.isLoading = false;

                          if (widget.mode == Strings.editMode) {
                            if(!mounted) return;
                            Navigator.pop(context);
                          } else {
                            if (widget.status == Strings.serviceProvider) {
                              if(!mounted) return;
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  ServiceProviderDashBoard.pageName,
                                  arguments: {Strings.status: widget.status},
                                  (route) => false);
                            } else {
                              if(!mounted) return;
                              Navigator.pushNamedAndRemoveUntil(

                                  context,
                                  BottomNavigationBarForUser.pageName,
                                  arguments: {Strings.status: widget.status},
                                  (route) => false);
                            }
                          }
                        } else {
                          showCustomToast(msg: "All Field Must Be Filled");
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                alignment: Alignment.center,
                                height: 50,
                                width:
                                    MediaQuery.of(mainContext).size.width * 0.5,
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
                                child: Consumer<ModelPersonalLoginInfo>(
                                  builder: (context, value, child) => value
                                          .isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                          color: CustomColors.greenish,
                                        ))
                                      : Text(
                                          widget.mode == Strings.editMode
                                              ? 'Update'
                                              : 'Continue',
                                          style: ButtonsStyle.buttonTextStyle(
                                              mainContext)),
                                )),
                          ],
                        ),
                      ),
                    ),
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
