import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wedding_planner/common_screens/appointments_page.dart';
import 'package:wedding_planner/common_screens/blogs/blogs_page.dart';
import 'package:wedding_planner/modelClasses/model_personal_login_info.dart';
import 'package:wedding_planner/repository/utils/custom_widgets.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import 'package:wedding_planner/repository/utils/db_handler.dart';
import 'package:wedding_planner/service_provider_interface/add_images.dart';
import 'package:wedding_planner/service_provider_interface/add_video.dart';
import 'package:wedding_planner/service_provider_interface/employee_section/employee_info_page.dart';
import 'package:wedding_planner/service_provider_interface/provider_peckages.dart';

class ServiceProviderDashBoard extends StatefulWidget {
  const ServiceProviderDashBoard({Key? key}) : super(key: key);

  @override
  State<ServiceProviderDashBoard> createState() =>
      _ServiceProviderDashBoardState();
}

class _ServiceProviderDashBoardState extends State<ServiceProviderDashBoard> {
  late final CollectionReference providerCollectionReference;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('collection data///////////////////////////////');
    providerCollectionReference = DBHandler.personalInfoCollectionForProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  stream: providerCollectionReference
                      .doc(DBHandler.user!.uid.toString())
                      .snapshots(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: const Text('Something went wrong'));
                    }
                    ;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      Map<String, dynamic> doc =
                          snapshot.data!.data() as Map<String, dynamic>;
                      print(
                          '${doc[ModelPersonalLoginInfo.firstNameKey].toString().characters.characterAt(0).toUpperCase()};;;;;;;;;;;');
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: CustomColors.backGroundColor,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    doc[ModelPersonalLoginInfo.businessKey],
                                    style: TextStyle(
                                        color: CustomColors.backGroundColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BlogsPage(),
                                          ));
                                    },
                                    icon: const Icon(
                                      Icons.markunread_mailbox_outlined,
                                      color: CustomColors.yellowIconsColor,
                                    )),
                                IconButton(
                                    onPressed: () {},
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
                                padding: const EdgeInsets.only(left: 16.0),
                                child: CircleAvatar(
                                  radius: 28,
                                  backgroundColor:
                                      CustomColors.buttonBackgroundColor,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 25,
                                    child: Text(
                                      '${doc[ModelPersonalLoginInfo.firstNameKey].toString().characters.characterAt(0).toUpperCase()}'
                                      '${doc[ModelPersonalLoginInfo.lastNameKey].toString().characters.characterAt(0).toUpperCase()}',
                                      style: TextStyle(
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
                                  '${doc[ModelPersonalLoginInfo.firstNameKey]} ${doc[ModelPersonalLoginInfo.lastNameKey]}',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: CustomColors.backGroundColor),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.mail,
                                      color: CustomColors.backGroundColor,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(DBHandler.user!.email!,
                                        style: TextStyle(
                                            //fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                CustomColors.backGroundColor)),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    FirebaseAuth.instance.signOut();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          size: 20,
                                          color: CustomColors.backGroundColor,
                                        ),
                                        const Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'Edit',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
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
                                Text(doc[ModelPersonalLoginInfo.numberKey],
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
                                SizedBox(
                                  width: 20,
                                ),
                                Text(doc[ModelPersonalLoginInfo.locationKey],
                                    style: TextStyle(
                                        //fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.backGroundColor))
                              ],
                            ),
                          )
                        ],
                      );
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddImages(),
                            ));
                      }),
                  CustomWidget.customCardButton(
                      height: MediaQuery.of(context).size.width * .25,
                      width: MediaQuery.of(context).size.width * .30,
                      icon: Icons.slow_motion_video,
                      iconSize: 40,
                      title: 'Videos',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPlayerScreen(),
                            ));
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProviderPackages(),
                            ));
                      }),
                  CustomWidget.customCardButton(
                      height: MediaQuery.of(context).size.width * .25,
                      width: MediaQuery.of(context).size.width * .30,
                      icon: Icons.meeting_room_outlined,
                      iconSize: 40,
                      title: 'Appointments',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Appointments(),
                            ));
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EmployeeInfoPage(),
                            ));
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
