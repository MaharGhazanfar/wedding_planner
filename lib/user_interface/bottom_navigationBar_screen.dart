import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wedding_planner/common_screens/chat/chat_user_list.dart';
import 'package:wedding_planner/user_interface/market_view_place_for_user.dart';
import 'package:wedding_planner/user_interface/profile_page.dart';
import 'package:wedding_planner/user_interface/user_dashboard.dart';

import '../modelClasses/model_personal_login_info.dart';
import '../repository/utils/data_constants.dart';
import '../repository/utils/db_handler.dart';

// ignore: must_be_immutable
class BottomNavigationBarForUser extends StatefulWidget {
  int currentIndex = 0;
  final String? status;
  static const pageName = '/BottomNavigationBarForUser';

  BottomNavigationBarForUser({Key? key, currentIndex, required this.status})
      : super(
          key: key,
        );

  @override
  _BottomNavigationBarForUserState createState() =>
      _BottomNavigationBarForUserState();
}

class _BottomNavigationBarForUserState
    extends State<BottomNavigationBarForUser> {
  //int _currentIndex = widget.currentIndex!;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    print('${widget.currentIndex}///////////cureent index is ');
    pageController = PageController(initialPage: widget.currentIndex);
  }

  @override
  void dispose() {
   
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('${widget.currentIndex}///////////cureent index is ');
    return Scaffold(
      extendBody: true,
      backgroundColor: CustomColors.backGroundColor,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          MarketPlaceView(
            status: widget.status!,
          ),
          UserDashboard(
            status: widget.status,
          ),
          StreamBuilder(
              stream: DBHandler.personalInfoCollectionForServiceUser()
                  .doc(DBHandler.user!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  //print(snapshot.data![ModelPersonalLoginInfo.numberKey]);
                  return ChatUserList(
                      senderStatus: Strings.serviceUser,
                      senderName: '${snapshot.data![ModelPersonalLoginInfo.firstNameKey]} ${snapshot.data![ModelPersonalLoginInfo.lastNameKey]}',
                      senderNumber:
                          snapshot.data![ModelPersonalLoginInfo.numberKey]);
                } else {
                  return const SizedBox();
                }
              }),
          ProfilePage(
            status: widget.status!,
          ),
        ],
      ),
      bottomNavigationBar: _buildTitle(),
    );
  }

/////////////////
  Widget _buildTitle() {
    return CustomNavigationBar(
      scaleFactor: 0.2,
      iconSize: 30.0,
      elevation: 0,
      selectedColor: CustomColors.yellowIconsColor,
      strokeColor: CustomColors.yellowIconsColor,
      unSelectedColor: Colors.black12,
      backgroundColor: Colors.white,
      items: [
        CustomNavigationBarItem(
          icon: const Icon(Icons.explore_outlined),
          // title: const Text(
          //   "Explore",
          //   // style: CustomColors.normalTextStyleWithWhiteColor(context)
          // ),
        ),
        CustomNavigationBarItem(
          icon: const Icon(Icons.dashboard_customize_outlined),
          // title: const Text(
          //   "Favourite",
          //   // style: CustomColors.normalTextStyleWithWhiteColor(context)
          // ),
        ),
        CustomNavigationBarItem(
          icon: const Icon(CupertinoIcons.chat_bubble_2),
          // title: const Text(
          //   "Chat Now",
          //   // style: CustomColors.normalTextStyleWithWhiteColor(context)
          // ),
        ),
        CustomNavigationBarItem(
          icon: const Icon(
            Icons.person_outlined,
          ),
          // title: const Text(
          //   "My Account",
          //   // style: CustomColors.normalTextStyleWithWhiteColor(context)
          // ),
        ),
      ],
      currentIndex: widget.currentIndex,
      onTap: (index) {
        setState(() {
          widget.currentIndex = index;
        });
        pageController.animateToPage(widget.currentIndex,
            duration: const Duration(milliseconds: 800),
            curve: Curves.fastOutSlowIn);
      },
    );
  }
}
