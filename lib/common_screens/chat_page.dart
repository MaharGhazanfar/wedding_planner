import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');

  @override
  void initState() {
    super.initState();
    // _loadMessages();
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.buttonBackgroundColor,
          leadingWidth: 30,
          // leading: IconButton(
          //     padding: EdgeInsets.only(left: 10),
          //     icon: Icon(
          //       Icons.arrow_back_ios,
          //       color: CustomColors.backGroundColor,
          //     ),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     }),
          title: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.white70,
                child: Icon(Icons.person),
              ),
              const SizedBox(
                width: 15,
              ),
              Text('Name')
            ],
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.menu),
            )
          ],
        ),
        body: Chat(
            timeFormat: DateFormat(),
            messages: _messages,

            // theme:    ChatTheme(backgroundColor: Colors.white70,
            //     attachmentButtonIcon: Icon(Icons.attachment_outlined),
            //     attachmentButtonMargin: EdgeInsets.all(0),
            //     dateDividerMargin: EdgeInsets.zero,
            //
            //     dateDividerTextStyle: TextStyle(),
            //     deliveredIcon: Icon(Icons.send),
            //     documentIcon: null,
            //     errorColor: Colors.red,
            //     emptyChatPlaceholderTextStyle: TextStyle(),
            //     errorIcon: Icon(Icons.error_outline),
            //
            //     inputBackgroundColor: Colors.black,inputBorderRadius: BorderRadius.
            //     zero, inputMargin:EdgeInsets.all(0.0),
            // inputPadding: EdgeInsets.zero,
            // inputTextColor: Colors.blue,
            // inputTextDecoration: InputDecoration(filled: true),
            // inputTextStyle: TextStyle(),
            //   messageBorderRadius: 5.0,messageInsetsHorizontal: 0.0,messageInsetsVertical: 0.0,primaryColor: Colors.green,
            //   receivedEmojiMessageTextStyle: TextStyle(),receivedMessageBodyTextStyle: TextStyle(),receivedMessageCaptionTextStyle: TextStyle(),receivedMessageDocumentIconColor: Colors.transparent,receivedMessageLinkDescriptionTextStyle: TextStyle(),receivedMessageLinkTitleTextStyle: TextStyle(),secondaryColor: Colors.green,seenIcon:Icon(Icons.emoji_emotions,),sendButtonIcon: Icon(Icons.send),sendButtonMargin: EdgeInsets.zero,sendingIcon: Icon(Icons.airplanemode_active),sentEmojiMessageTextStyle:TextStyle(),sentMessageBodyTextStyle: TextStyle(),sentMessageCaptionTextStyle: TextStyle(),sentMessageDocumentIconColor: Colors.lightGreen,sentMessageLinkDescriptionTextStyle: TextStyle(),
            //   sentMessageLinkTitleTextStyle: TextStyle(),statusIconPadding: EdgeInsets.zero,userAvatarImageBackgroundColor: Colors.green,userAvatarNameColors:[Colors.green,Colors.orange,Colors.pink],userAvatarTextStyle: TextStyle(),userNameTextStyle: TextStyle(),
            // ),
        onAttachmentPressed: _handleAtachmentPressed,
        onMessageTap: _handleMessageTap,
        onPreviewDataFetched: _handlePreviewDataFetched,
        onSendPressed: _handleSendPressed,
        showUserAvatars: true,
        showUserNames: true,
        user: _user,
      )

  ,

  );

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) =>
          SafeArea(
            child: SizedBox(
              height: 144,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _handleImageSelection();
                    },
                    child: const Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text('Photo'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _handleFileSelection();
                    },
                    child: const Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text('File'),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text('Cancel'),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: _user,
        createdAt: DateTime
            .now()
            .millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: result.files.single.path!,
        //lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      _addMessage(message);
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime
            .now()
            .millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
          _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
          (_messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';
          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
          _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
          (_messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });
        }
      }
      print('$localPath//////////////////////////');
      await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(types.TextMessage message,
      types.PreviewData previewData,) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime
          .now()
          .millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  void _loadMessages() async {
    final response = await rootBundle.loadString('assets/messages.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();

    setState(() {
      _messages = messages;
    });
  }
}
