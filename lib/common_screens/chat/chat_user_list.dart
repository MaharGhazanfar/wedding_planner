import 'package:flutter/material.dart';
import '../../modelClasses/employee_info.dart';
import '../../repository/utils/data_constants.dart';
import '../../repository/utils/db_handler.dart';

class ChatUserList extends StatefulWidget {
  final String senderNumber;

  const ChatUserList({Key? key, required this.senderNumber}) : super(key: key);

  @override
  State<ChatUserList> createState() => _ChatUserListState();
}

class _ChatUserListState extends State<ChatUserList> {
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
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: StreamBuilder(
                          stream: DBHandler.chatsUserList()
                              .doc(widget.senderNumber).collection(Strings.personalChat)
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
                                    title: Text(
                                        '${snapshot.data!.docs[index][ModelEmployeeInfo.firstNameKey]} ${snapshot.data!.docs[index][ModelEmployeeInfo.lastNameKey]}'),
                                    onTap: () {},
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
