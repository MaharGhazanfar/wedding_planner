import 'package:flutter/material.dart';
import 'package:wedding_planner/common_screens/chat/chat_screen.dart';
import 'package:wedding_planner/modelClasses/employee_info.dart';
import 'package:wedding_planner/modelClasses/model_personal_login_info.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import 'package:wedding_planner/repository/utils/db_handler.dart';
import 'chat/chat_user_list.dart';

class Appointments extends StatefulWidget {
  final String senderNumber;

  const Appointments({Key? key, required this.senderNumber}) : super(key: key);

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  @override
  void initState() {
    super.initState();

    print(widget.senderNumber);
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
                top: ScreenPading.topPading,
                left: ScreenPading.leftPading,
                right: ScreenPading.leftPading),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                              .doc(ModelPersonalLoginInfo.prefs!.getString(
                                        Strings.UIDPref,
                                      ) ==
                                      null
                                  ? DBHandler.user!.uid
                                  : ModelPersonalLoginInfo.prefs!.getString(
                                      Strings.UIDPref,
                                    ))
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              Map<String, dynamic> doc =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              print(doc[ModelPersonalLoginInfo.firstNameKey]);
                              return Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor:
                                        CustomColors.buttonBackgroundColor,
                                    child: Icon(Icons.person),
                                  ),
                                  trailing:
                                      ModelPersonalLoginInfo.prefs!.getString(
                                                Strings.UIDPref,
                                              ) ==
                                              null
                                          ? const SizedBox()
                                          : InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => ChatScreen(
                                                          senderNumber: widget
                                                              .senderNumber,
                                                          receiverNumber: doc[
                                                              ModelPersonalLoginInfo
                                                                  .numberKey],
                                                          name:
                                                              '${doc[ModelPersonalLoginInfo.firstNameKey]} ${doc[ModelPersonalLoginInfo.lastNameKey]}'),
                                                    ));
                                              },
                                              child: Icon(
                                                Icons.chat,
                                                color: CustomColors
                                                    .buttonBackgroundColor,
                                                size: 25,
                                              ),
                                            ),
                                  title: Text(
                                      '${doc[ModelPersonalLoginInfo.firstNameKey]} ${doc[ModelPersonalLoginInfo.lastNameKey]}'),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChatUserList(
                                                  senderNumber:
                                                      widget.senderNumber,
                                                )));
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
                              .doc(ModelPersonalLoginInfo.prefs!.getString(
                                        Strings.UIDPref,
                                      ) ==
                                      null
                                  ? DBHandler.user!.uid
                                  : ModelPersonalLoginInfo.prefs!.getString(
                                      Strings.UIDPref,
                                    ))
                              .collection(Strings.employee)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.data!.docs.length != 0) {
                              return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => Card(
                                  child: ListTile(
                                    leading: CircleAvatar(
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
                                                    builder: (context) => ChatScreen(
                                                        senderNumber:
                                                            widget.senderNumber,
                                                        receiverNumber: snapshot
                                                                .data!
                                                                .docs[index][
                                                            ModelEmployeeInfo
                                                                .numberKey],
                                                        name:
                                                            '${snapshot.data!.docs[index][ModelEmployeeInfo.firstNameKey]} ${snapshot.data!.docs[index][ModelEmployeeInfo.lastNameKey]}'),
                                                  ));
                                            },
                                            child: Icon(
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
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChatUserList(
                                                      senderNumber: snapshot
                                                              .data!.docs[index]
                                                          [ModelEmployeeInfo
                                                              .numberKey])));
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
