import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:wedding_planner/modelClasses/model_personal_login_info.dart';
import 'package:wedding_planner/repository/utils/custom_widgets.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import 'package:wedding_planner/repository/utils/db_handler.dart';
import 'package:wedding_planner/repository/utils/model_location.dart';
import 'package:wedding_planner/service_provider_interface/category_dialogue.dart';
import 'package:wedding_planner/service_provider_interface/service_provider_dashboard.dart';
import 'package:wedding_planner/user_interface/bottom_navigationBar_screen.dart';

class PersonalInfoPage extends StatefulWidget {
  final String status;

  PersonalInfoPage({Key? key, required this.status}) : super(key: key);

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
  late TextEditingController locationController;
  late CollectionReference collectionInfo;

  var globalKey = GlobalKey<FormState>();
  late LocationPicker getLocation;
  double? width;
  double? height;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.status == Strings.serviceProvider) {
      collectionInfo = DBHandler.personalInfoCollectionForProvider();
    } else {
      collectionInfo = DBHandler.personalInfoCollectionForServiceUser();
    }
    getLocation = Provider.of<LocationPicker>(context, listen: false);
    getLocation.getCurrentPosition(context);
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneNameController = TextEditingController();
    addressNameController = TextEditingController();
    businessNameController = TextEditingController();
    categoryNameController = TextEditingController();
    locationController = TextEditingController();

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
    phoneNameController.dispose();
    addressNameController.dispose();
    businessNameController.dispose();
    categoryNameController.dispose();
    locationController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext mainContext) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/signup.png",
              alignment: Alignment.center, fit: BoxFit.fill),
          Form(
            key: globalKey,
            child: Padding(
              padding: const EdgeInsets.only(
                left: ScreenPading.leftPading,
                right: ScreenPading.rightPading,
              ),
              child: SingleChildScrollView(
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
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 32),
                              child: Text(
                                'A few more details\nabout you...',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .7,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
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
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
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
                                  controller: phoneNameController,
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
                                    print(phone.completeNumber);
                                  },
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black54),
                                  onCountryChanged: (country) {
                                    print(
                                        'Country changed to: ' + country.name);
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
                            padding: const EdgeInsets.only(
                              top: 12.0,
                            ),
                            child: CustomWidget.customTextField3(
                                titleName: 'Business',
                                controller: businessNameController,
                                context: mainContext),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 12.0,
                            ),
                            child: CustomWidget.customTextField3(
                                onTap: () {
                                  setState(() {
                                    CategoryBottomSheetBar.categoryBottomSheet(
                                      status: widget.status,
                                      context: mainContext,
                                      child: ListView.builder(
                                        itemCount:
                                            Categories.categoryList.length,
                                        dragStartBehavior:
                                            DragStartBehavior.start,
                                        physics: const BouncingScrollPhysics(),
                                        itemExtent: 50.0,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8,
                                                right: 8,
                                                bottom: 2,
                                                top: 2),
                                            child: ListTile(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              title: Text(Categories
                                                  .categoryList[index]),
                                              tileColor: Colors.white70,
                                              onTap: () {
                                                setState(() {
                                                  categoryNameController.text =
                                                      Categories
                                                          .categoryList[index];
                                                  Navigator.pop(context);
                                                });
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  });
                                },
                                titleName: 'Categories',
                                textInputType: TextInputType.none,
                                controller: categoryNameController,
                                context: mainContext),
                          ),
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
                                                  itemCount:
                                                      value.placesList.length,
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemBuilder:
                                                      (context, index) {
                                                    return ListTile(
                                                        title: Text(
                                                          value.placesList[
                                                                  index]
                                                              ['description'],
                                                        ),
                                                        //     tileColor: Colors.white70,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        onTap: () async {
                                                          locationController
                                                                  .text =
                                                              value.placesList[
                                                                      index][
                                                                  'description'];

                                                          value.isSearching =
                                                              false;
                                                          value.placesList = [];
                                                          FocusScopeNode
                                                              currentFocus =
                                                              FocusScope.of(
                                                                  context);

                                                          if (!currentFocus
                                                              .hasPrimaryFocus) {
                                                            currentFocus
                                                                .unfocus();
                                                          }
                                                          print(
                                                              '_searchController.text ==${locationController.text}/////////');
                                                        });
                                                  }),
                                        )
                                      : const SizedBox(),
                                  CustomWidget.customTextField3(
                                      onChanged: (value) async {
                                        setState(() {
                                          getLocation.isSearching = true;
                                        });

                                        // if (value.toString().length == 1) {
                                        //   await Future.delayed(
                                        //       const Duration(seconds: 1));
                                        //   scrollController.jumpTo(scrollController
                                        //           .position.maxScrollExtent -
                                        //       (MediaQuery.of(mainContext).size.height *
                                        //           .2));
                                        // }
                                      },
                                      onTap: () => getLocation
                                          .getCurrentPosition(context),
                                      titleName: 'Location',
                                      maxLines: 2,
                                      textInputType: TextInputType.multiline,
                                      controller: locationController,
                                      context: mainContext),
                                ],
                              )),
                          GestureDetector(
                            onTap: () async {
                              print(phoneNameController.text.toString());
                              if (firstNameController.text.toString().length != 0 &&
                                  lastNameController.text.toString().length !=
                                      0 &&
                                  phoneNameController.text.toString().length !=
                                      0 &&
                                  businessNameController.text
                                          .toString()
                                          .length !=
                                      0 &&
                                  categoryNameController.text
                                          .toString()
                                          .length !=
                                      0 &&
                                  locationController.text.toString().length !=
                                      0) {
                                var personalInfo = ModelPersonalLoginInfo(
                                    firstName:
                                        firstNameController.text.toString(),
                                    lastName:
                                        lastNameController.text.toString(),
                                    number: phoneNameController.text.toString(),
                                    business:
                                        businessNameController.text.toString(),
                                    category:
                                        categoryNameController.text.toString(),
                                    location:
                                        locationController.text.toString());
                                collectionInfo
                                    .doc(DBHandler.user!.uid)
                                    .set(personalInfo.toMap());
                                if (widget.status == Strings.serviceProvider) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ServiceProviderDashBoard(
                                          status: widget.status,
                                        ),
                                      ),
                                      (route) => false);
                                } else {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BottomNavigationBarForUser(
                                                status: widget.status),
                                      ),
                                      (route) => false);
                                }
                              } else {
                                ShowCustomToast(
                                    msg: "All Field Must Be Filled");
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
                                      width: MediaQuery.of(mainContext)
                                              .size
                                              .width *
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
                                      child: Text('Continue',
                                          style: ButtonsStyle.buttonTextStyle(
                                              mainContext))),
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
          ),
        ],
      ),
    );
  }
}
