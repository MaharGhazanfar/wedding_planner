import 'package:flutter/material.dart';
import 'package:wedding_planner/common_screens/chat/chat_screen.dart';
import 'package:wedding_planner/modelClasses/model_chat.dart';

import '../../repository/utils/data_constants.dart';
import '../../repository/utils/db_handler.dart';

class ChatUserList extends StatefulWidget {
  final String senderNumber;
  final String senderName;
  final String senderStatus;

  const ChatUserList(
      {Key? key,
      required this.senderNumber,
      required this.senderStatus,
      required this.senderName})
      : super(key: key);

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
                top: ScreenPadding.topPadding,
                left: ScreenPadding.leftPadding,
                right: ScreenPadding.leftPadding),
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
                          stream: Strings.serviceUser == widget.senderStatus
                              ? DBHandler.chatsUserList()
                                  .doc(widget.senderNumber)
                                  .collection(Strings.personalChat)
                                  .snapshots()
                              : DBHandler.chatsUserList()
                                  .doc(widget.senderNumber)
                                  .collection(Strings.personalChat)
                                  .where(Strings.serviceUser)
                                  .snapshots(),
                          builder: (context, snapshot) {
                            print(
                                '${widget.senderNumber}..........................');
                            if (snapshot.hasData &&
                                snapshot.data!.docs.length != 0) {
                              print(
                                  '...................................................');
                              return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => Card(
                                  child: ListTile(
                                    onTap: () {
                                      /*Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ChatScreen(
                                                senderName: widget.senderName,
                                                senderNumber:
                                                    widget.senderNumber,
                                                receiverStatus:
                                                    snapshot.data!.docs[index][
                                                        ModelChat
                                                            .receiverStatusKey],
                                                receiverName: snapshot
                                                        .data!.docs[index]
                                                    [ModelChat.receiverNameKey],
                                                receiverNumber: snapshot
                                                    .data!.docs[index].id,
                                                senderStatus:
                                                    widget.senderStatus),
                                          ));*/

                                      Navigator.pushNamed(
                                          context, ChatScreen.pageName,
                                          arguments: {
                                            Strings.senderName:
                                                widget.senderName,
                                            Strings.senderNumber:
                                                widget.senderNumber,
                                            Strings.receiverStatus: snapshot
                                                    .data!.docs[index]
                                                [ModelChat.receiverStatusKey],
                                            Strings.receiverName:
                                                snapshot.data!.docs[index]
                                                    [ModelChat.receiverNameKey],
                                            Strings.receiverNumber:
                                                snapshot.data!.docs[index].id,
                                            Strings.senderStatus:
                                                widget.senderStatus
                                          });
                                    },
                                    leading: const CircleAvatar(
                                      backgroundColor:
                                          CustomColors.buttonBackgroundColor,
                                      child: Icon(Icons.person),
                                    ),
                                    title: Text(snapshot.data!.docs[index]
                                        [ModelChat.receiverNameKey]),
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
