import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wedding_planner/modelClasses/model_services_photos_videos.dart';
import 'package:wedding_planner/repository/utils/custom_widgets.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import 'package:wedding_planner/service_provider_interface/image_details.dart';

import '../repository/utils/db_handler.dart';

class AddImages extends StatefulWidget {
  const AddImages({Key? key}) : super(key: key);

  @override
  State<AddImages> createState() => _AddImagesState();
}

class _AddImagesState extends State<AddImages> {
  List<String>? images = [];
  double? width;
  double? height;
  bool isLoading = false;
  late final firebaseStorageRef;
  late final CollectionReference photosCollection;

  @override
  void initState() {
    super.initState();
    photosCollection = DBHandler.photosCollection();

    firebaseStorageRef = FirebaseStorage.instance.ref();
  }

  Future<String> uploadImage(File imageFile) async {
    var random = Random();

    var upload = firebaseStorageRef
        .child('ServicesPhotos/${random.nextInt(900000) + 100000}');

    await upload.putFile(imageFile);

    return upload.getDownloadURL();
  }

  Future pickMultiImage() async {
    try {
      final pickedMultiImage = await ImagePicker()
          .pickMultiImage(maxHeight: 800, maxWidth: 800, imageQuality: 100);
      if (pickedMultiImage == null) return;

      for (int i = 0; i < pickedMultiImage.length; i++) {
        setState(() {
          isLoading = true;
        });
        var stringUrl = await uploadImage(File(pickedMultiImage[i].path));
        var modelServicesImages = ModelServicesPhotosAndVideos(url: stringUrl);
        photosCollection.doc().set(modelServicesImages.toMap());
        images!.add(stringUrl);
      }
      setState(() {
        isLoading = false;
      });
    } on PlatformException catch (e) {
      ShowCustomToast(msg: 'Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: CustomColors.backGroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/signup.png",
              alignment: Alignment.center, fit: BoxFit.fill),
          Padding(
            padding: const EdgeInsets.only(
                left: ScreenPading.leftPading, right: ScreenPading.rightPading),
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                    color: CustomColors.buttonBackgroundColor,
                  ))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: IconButton(
                            padding: EdgeInsets.only(top: 8),
                            alignment: Alignment.topLeft,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: CustomColors.backGroundColor,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Text(
                          'Add your service Photos \ncollection here...',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.headingTextFontColor),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                          ),
                          child: StreamBuilder<QuerySnapshot>(
                            stream: photosCollection.snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: const Text('Something went wrong'),
                                );
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else {
                                return GridView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 3),
                                  itemBuilder: (context, index) {
                                    Map<String, dynamic> doc =
                                        snapshot.data!.docs[index].data()
                                            as Map<String, dynamic>;
                                    images!.add(doc[
                                        ModelServicesPhotosAndVideos.urlKey]);
                                    return Card(
                                      elevation: 3,
                                      child: snapshot.data!.docs.isEmpty
                                          ? GestureDetector(
                                              onTap: () =>
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                              backgroundColor:
                                                                  Colors.green,
                                                              content: Text(
                                                                'No image added yet',
                                                              ))),
                                              child: const Icon(
                                                Icons.camera_alt_sharp,
                                                size: 100,
                                                color: Colors.black26,
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ImageDetail(
                                                              imgPath: doc[
                                                                  ModelServicesPhotosAndVideos
                                                                      .urlKey]),
                                                    )),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.fill,
                                                  imageUrl: doc[
                                                      ModelServicesPhotosAndVideos
                                                          .urlKey],
                                                  placeholder: (context, url) =>
                                                      Center(
                                                          child:
                                                              CircularProgressIndicator()),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.white70,
        elevation: 5,
        onPressed: () async {
          var status = await Permission.storage.status;

          if (status.isGranted) {
            pickMultiImage();
          } else if (await Permission.storage.request().isGranted) {
            pickMultiImage();
          } else {
            ShowCustomToast(msg: 'Permission denied');
          }
        },
        heroTag: 'image',
        tooltip: 'Pick Images from gallery',
        backgroundColor: CustomColors.buttonBackgroundColor,
        child: const Icon(Icons.photo_library),
      ),
    );
  }
}
