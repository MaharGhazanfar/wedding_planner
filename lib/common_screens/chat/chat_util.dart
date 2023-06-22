import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../modelClasses/model_chat.dart';
import '../../repository/utils/data_constants.dart';
import '../../repository/utils/db_handler.dart';

void showSheet({
  required BuildContext buildContext,
  required String senderNumber,
  required String senderName,
  required String senderStatus,
  required String receiverStatus,
  required String receiverNumber,
  required String receiverName,
  required String source,
}) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: buildContext,
    builder: (context) => SizedBox(
      height: 160,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            CustomColors.buttonBackgroundColor)),
                    onPressed: () {
                      Navigator.pop(context);
                      mediaImageUploading(
                          senderName: senderName,
                          senderNumber: senderNumber,
                          receiverStatus: receiverStatus,
                          senderStatus: senderStatus,
                          receiverNumber: receiverNumber,
                          receiverName: receiverName,
                          source: source,
                          mediaImageSource: ImageSource.gallery,
                          context: buildContext);
                    },
                    child: const Text('Image')),
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              CustomColors.buttonBackgroundColor)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'))),
            ],
          ),
        ),
      ),
    ),
  );
}

Future<void> mediaImageUploading({
  required String senderNumber,
  required String receiverNumber,
  required String receiverName,
  required String senderName,
  required String source,
  required String senderStatus,
  required String receiverStatus,
  required ImageSource mediaImageSource,
  required BuildContext context,
}) async {
  File imageFile = await pickImageFromMedia(mediaImageSource);
  () {
    LoadingForUpload.onLoading(context);
  }();

  String imageUrl = await uploadFileToFireStorage(path: imageFile.path);

  () {
    LoadingForUpload.hideDialog(context);
  }();
  sendDataTOServer(
      senderName: senderName,
      senderStatus: senderStatus,
      receiverStatus: receiverStatus,
      senderNumber: senderNumber,
      source: Strings.imageSource,
      messageURL: imageUrl,
      receiverName: receiverName,
      receiverNumber: receiverNumber);
}

final storageRef = FirebaseStorage.instance.ref();

Future<String> uploadFileToFireStorage({
  required String path,
}) async {
  File file = File(path);

  var url = '';
  try {
    var upload = await storageRef
        .child('Chat/')
        .child('${DateTime.now().millisecondsSinceEpoch}')
        .putFile(file);
    var snap = upload;

    url = await snap.ref.getDownloadURL();
  } on FirebaseException catch (e) {
    print(e);
  }

  return url;
}

Future<File> pickImageFromMedia(
  ImageSource imageSource,
) async {
  File? image;

  final ImagePicker picker = ImagePicker();

  final XFile? photo = await picker.pickImage(
      source: imageSource, maxHeight: 600, maxWidth: 600);

  image = File(photo!.path);

  return image;
}

Future<void> sendDataTOServer({
  required String senderNumber,
  required String senderStatus,
  required String receiverStatus,
  required String receiverNumber,
  required String receiverName,
  required String senderName,
  required String source,
  required String messageURL,
}) async {
  var msgSendByMe = ModelChat(
    receiverNumber: receiverNumber,
    msg: source == Strings.msgSource ? messageURL : '',
    URL: source == Strings.imageSource ? messageURL : '',
    deliveryTime: DateTime.now().toString(),
    isSendByMe: Strings.online,
    sendingTime: DateTime.now().toString(),
    sendingNumber: senderNumber,
  );
  DBHandler.chatsUserList()
      .doc(senderNumber)
      .collection(Strings.personalChat)
      .doc(receiverNumber)
      .collection(Strings.messages)
      .add(msgSendByMe.toMap());

  DBHandler.chatsUserList()
      .doc(senderNumber)
      .collection(Strings.personalChat)
      .doc(receiverNumber)
      .set({
    ModelChat.receiverStatusKey: receiverStatus,
    ModelChat.receiverNameKey: receiverName,
  });
  var msgSendForYou = ModelChat(
    receiverNumber: receiverNumber,
    msg: source == Strings.msgSource ? messageURL : '',
    URL: source == Strings.imageSource ? messageURL : '',
    isSendByMe: Strings.offline,
    deliveryTime: DateTime.now().toString(),
    sendingTime: DateTime.now().toString(),
    sendingNumber: senderNumber,
  );
  DBHandler.chatsUserList()
      .doc(receiverNumber)
      .collection(Strings.personalChat)
      .doc(senderNumber)
      .collection(Strings.messages)
      .add(msgSendForYou.toMap());

  DBHandler.chatsUserList()
      .doc(receiverNumber)
      .collection(Strings.personalChat)
      .doc(senderNumber)
      .set({
    ModelChat.receiverStatusKey: senderStatus,
    ModelChat.receiverNameKey: senderName // sp
  });
}

class LoadingForUpload {
  static onLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const CupertinoActivityIndicator(
          radius: 30,
          color: Colors.black87,
        );
      },
    );
  }

  static hideDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
