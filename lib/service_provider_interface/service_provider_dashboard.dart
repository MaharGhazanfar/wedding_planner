import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wedding_planner/common_screens/appointments_page.dart';
import 'package:wedding_planner/repository/utils/custom_widgets.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text(
          'Business',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: CustomColors.buttonBackgroundColor,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.notifications_sharp),
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: CustomColors.buttonBackgroundColor,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(50))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.green,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            child: Text(
                              'MI',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: CustomColors.buttonBackgroundColor),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text(
                            'Muhammad Imran',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.backGroundColor),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
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
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.mail,
                            color: CustomColors.backGroundColor,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text('nimanth...@gmail.com',
                              style: TextStyle(
                                  //fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: CustomColors.backGroundColor))
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
                          Text('+932100000000',
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
                          Text('Bahawalpur Pakistan',
                              style: TextStyle(
                                  //fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: CustomColors.backGroundColor))
                        ],
                      ),
                    )
                  ],
                ),
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
                  'My Dash_Board',
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
                            builder: (context) => const VideoPlayerScreen(),
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
      ),
    );
  }
}
