import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';

import '../../modelClasses/model_blog_post.dart';
import '../../repository/utils/custom_widgets.dart';
import '../../repository/utils/db_handler.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({Key? key}) : super(key: key);

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  bool isLoading = false;
  var stringUrl;
  late XFile? pickedImage = null;
  late final firebaseStorageRef;
  late final CollectionReference blogPostCollection;
  late TextEditingController blogTitleController;
  late TextEditingController blogBodyController;

  @override
  void initState() {
    super.initState();
    blogPostCollection = DBHandler.blogsPost();
    firebaseStorageRef = FirebaseStorage.instance.ref();
    blogTitleController = TextEditingController();
    blogBodyController = TextEditingController();
  }

  Future<String> uploadImage(File imageFile) async {
    var random = Random();
    var upload =
        firebaseStorageRef.child('BlogPost/${random.nextInt(900000) + 100000}');

    await upload.putFile(imageFile);

    return upload.getDownloadURL();
  }

  Future pickImage() async {
    try {
      pickedImage = await ImagePicker().pickImage(
          maxHeight: 800,
          maxWidth: 800,
          imageQuality: 100,
          source: ImageSource.gallery);
      //if (pickedImage == null) return;
      setState(() {});
    } on PlatformException catch (e) {
      ShowCustomToast(msg: 'Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Image.asset("assets/images/signup.png",
              alignment: Alignment.center, fit: BoxFit.fill),
          Padding(
            padding: const EdgeInsets.only(
                top: ScreenPading.topPading,
                left: ScreenPading.leftPading,
                right: ScreenPading.rightPading),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    padding: EdgeInsets.only(
                      top: 8,
                    ),
                    alignment: Alignment.topLeft,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: CustomColors.backGroundColor,
                    )),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Create your Blog\n here...!',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.headingTextFontColor),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  splashColor: Colors.white,
                  onTap: () async {
                    var status = await Permission.storage.status;

                    if (status.isGranted) {
                      pickImage();
                    } else if (await Permission.storage.request().isGranted) {
                      pickImage();
                    } else {
                      ShowCustomToast(msg: 'Permission denied');
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.09),
                            offset: const Offset(
                              0.1,
                              1.5,
                            ),
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.09),
                            offset: const Offset(
                              -0.1,
                              -0.001,
                            ),
                            spreadRadius: -1,
                          ),
                        ]),
                    child: pickedImage == null
                        ? const Icon(
                            Icons.photo_camera,
                            size: 150,
                            color: CustomColors.buttonBackgroundColor,
                          )
                        : Image.file(
                            File(pickedImage!.path),
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomWidget.customTextField3(
                    controller: blogTitleController,
                    context: context,
                    titleName: 'Blog Title'),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.09),
                          offset: const Offset(
                            0.1,
                            1.5,
                          ),
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.09),
                          offset: const Offset(
                            -0.1,
                            -0.001,
                          ),
                          spreadRadius: -1,
                        ),
                      ]),
                  child: TextField(
                    controller: blogBodyController,
                    maxLines: 10,
                    minLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Write your blog here',
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  splashColor: Colors.white,
                  onTap: () async {
                    if (pickedImage != null) {
                      if (blogTitleController.text.isNotEmpty &&
                          blogBodyController.text.isNotEmpty) {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          isLoading = true;
                        });
                        stringUrl = await uploadImage(File(pickedImage!.path));
                        var modelBlogPost = ModelBlogPost(
                            blogImageUrl: stringUrl,
                            blogTitle: blogTitleController.text,
                            blogBody: blogBodyController.text);
                        blogPostCollection
                            .doc()
                            .set(modelBlogPost.toMap())
                            .whenComplete(() {
                          ShowCustomToast(
                              msg: "Your blog is created successfully");

                          setState(() {
                            pickedImage = null;
                            blogTitleController.clear();
                            blogBodyController.clear();
                            isLoading = false;
                          });
                        });
                        // Navigator.pop(context);
                      } else {
                        ShowCustomToast(msg: "All Field Must Be Filled");
                      }
                    } else {
                      ShowCustomToast(
                          msg: "Please tap on the camera icon to pick image");
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.5,
                            decoration: BoxDecoration(
                                color: CustomColors.buttonBackgroundColor,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.06),
                                      offset: const Offset(
                                        0,
                                        2,
                                      ),
                                      spreadRadius: 3,
                                      blurRadius: 1),
                                ]),
                            child: Text(isLoading ? 'uploading...' : 'Create',
                                style: ButtonsStyle.buttonTextStyle(context))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
