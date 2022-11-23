import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wedding_planner/common_screens/chat/single_item_view.dart';
import '../../modelClasses/model_chat.dart';
import '../../repository/utils/data_constants.dart';
import '../../repository/utils/db_handler.dart';
import 'chat_util.dart';

class ChatScreen extends StatefulWidget {
  final String receiverName;
  final String senderName;
  final String senderNumber;
  final String receiverNumber;
  final String senderStatus;
  final String receiverStatus;

  const ChatScreen(
      {Key? key,
      required this.senderName,
      required this.receiverName,
      required this.senderStatus,
      required this.receiverStatus,
      required this.senderNumber,
      required this.receiverNumber})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  TextEditingController msgController = TextEditingController();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // if (state == AppLifecycleState.resumed) {
    //   print(
    //       '...............................resumed........................................');
    //   updateUserStatus(onlineStatus: ConstValue.onlineStatus);
    // } else {
    //   print(
    //       '...............................dipose........................................');
    //   updateUserStatus(onlineStatus: ConstValue.offlineStatus);
    // }
  }

  @override
  void initState() {
    super.initState();
    // record.hasPermission();
    // WidgetsBinding.instance.addObserver(this);
    // updateUserStatus(onlineStatus: ConstValue.onlineStatus);
    Future.delayed(
      const Duration(),
      () => SystemChannels.textInput.invokeMethod('TextInput.hide'),
    );
    // seenMsgOtherUser(number: widget.number);
  }

  @override
  void dispose() {
    // updateUserStatus(onlineStatus: ConstValue.offlineStatus);
    // WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    // if (player != null) {
    //   player!.release();
    //   player!.dispose();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // if (player != null) {
        //   player!.release();
        //   player!.dispose();
        // }
        // FirebaseFirestore.instance
        //     .collection(ConstValue.userCollection)
        //     .doc(widget.number)
        //     .collection(ConstValue.personalChatCollection)
        //     .doc(ConstValue.prefs!.getString(ConstValue.userNumber)!)
        //     .update({
        //   ModelUserInfoStatus.lastSeenKEy: DateTime.now().toString(),
        //   ModelUserInfoStatus.onlineStatusKEy: ConstValue.offlineStatus
        // });
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.greenish,
          leadingWidth: 30,
          title: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white70,
                child: Icon(
                  Icons.person,
                  color: CustomColors.buttonBackgroundColor,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(widget.receiverName)
            ],
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.menu),
            )
          ],
        ),

        /// body of screen.............................................................................
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Column(
            children: [
              ///     chart portion .............................................................................
              Flexible(
                flex: 9,
                child: StreamBuilder(
                  stream: DBHandler.chatsUserList()
                      .doc(widget.senderNumber)
                      .collection(Strings.personalChat)
                      .doc(widget.receiverNumber)
                      .collection(Strings.messages)
                      .orderBy(ModelChat.sendingTimeKey, descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      return ListView.builder(
                        reverse: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return SingleItemView(
                            snap: snapshot.data!.docs[index].data(),
                            key: UniqueKey(),
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text('There is no Chat'));
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ///     TextField for sending msg  .............................................................................
                  Flexible(
                    flex: 8,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: TextField(
                          controller: msgController,
                          autofocus: true,
                          // onChanged: (value) {
                          //   sendBtnSizeController.textFieldValue.value = value;
                          // },
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          minLines: 1,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Message",
                            suffix: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                    onTap: () {
                                      showSheet(
                                          buildContext: context,
                                          senderName: widget.senderName,
                                          senderStatus: widget.senderStatus,
                                          receiverStatus: widget.receiverStatus,
                                          receiverNumber: widget.receiverNumber,
                                          receiverName: widget.receiverName,
                                          senderNumber: widget.senderNumber,
                                          source: Strings.imageSource);
                                    },
                                    child: const Icon(
                                      Icons.attach_file,
                                      color: Colors.green,
                                    )),
                              ],
                            ),
                            hintStyle: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),

                  ///  send  button for sms ...............................................................
                  Flexible(
                    flex: 2,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: InkWell(
                          onTap: () async {
                            if (msgController.text.isNotEmpty) {
                              sendDataTOServer(
                                  senderName: widget.senderName,
                                  receiverStatus: widget.receiverStatus,
                                  senderStatus: widget.senderStatus,
                                  senderNumber: widget.senderNumber,
                                  receiverNumber: widget.receiverNumber,
                                  receiverName: widget.receiverName,
                                  source: Strings.msgSource,
                                  messageURL: msgController.text.toString());

                              msgController.clear();
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.green, shape: BoxShape.circle),
                            child: const Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        )),
                  ),
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
