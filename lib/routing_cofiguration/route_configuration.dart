import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wedding_planner/authentication/screens/email_login_page.dart';
import 'package:wedding_planner/authentication/screens/login_page.dart';
import 'package:wedding_planner/authentication/screens/sign_up_page.dart';
import 'package:wedding_planner/common_screens/appointments_page.dart';
import 'package:wedding_planner/common_screens/blogs/blogs_page.dart';
import 'package:wedding_planner/common_screens/blogs/create_blog.dart';
import 'package:wedding_planner/common_screens/chat/chat_screen.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import 'package:wedding_planner/repository/utils/todo_dialog.dart';
import 'package:wedding_planner/service_provider_interface/add_images.dart';
import 'package:wedding_planner/service_provider_interface/add_video.dart';

import 'package:wedding_planner/service_provider_interface/employee_section/employee_info_page.dart';
import 'package:wedding_planner/service_provider_interface/employee_section/employees_list_page.dart';
import 'package:wedding_planner/service_provider_interface/personal_info.dart';
import 'package:wedding_planner/service_provider_interface/provider_peckages.dart';
import 'package:wedding_planner/service_provider_interface/service_provider_dashboard.dart';
import 'package:wedding_planner/user_interface/bottom_navigationBar_screen.dart';

import 'package:wedding_planner/user_interface/view_detaails.dart';
import 'package:wedding_planner/welcome_screens/user_selection_page.dart';


class RouteConfiguration {
  static Duration duration = const Duration(milliseconds: 400);

  static Route<dynamic> generateRoutes(RouteSettings settings) {

    Map<String, dynamic>? data;
    if (settings.arguments != null) {
      data = settings.arguments as Map<String, dynamic>;
    }
      switch (settings.name) {
        case UserSelectionPage.pageName:
          return PageTransition(
              duration: duration,
              child: const UserSelectionPage(),
              type: PageTransitionType.leftToRight);

        case SignUpPage.pageName:
          return PageTransition(
              duration: duration,
              child: SignUpPage(status: data![Strings.status]),
              type: PageTransitionType.leftToRight);

        case LoginPage.pageName:
          return PageTransition(
              duration: duration,
              child: LoginPage(status: data![Strings.status]),
              type: PageTransitionType.leftToRight);

        case EmailLoginPage.pageName:
          return PageTransition(
              duration: duration,
              child: EmailLoginPage(
                status: data![Strings.status],
                loginWithEmail: data[Strings.loginWithEmail],
              ),
              type: PageTransitionType.leftToRight);

        case PersonalInfoPage.pageName:
          return PageTransition(
              duration: duration,
              child: PersonalInfoPage(
                status: data![Strings.status],
                loginWith: data[Strings.loginWithEmail],
                mode: data[Strings.mode],
                emailOrNumber: data[Strings.userEmail],
                doc: data[Strings.doc],
              ),
              type: PageTransitionType.leftToRight);

        case ServiceProviderDashBoard.pageName:
          return PageTransition(
              duration: duration,
              child: ServiceProviderDashBoard(status: data![Strings.status]),
              type: PageTransitionType.leftToRight);

        case BottomNavigationBarForUser.pageName:
          return PageTransition(
              duration: duration,
              child: BottomNavigationBarForUser(status: data![Strings.status]),
              type: PageTransitionType.leftToRight);

        case ViewDetails.pageName:
          return PageTransition(
              duration: duration,
              child: ViewDetails(doc: data![Strings.doc]),
              type: PageTransitionType.leftToRight);

        case BlogsPage.pageName:
          return PageTransition(
              duration: duration,
              child: const BlogsPage(),
              type: PageTransitionType.topToBottom);

        case CreateBlog.pageName:
          return PageTransition(
              duration: duration,
              child: const CreateBlog(),
              type: PageTransitionType.leftToRight);

        case TOdoDialog.pageName:
          return PageTransition(
              duration: duration,
              child: TOdoDialog(doc: data![Strings.doc], id: data[Strings.id]),
              type: PageTransitionType.leftToRight);

        case ChatScreen.pageName:
          return PageTransition(
              duration: duration,
              child: ChatScreen(
                  senderName: data![Strings.senderName],
                  senderNumber: data[Strings.senderNumber],
                  senderStatus: data[Strings.senderStatus],
                  receiverName: data[Strings.receiverName],
                  receiverNumber: data[Strings.receiverNumber],
                  receiverStatus: data[Strings.receiverStatus]),
              type: PageTransitionType.leftToRight);

        case EmployeeInfoPage.pageName:
          return PageTransition(
              duration: duration,
              child: EmployeeInfoPage(
                serviceProviderBusiness: data![Strings.business],
              ),
              type: PageTransitionType.leftToRight);

        case Appointments.pageName:
          return PageTransition(
              duration: duration,
              child: Appointments(
                  senderName: data![Strings.senderName],
                  senderNumber: data[Strings.senderNumber]),
              type: PageTransitionType.rightToLeft);

        case ProviderPackages.pageName:
          return PageTransition(
              duration: duration,
              child: const ProviderPackages(),
              type: PageTransitionType.leftToRight);

           case VideoPlayerScreen.pageName:
          return PageTransition(
              duration: duration,
              child: VideoPlayerScreen(),
              type: PageTransitionType.rightToLeft);

        case AddImages.pageName:
          return PageTransition(
              duration: duration,
              child: const AddImages(),
              type: PageTransitionType.leftToRight);

        case EmployeesList.pageName:
          return PageTransition(
              duration: duration,
              child: const EmployeesList(),
              type: PageTransitionType.leftToRight);
        default:
          return MaterialPageRoute(
              builder: (_) =>
                  Scaffold(
                    body: Center(
                        child: Text('No route defined for ${settings.name}')),
                  ));
      }
    }
  
}
