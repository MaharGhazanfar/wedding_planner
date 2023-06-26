import 'dart:io';
import 'dart:math';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import 'package:wedding_planner/repository/utils/db_handler.dart';
import 'package:wedding_planner/welcome_screens/user_selection_page.dart';
import '../modelClasses/model_personal_login_info.dart';
import '../repository/utils/custom_widgets.dart';
import '../service_provider_interface/personal_info.dart';
import 'package:badges/badges.dart' as badges;

class ProfilePage extends StatefulWidget {
  final String status;

  const ProfilePage({Key? key, required this.status}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final serviceUserCollection;
  String? imageUrl;
  final firebaseStorage = FirebaseStorage.instance.ref();

  Future<String> uploadImage(File imageFile) async {
    var random = Random();

    var upload = firebaseStorage
        .child('ProfileImage/${random.nextInt(900000) + 100000}');

    await upload.putFile(imageFile);
    if (imageUrl!.isNotEmpty) {
      await FirebaseStorage.instance.refFromURL(imageUrl!).delete();
    }

    return upload.getDownloadURL();
  }

  Future pickImage() async {
    try {
      final pickedImage = await ImagePicker().pickImage(
          maxHeight: 800,
          maxWidth: 800,
          imageQuality: 100,
          source: ImageSource.gallery);
      if (pickedImage == null) return;

      imageUrl = await uploadImage(File(pickedImage.path));
      serviceUserCollection
          .doc(DBHandler.user!.uid.toString())
          .update({ModelPersonalLoginInfo.imgUrlKey: imageUrl});
      setState(() {});
    } on PlatformException catch (e) {
      showCustomToast(msg: 'Failed to pick image: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    serviceUserCollection = DBHandler.personalInfoCollectionForServiceUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/white_background.png",
              alignment: Alignment.center, fit: BoxFit.fill),
          StreamBuilder<DocumentSnapshot>(
              stream: serviceUserCollection
                  .doc(DBHandler.user!.uid.toString())
                  .snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }
                ;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  Map<String, dynamic> doc =
                      snapshot.data!.data() as Map<String, dynamic>;
                  imageUrl = doc[ModelPersonalLoginInfo.imgUrlKey];
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: ScreenPadding.topPadding),
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        InkWell(
                          onTap: () async {
                            var status = await Permission.storage.status;

                            if (status.isGranted) {
                              pickImage();
                            } else if (await Permission.storage
                                .request()
                                .isGranted) {
                              pickImage();
                            } else {
                              showCustomToast(msg: 'Permission denied');
                            }
                          },
                          child: badges.Badge(
                            badgeStyle: const badges.BadgeStyle(
                                badgeColor: CustomColors.buttonBackgroundColor),
                            badgeContent: const Icon(
                              Icons.camera_alt,
                              color: CustomColors.greenish,
                            ),
                            position: BadgePosition.topEnd(
                                top: MediaQuery.of(context).size.width * 0.25,
                                end: MediaQuery.of(context).size.width * 0.35),
                            child: Align(
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                radius: mq!.width * .17,
                                backgroundColor: CustomColors.greenish,
                                child: imageUrl!.isNotEmpty
                                    ? CachedNetworkImage(
                                        /*imageBuilder: (context, imageProvider) =>
                                   Container(
                                     width: MediaQuery.of(context).size.width *
                                         0.35,
                                     height:
                                     MediaQuery.of(context).size.width *
                                         0.35,
                                     decoration: BoxDecoration(
                                       shape: BoxShape.circle,
                                       image: DecorationImage(
                                           image: imageProvider,
                                           fit: BoxFit.cover),
                                     ),
                                   ),*/
                                        imageUrl: doc[
                                            ModelPersonalLoginInfo.imgUrlKey],
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      )
                                    : Text(
                                        '${doc[ModelPersonalLoginInfo.firstNameKey].toString().characters.characterAt(0).toUpperCase()}'
                                        '${doc[ModelPersonalLoginInfo.lastNameKey].toString().characters.characterAt(0).toUpperCase()}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.15,
                                            color: CustomColors
                                                .buttonBackgroundColor),
                                      ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: ScreenPadding.topPadding,
                              left: ScreenPadding.leftPadding,
                              right: ScreenPadding.rightPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomWidget.customCardForProfileData(
                                title: 'Name',
                                value:
                                    '${doc[ModelPersonalLoginInfo.firstNameKey] + ' ' + doc[ModelPersonalLoginInfo.lastNameKey]}',
                              ),
                              CustomWidget.customCardForProfileData(
                                title: 'Phone Number',
                                value:
                                    '${doc[ModelPersonalLoginInfo.countryCodeKey]}${doc[ModelPersonalLoginInfo.numberKey]}',
                              ),
                              CustomWidget.customCardForProfileData(
                                title: 'Email',
                                value: DBHandler.user!.email.toString(),
                              ),
                              CustomWidget.customCardForProfileData(
                                title: 'Location',
                                value: doc[ModelPersonalLoginInfo.locationKey],
                              ),
                              Card(
                                elevation: 5,
                                child: ListTile(
                                  onTap: () {
                                    FirebaseAuth.instance.signOut();
                                    ModelPersonalLoginInfo.prefs!.clear();


                                    Navigator.pushReplacementNamed(
                                        context, UserSelectionPage.pageName);
                                  },
                                  contentPadding: const EdgeInsets.only(
                                      left: 24.0, right: 24),
                                  title: const Text(
                                    'Log Out',
                                  ),
                                  trailing: const Icon(
                                    Icons.logout,
                                    color: CustomColors.textFontColor,
                                  ),
                                  tileColor: Colors.white10,
                                ),
                              ),
                              Card(
                                elevation: 5,
                                child: ListTile(
                                  contentPadding: const EdgeInsets.only(
                                      left: 24.0, right: 24),
                                  title: const Text(
                                    'Edit Your Profile',
                                  ),
                                  trailing: const Icon(
                                    Icons.edit,
                                    color: CustomColors.textFontColor,
                                  ),
                                  onTap: () {
                                    print('${widget.status}///////');
                                    Navigator.pushNamed(
                                        context, PersonalInfoPage.pageName,
                                        arguments: {
                                          Strings.status: widget.status,
                                          Strings.mode: Strings.editMode,
                                          Strings.doc: doc
                                        });
                                  },
                                ),
                              ),
                              const Divider(
                                thickness: 2,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: ScreenPadding.topPadding,
                                    left: ScreenPadding.leftPadding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'RATE ON PLAY STORE',
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 24.0),
                                      child: Text(
                                        'SEND US FEEDBACK',
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 24.0),
                                      child: Text(
                                        'SHARE THIS APP',
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 24.0),
                                      child: Text(
                                        'PRIVACY POLICY',
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
