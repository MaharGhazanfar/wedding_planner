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

import '../modelClasses/model_personal_login_info.dart';
import '../repository/utils/custom_widgets.dart';
import '../service_provider_interface/personal_info.dart';

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
      ShowCustomToast(msg: 'Failed to pick image: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    serviceUserCollection = DBHandler.personalInfoCollectionForServiceUser();
  }

  @override
  Widget build(BuildContext context) {
    print('sdasjkhgkljbuild cALled');
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
                  return Center(child: const Text('Something went wrong'));
                }
                ;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  Map<String, dynamic> doc =
                      snapshot.data!.data() as Map<String, dynamic>;
                  imageUrl = doc[ModelPersonalLoginInfo.imgUrlKey];
                  return Padding(
                    padding: const EdgeInsets.only(top: ScreenPading.topPading),
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 24.0, bottom: 8),
                          child: InkWell(
                            onTap: () async {
                              var status = await Permission.storage.status;

                              if (status.isGranted) {
                                pickImage();
                              } else if (await Permission.storage
                                  .request()
                                  .isGranted) {
                                pickImage();
                              } else {
                                ShowCustomToast(msg: 'Permission denied');
                              }
                            },
                            child: Badge(
                              badgeColor: CustomColors.buttonBackgroundColor,
                              badgeContent: Icon(Icons.camera_enhance),
                              position: BadgePosition.topEnd(
                                  top: MediaQuery.of(context).size.width * 0.25,
                                  end:
                                      MediaQuery.of(context).size.width * 0.35),
                              child: imageUrl!.isNotEmpty
                                  ? CachedNetworkImage(
                                      //fit: BoxFit.scaleDown,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                      ),
                                      imageUrl:
                                          doc[ModelPersonalLoginInfo.imgUrlKey],
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    )
                                  : Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.35,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        color: Colors.white60,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
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
                        // Align(
                        //   alignment: Alignment.topCenter,
                        //   child: Text(
                        //     'Edit',
                        //     style: GoogleFonts.tinos(
                        //       textStyle: const TextStyle(
                        //           fontWeight: FontWeight.bold,
                        //           color: Colors.black,
                        //           fontSize: 14),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: ScreenPading.topPading,
                              left: ScreenPading.leftPading,
                              right: ScreenPading.rightPading),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                child: ListTile(
                                  contentPadding:
                                      EdgeInsets.only(left: 24.0, right: 24),
                                  title: Text(
                                    'Name :',
                                  ),
                                  trailing: Text(
                                      '${doc[ModelPersonalLoginInfo.firstNameKey] + ' ' + doc[ModelPersonalLoginInfo.lastNameKey]}',
                                      style: TextStyle(
                                          color: CustomColors.textFontColor)),
                                ),
                              ),
                              Card(
                                child: ListTile(
                                  contentPadding:
                                      EdgeInsets.only(left: 24.0, right: 24),
                                  title: Text(
                                    'Mobile :',
                                  ),
                                  trailing: Text(
                                      doc[ModelPersonalLoginInfo.numberKey],
                                      style: TextStyle(
                                          color: CustomColors.textFontColor)),
                                ),
                              ),
                              Card(
                                child: ListTile(
                                  contentPadding:
                                      EdgeInsets.only(left: 24.0, right: 24),
                                  title: Text(
                                    'Email :',
                                  ),
                                  trailing: Text(
                                      DBHandler.user!.email.toString(),
                                      style: TextStyle(
                                          color: CustomColors.textFontColor)),
                                ),
                              ),
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 24.0),
                                  child: TextFormField(
                                    initialValue:
                                        'Location :\n    ${doc[ModelPersonalLoginInfo.locationKey]}',
                                    style: TextStyle(
                                        color: CustomColors.textFontColor),
                                    readOnly: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                    maxLines: 3,
                                    minLines: 1,
                                  ),
                                ),
                              ),
                              Card(
                                child: ListTile(
                                  onTap: () {
                                    FirebaseAuth.instance.signOut();
                                  },
                                  contentPadding:
                                      EdgeInsets.only(left: 24.0, right: 24),
                                  title: Text(
                                    'Log Out',
                                  ),
                                  trailing: Icon(
                                    Icons.logout,
                                    color: CustomColors.textFontColor,
                                  ),
                                  tileColor: Colors.white10,
                                ),
                              ),
                              Card(
                                child: ListTile(
                                  contentPadding:
                                      EdgeInsets.only(left: 24.0, right: 24),
                                  title: Text(
                                    'Edit Your Profile',
                                  ),
                                  onTap: () {
                                    print('${widget.status}///////');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PersonalInfoPage(
                                            status: widget.status,
                                            mode: Strings.editMode,
                                            doc: doc,
                                          ),
                                        ));
                                  },
                                ),
                              ),
                              const Divider(
                                thickness: 2,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: ScreenPading.topPading,
                                    left: ScreenPading.leftPading),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
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
