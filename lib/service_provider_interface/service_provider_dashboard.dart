import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wedding_planner/common_screens/appointments_page.dart';
import 'package:wedding_planner/common_screens/blogs/blogs_page.dart';
import 'package:wedding_planner/modelClasses/employee_info.dart';
import 'package:wedding_planner/modelClasses/model_personal_login_info.dart';
import 'package:wedding_planner/repository/utils/custom_widgets.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import 'package:wedding_planner/repository/utils/db_handler.dart';
import 'package:wedding_planner/service_provider_interface/add_images.dart';
import 'package:wedding_planner/service_provider_interface/add_video.dart';
import 'package:wedding_planner/service_provider_interface/employee_section/employee_info_page.dart';
import 'package:wedding_planner/service_provider_interface/employee_section/employees_list_page.dart';
import 'package:wedding_planner/service_provider_interface/personal_info.dart';
import 'package:wedding_planner/service_provider_interface/provider_peckages.dart';
import 'package:wedding_planner/welcome_screens/user_selection_page.dart';

class ServiceProviderDashBoard extends StatefulWidget {
  final String status;
  static const pageName = '/ServiceProviderDashBoard';

  const ServiceProviderDashBoard({Key? key, required this.status})
      : super(key: key);

  @override
  State<ServiceProviderDashBoard> createState() =>
      _ServiceProviderDashBoardState();
}

class _ServiceProviderDashBoardState extends State<ServiceProviderDashBoard> {
  late final CollectionReference providerCollectionReference;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Map<String, dynamic> doc;
  String serviceProviderBusiness = '';
  String senderNumber = '';
  String senderName = '';

  @override
  void initState() {
   
    super.initState();
    providerCollectionReference = DBHandler.personalInfoCollectionForProvider();
  }

  @override
  Widget build(BuildContext context) {
    //log(' build PD//////${DBHandler.user!.uid}');
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomWidget.myCustomDrawer(
          context: context,
          width: MediaQuery.of(context).size.width * 0.55,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height * 0.18,
                  width: MediaQuery.of(context).size.width * 0.4,
                  image:
                      const AssetImage('assets/images/Mayaring_app_logo.png'),
                ),
                // InkWell(
                //   onTap: () {
                //     CategoryBottomSheetBar.categoryBottomSheet(
                //         context: context,
                //         child: ListView.builder(
                //           itemCount: Categories.categoryList.length,
                //           dragStartBehavior: DragStartBehavior.start,
                //           physics: const BouncingScrollPhysics(),
                //           itemExtent: 50.0,
                //           itemBuilder: (context, index) {
                //             return Padding(
                //               padding: const EdgeInsets.only(
                //                   left: 8, right: 8, bottom: 2, top: 2),
                //               child: ListTile(
                //                 shape: RoundedRectangleBorder(
                //                     borderRadius: BorderRadius.circular(20)),
                //                 title: Text(Categories.categoryList[index]),
                //                 tileColor: Colors.white70,
                //                 onTap: () {
                //                   if (widget.status == Strings.serviceUser) {
                //                     Navigator.push(
                //                         context,
                //                         MaterialPageRoute(
                //                           builder: (context) =>
                //                               CategoriesDetails(),
                //                         ));
                //                   } else {
                //                     SizedBox();
                //                   }
                //                 },
                //               ),
                //             );
                //           },
                //         ),
                //         status: widget.status);
                //   },
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: const [
                //       Icon(Icons.category,
                //           color: CustomColors.buttonBackgroundColor),
                //       Text('Categories')
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 16.0),
                //   child: InkWell(
                //     onTap: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => const Appointments(),
                //           ));
                //     },
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: const [
                //         Icon(Icons.meeting_room_outlined,
                //             color: CustomColors.buttonBackgroundColor),
                //         Text('Appointments')
                //       ],
                //     ),
                //   ),
                // ),'
                InkWell(
                  onTap: () {},
                  child: const Text(
                    'Bookings',
                    style: TextStyle(),
                  ),
                ),
                InkWell(
                    onTap: () {
                      // context.push('/employeeDetails');
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EmployeesList(),
                          ));*/
                      Navigator.pushNamed(context, EmployeesList.pageName);
                    },
                    child: const Text('Employee Details')),

