import 'package:flutter/material.dart';
import 'package:wedding_planner/common_screens/chat/chat_screen.dart';
import 'package:wedding_planner/common_screens/chat/chat_user_list.dart';
import 'package:wedding_planner/modelClasses/employee_info.dart';
import 'package:wedding_planner/modelClasses/model_personal_login_info.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import 'package:wedding_planner/repository/utils/db_handler.dart';

class Appointments extends StatefulWidget {
  final String senderNumber;
  final String senderName;
  final String UID;
  static const pageName = '/Appointments';

  const Appointments(
      {Key? key,
      required this.senderNumber,
      required this.senderName,
      this.UID = ''})
      : super(key: key);

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/front_page.png",
              alignment: Alignment.center, fit: BoxFit.fill),
          Padding(
            padding: const EdgeInsets.only(
                top: ScreenPadding.topPadding,
                left: ScreenPadding.leftPadding,
                right: ScreenPadding.leftPadding),
            child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                              padding: const EdgeInsets.only(top: 8),
                              alignment: Alignment.topLeft,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: CustomColors.backGroundColor,
                              )),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Appointments',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.backGroundColor),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Service Provider : ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.backGroundColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: StreamBuilder(
                          stream: DBHandler.personalInfoCollectionForProvider()
                              .doc(widget.UID != ''
                                  ? widget.UID
                                  : ModelPersonalLoginInfo.prefs!.getString(
                                        Strings.UIDPref,
                                      ) ??
                                      DBHandler.user!.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              Map<String, dynamic> doc =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              return Card(
                                child: ListTile(
                                  leading: const CircleAvatar(
                                    backgroundColor:
                                        CustomColors.buttonBackgroundColor,
                                    child: Icon(Icons.person),
                                  ),
                                  trailing:
                                      ModelPersonalLoginInfo.prefs!.getString(
                                                    Strings.UIDPref,
                                                  ) ==
                                                  null &&
                                              widget.UID == ''
                                          ? const SizedBox()
                                          : InkWell(
                                              onTap: () {
                                                /*Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChatScreen(
                                                              senderName: widget
                                                                  .senderName,
                                                              receiverStatus:
                                                                  Strings
                                                                      .serviceProvider,
                                                              senderStatus: widget
                                                                          .UID !=
                                                                      ''
                                                                  ? Strings
                                                                      .serviceUser
                                                                  : ModelPersonalLoginInfo
                                                                              .prefs!
                                                                              .getString(
                                                                            Strings.UIDPref,
                                                                          ) ==
                                                                          null
                                                                      ? Strings
                                                                          .serviceProvider
                                                                      : Strings
                                                                          .employee,
                                                              senderNumber: widget
                                                                  .senderNumber,
                                                              receiverNumber: doc[
                                                                  ModelPersonalLoginInfo
                                                                      .numberKey],
                                                              receiverName:
                                                                  '${doc[ModelPersonalLoginInfo.firstNameKey]} ${doc[ModelPersonalLoginInfo.lastNameKey]}'),
                                                    ));*/

                                                Navigator.pushNamed(context, ChatScreen.pageName,arguments: {Strings.senderName: widget
                                                    .senderName,
                                                  Strings.receiverStatus:
                                                  Strings
                                                      .serviceProvider,
                                                  Strings.senderStatus: widget
                                                      .UID !=
                                                      ''
                                                      ? Strings
                                                      .serviceUser
                                                      : ModelPersonalLoginInfo
                                                      .prefs!
                                                      .getString(
                                                    Strings.UIDPref,
                                                  ) ==
                                                      null
                                                      ? Strings
                                                      .serviceProvider
                                                      : Strings
                                                      .employee,
                                                  Strings.senderNumber: widget
                                                      .senderNumber,
                                                  Strings.receiverNumber: doc[
                                                  ModelPersonalLoginInfo
                                                      .numberKey],
                                                  Strings.receiverName:
                                                  '${doc[ModelPersonalLoginInfo.firstNameKey]} ${doc[ModelPersonalLoginInfo.lastNameKey]}'});
                                              },
                                              child: const Icon(
                                                Icons.chat,
                                                color: CustomColors
                                                    .buttonBackgroundColor,
                                                size: 25,
                                              ),
                                            ),
                                  title: Text(
                                      '${doc[ModelPersonalLoginInfo.firstNameKey]} ${doc[ModelPersonalLoginInfo.lastNameKey]}'),
                                  onTap: () {
                                    if (widget.UID == '') {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChatUserList(
                                                    senderStatus:
                                                        ModelPersonalLoginInfo
                                                                    .prefs!
                                                                    .getString(
                                                                  Strings
                                                                      .UIDPref,
                                                                ) ==
                                                                null
                                                            ? Strings
                                                                .serviceProvider
                                                            : Strings.employee,
                                                    senderName:
                                                        widget.senderName,
                                                    senderNumber:
                                                        widget.senderNumber,
                                                  )));
                                    }
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => ChatPage(
                                    //           senderNumber: widget.senderNumber,
                                    //           receiverNumber: doc[ModelPersonalLoginInfo.numberKey],
                                    //           name:
                                    //               '${doc[ModelPersonalLoginInfo.firstNameKey]} ${doc[ModelPersonalLoginInfo.lastNameKey]}'),
                                    //     ));
                                  },
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Employees : ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.backGroundColor),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: StreamBuilder(
                          stream: DBHandler.personalInfoCollectionForProvider()
                              .doc(widget.UID != ''
                                  ? widget.UID
                                  : ModelPersonalLoginInfo.prefs!.getString(
                                        Strings.UIDPref,
                                      ) ??
                                      DBHandler.user!.uid)
                              .collection(Strings.employee)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.data!.docs.isNotEmpty) {
                              return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => Card(
                                  child: ListTile(
                                    leading: const CircleAvatar(
                                      backgroundColor:
                                          CustomColors.buttonBackgroundColor,
                                      child: Icon(Icons.person),
                                    ),
                                    trailing: widget.senderNumber !=
                                            snapshot.data!.docs[index]
                                                [ModelEmployeeInfo.numberKey]
                                        ? InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChatScreen(
                                                            senderName: widget
                                                                .senderName,
                                                            receiverStatus:
                                                                Strings
                                                                    .employee,
                                                            senderStatus: widget
                                                                        .UID !=
                                                                    ''
                                                                ? Strings
                                                                    .serviceUser
                                                                : ModelPersonalLoginInfo
                                                                            .prefs!
                                                                            .getString(
                                                                          Strings
                                                                              .UIDPref,
                                                                        ) ==
                                                                        null
                                                                    ? Strings
                                                                        .serviceProvider
                                                                    : Strings
                                                                        .employee,
                                                            senderNumber: widget
                                                                .senderNumber,
                                                            receiverNumber: snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                [
                                                                ModelEmployeeInfo
                                                                    .numberKey],
                                                            receiverName:
                                                                '${snapshot.data!.docs[index][ModelEmployeeInfo.firstNameKey]} ${snapshot.data!.docs[index][ModelEmployeeInfo.lastNameKey]}'),
                                                  ));
                                            },
                                            child: const Icon(
                                              Icons.chat,
                                              color: CustomColors
                                                  .buttonBackgroundColor,
                                              size: 25,
                                            ),
                                          )
                                        : const SizedBox(),
                                    title: Text(
                                        '${snapshot.data!.docs[index][ModelEmployeeInfo.firstNameKey]} ${snapshot.data!.docs[index][ModelEmployeeInfo.lastNameKey]}'),
                                    onTap: () {
                                      if (widget.UID == '') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChatUserList(
                                                        senderStatus:
                                                            ModelPersonalLoginInfo
                                                                        .prefs!
                                                                        .getString(
                                                                      Strings
                                                                          .UIDPref,
                                                                    ) ==
                                                                    null
                                                                ? Strings
                                                                    .serviceProvider
                                                                : Strings
                                                                    .employee,
                                                        senderName:
                                                            widget.senderName,
                                                        senderNumber: snapshot
                                                                .data!
                                                                .docs[index][
                                                            ModelEmployeeInfo
                                                                .numberKey])));
                                      }
                                    },
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