                InkWell(
                  onTap: () {
                    /* context.push('/updateProfile', extra: {
                      Strings.status: widget.status,
                      Strings.mode: Strings.editMode,
                      Strings.doc: doc
                    });*/ /*
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonalInfoPage(
                            status: widget.status,
                            mode: Strings.editMode,
                            doc: doc,
                          ),
                        ));*/

                    Navigator.pushNamed(context, PersonalInfoPage.pageName,
                        arguments: {
                          Strings.status: widget.status,
                          Strings.mode: Strings.editMode,
                          Strings.doc: doc
                        });
                  },
                  child: const Text('Update Profile'),
                ),
                InkWell(
                  onTap: () async {
                    if (ModelPersonalLoginInfo.prefs!.getString(
                          Strings.UIDPref,
                        ) ==
                        null) {
                      await FirebaseAuth.instance.signOut();
                       ModelPersonalLoginInfo.prefs!.clear();


                      if (!mounted) return;

                      Navigator.pushReplacementNamed(
                          context, UserSelectionPage.pageName);
                    } else {
                      ModelPersonalLoginInfo.prefs!.remove(
                        Strings.UIDPref,
                      );
                      ModelPersonalLoginInfo.prefs!.remove(
                        Strings.EIDPref,
                      );

                      Navigator.pushReplacementNamed(
                          context, UserSelectionPage.pageName);
                    }
                  },
                  child: const Text('LogOut'),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Divider(
                    thickness: 2,
                  ),
                ),
                const Text(
                  'RATE ON PLAY STORE',
                ),
                const Text('SEND US FEEDBACK'),
                const Text('SHARE THIS APP'),
                const Text('PRIVACY POLICY'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
              ],
            ),
          )),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Image(
            image: AssetImage('assets/images/front_page.png'),
            fit: BoxFit.fill,
          ),
          ListView(
            children: [
              Container(
                height: DeviceOrientation == DeviceOrientation.portraitUp
                    ? MediaQuery.of(context).size.height * 0.35
                    : 250,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(50))),
                 child: StreamBuilder<DocumentSnapshot>(
                  stream: ModelPersonalLoginInfo.prefs!.getString(
                            Strings.UIDPref,
                          ) ==
                          null
                      ? providerCollectionReference
                          .doc(DBHandler.user!.uid.toString())
                          .snapshots()
                      : providerCollectionReference
                          .doc(ModelPersonalLoginInfo.prefs!.getString(
                            Strings.UIDPref,
                          ))
                          .collection(Strings.employee)
                          .doc(ModelPersonalLoginInfo.prefs!.getString(
                            Strings.EIDPref,
                          ))
                          .snapshots(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    print('//////////////${DBHandler.user!.uid}');
                    if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong'));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if(snapshot.hasData){
                     doc = snapshot.data!.data() as Map<String, dynamic>;
                        
                      serviceProviderBusiness = ModelPersonalLoginInfo.prefs!
                                  .getString(
                                Strings.UIDPref,
                              ) ==
                              null
                          ? doc[ModelPersonalLoginInfo.businessKey].toString()
                          : doc[ModelEmployeeInfo.businessKey].toString();

                      senderNumber = ModelPersonalLoginInfo.prefs!.getString(
                                Strings.UIDPref,
                              ) ==
                              null
                          ? doc[ModelPersonalLoginInfo.numberKey].toString()
                          : doc[ModelEmployeeInfo.numberKey].toString();
                      senderName = ModelPersonalLoginInfo.prefs!.getString(
                                Strings.UIDPref,
                              ) ==
                              null
                          ? '${doc[ModelPersonalLoginInfo.firstNameKey]} ${doc[ModelPersonalLoginInfo.lastNameKey]}'
                          : '${doc[ModelEmployeeInfo.firstNameKey]} ${doc[ModelEmployeeInfo.lastNameKey]}';

                      senderName = ModelPersonalLoginInfo.prefs!.getString(
                                Strings.UIDPref,
                              ) ==
                              null
                          ? '${doc[ModelPersonalLoginInfo.firstNameKey]} ${doc[ModelPersonalLoginInfo.lastNameKey]}'
                          : '${doc[ModelEmployeeInfo.firstNameKey]} ${doc[ModelEmployeeInfo.lastNameKey]}';

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      _scaffoldKey.currentState!.openDrawer();
                                    },
                                    icon: Icon(
                                      Icons.menu,
                                      color: CustomColors.backGroundColor,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    ModelPersonalLoginInfo.prefs!.getString(
                                              Strings.UIDPref,
                                            ) ==
                                            null
                                        ? doc[ModelPersonalLoginInfo
                                                .businessKey]
                                            .toString()
                                        : doc[ModelEmployeeInfo.businessKey]
                                            .toString(),
                                    style: TextStyle(
                                        color: CustomColors.backGroundColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {
                                      // context.push('/blogs');
                                      /* Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const BlogsPage(),
                                          ));*/
                                      Navigator.pushNamed(
                                        context,
                                        BlogsPage.pageName,
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.markunread_mailbox_outlined,
                                      color: CustomColors.yellowIconsColor,
                                    )),
                                IconButton(
                                    onPressed: () async {
                                      await FirebaseAuth.instance.signOut();
                                    },
                                    icon: const Icon(
                                      Icons.notifications_sharp,
                                      color: CustomColors.yellowIconsColor,
                                    ))
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: CircleAvatar(
                                  radius: 28,
                                  backgroundColor:
                                      CustomColors.buttonBackgroundColor,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 25,
                                    child: Text(
                                      ModelPersonalLoginInfo.prefs!.getString(
                                                Strings.UIDPref,
                                              ) ==
                                              null
                                          ? '${doc[ModelPersonalLoginInfo.firstNameKey].toString().characters.characterAt(0).toUpperCase()}'
                                              '${doc[ModelPersonalLoginInfo.lastNameKey].toString().characters.characterAt(0).toUpperCase()}'
                                          : '${doc[ModelEmployeeInfo.firstNameKey].toString().characters.characterAt(0).toUpperCase()}'
                                              '${doc[ModelEmployeeInfo.lastNameKey].toString().characters.characterAt(0).toUpperCase()}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: CustomColors
                                              .buttonBackgroundColor),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                  ModelPersonalLoginInfo.prefs!.getString(
                                            Strings.UIDPref,
                                          ) ==
                                          null
                                      ? '${doc[ModelPersonalLoginInfo.firstNameKey]} ${doc[ModelPersonalLoginInfo.lastNameKey]}'
                                      : '${doc[ModelEmployeeInfo.firstNameKey]} ${doc[ModelEmployeeInfo.lastNameKey]}',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: CustomColors.backGroundColor),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 8),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.mail,
                                  color: CustomColors.backGroundColor,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                    ModelPersonalLoginInfo.prefs!.getString(
                                              Strings.UIDPref,
                                            ) ==
                                            null
                                        ? doc[ModelPersonalLoginInfo.emailKey]
                                            .toString()
                                        : doc[ModelEmployeeInfo.emailKey]
                                            .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.backGroundColor)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 6),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.phone_callback_outlined,
                                  color: CustomColors.backGroundColor,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                    ModelPersonalLoginInfo.prefs!.getString(
                                              Strings.UIDPref,
                                            ) ==
                                            null
                                        ? '${doc[ModelPersonalLoginInfo.countryCodeKey]}${doc[ModelPersonalLoginInfo.numberKey]}'
                                        : '${doc[ModelEmployeeInfo.countryCodeKey]}${doc[ModelEmployeeInfo.numberKey]}',
                                    style: TextStyle(
                                        //fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.backGroundColor))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: CustomColors.backGroundColor,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Text(
                                      ModelPersonalLoginInfo.prefs!.getString(
                                                Strings.UIDPref,
                                              ) ==
                                              null
                                          ? doc[ModelPersonalLoginInfo
                                              .locationKey]
                                          : doc[ModelEmployeeInfo.addressKey],
                                      style: TextStyle(
                                          //fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: CustomColors.backGroundColor,
                                          overflow: TextOverflow.ellipsis)),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    } else{
                      return const Center(child: Text('No ata'));
                    }
                  },
                ), 
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 34.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    // textAlign: TextAlign.start,
                    'My DashBoard',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomWidget.customCardButton(
                      height: MediaQuery.of(context).size.width * .25,
                      width: MediaQuery.of(context).size.width * .30,
                      icon: Icons.photo_library,
                      iconSize: 40,
                      title: 'Photos',
                      onTap: () {
                        // context.push('/photos');
                        /*Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddImages(),
                            ));*/

                        Navigator.pushNamed(context, AddImages.pageName);
                      }),
                  CustomWidget.customCardButton(
                      height: MediaQuery.of(context).size.width * .25,
                      width: MediaQuery.of(context).size.width * .30,
                      icon: Icons.slow_motion_video,
                      iconSize: 40,
                      title: 'Videos',
                      onTap: () {
                        //context.push('/videos');
                        /* Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPlayerScreen(),
                            ));*/

                        Navigator.pushNamed(
                            context, VideoPlayerScreen.pageName);

                       }),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomWidget.customCardButton(
                      height: MediaQuery.of(context).size.width * .25,
                      width: MediaQuery.of(context).size.width * .30,
                      icon: Icons.local_offer_sharp,
                      iconSize: 40,
                      title: 'Packages',
                      onTap: () {
                        //context.push('/packages');
                        /*  Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProviderPackages(),
                            ));*/
                        Navigator.pushNamed(context, ProviderPackages.pageName);
                      }),
                  CustomWidget.customCardButton(
                      height: MediaQuery.of(context).size.width * .25,
                      width: MediaQuery.of(context).size.width * .30,
                      icon: Icons.meeting_room_outlined,
                      iconSize: 40,
                      title: 'Appointments',
                      onTap: () {
                        /*  context.push('/appointments', extra: {
                          Strings.senderName: senderName,
                          Strings.senderNumber: senderNumber,
                        });*/
                        /* Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Appointments(
                                senderName: senderName,
                                senderNumber: senderNumber,
                              ),
                            ));*/
                        Navigator.pushNamed(context, Appointments.pageName,
                            arguments: {
                              Strings.senderName: senderName,
                              Strings.senderNumber: senderNumber,
                            });
                      }),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomWidget.customCardButton(
                      height: MediaQuery.of(context).size.width * .25,
                      width: MediaQuery.of(context).size.width * .30,
                      icon: CupertinoIcons.rectangle_stack_person_crop_fill,
                      iconSize: 40,
                      title: 'Employee',
                      onTap: () {
                        Navigator.pushNamed(context, EmployeeInfoPage.pageName,
                            arguments: {
                              Strings.business: serviceProviderBusiness
                            });
                      }),
                  CustomWidget.customCardButton(
                      height: MediaQuery.of(context).size.width * .25,
                      width: MediaQuery.of(context).size.width * .30,
                      icon: Icons.request_page,
                      iconSize: 40,
                      title: 'Ad_request',
                      onTap: () {
                        // Navigator.push(context,MaterialPageRoute(builder: (context) => const AddImages(),));
                      }),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
