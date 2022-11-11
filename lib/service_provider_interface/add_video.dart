// // import 'package:chewie/chewie.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:video_player/video_player.dart';
// //
// // class AddVideo extends StatefulWidget {
// //   const AddVideo({Key? key}) : super(key: key);
// //
// //   @override
// //   State<AddVideo> createState() => _AddVideoState();
// // }
// //
// // class _AddVideoState extends State<AddVideo> {
// //   //late ChewieController controller;
// //   late VideoPlayerController controller;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       child: Chewie(
// //         controller: ChewieController(),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   List<XFile>? images = [];
//
//   Future pickImage() async {
//     try {
//       final pickedImage =
//           await ImagePicker().pickVideo(source: ImageSource.gallery);
//       if (pickedImage == null) return;
//       setState(() => images!.add(pickedImage));
//     } on PlatformException catch (e) {
//       print('Failed to pick image: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blueGrey[100],
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text('Flutter Video Player Demo'),
//         centerTitle: true,
//       ),
//       body: ListView(
//         children: <Widget>[
//           VideoItems(
//             videoPlayerController: VideoPlayerController.file(
//               File(
//                 images![0].path,
//               ),
//             ),
//             looping: true,
//             autoplay: true,
//           ),
//           // VideoItems(
//           //   videoPlayerController: VideoPlayerController.network(
//           //       'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4'),
//           //   looping: false,
//           //   autoplay: true,
//           // ),
//           // VideoItems(
//           //   videoPlayerController: VideoPlayerController.asset(
//           //     'assets/video_3.mp4',
//           //   ),
//           //   looping: false,
//           //   autoplay: false,
//           // ),
//           // VideoItems(
//           //   videoPlayerController: VideoPlayerController.asset(
//           //     'assets/video_2.mp4',
//           //   ),
//           //   looping: false,
//           //   autoplay: true,
//           // ),
//           // VideoItems(
//           //   videoPlayerController: VideoPlayerController.network(
//           //       "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4"),
//           //   looping: true,
//           //   autoplay: false,
//           // ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//           onPressed: () {}, child: Icon(Icons.add_outlined)),
//     );
//   }
// }
//
// class VideoItems extends StatefulWidget {
//   final VideoPlayerController videoPlayerController;
//   final bool looping;
//   final bool autoplay;
//
//   const VideoItems({
//     Key? key,
//     required this.videoPlayerController,
//     required this.looping,
//     required this.autoplay,
//   }) : super(key: key);
//
//   @override
//   State<VideoItems> createState() => _VideoItemsState();
// }
//
// class _VideoItemsState extends State<VideoItems> {
//   late ChewieController _chewieController;
//
//   @override
//   void initState() {
//     super.initState();
//     _chewieController = ChewieController(
//       videoPlayerController: widget.videoPlayerController,
//       aspectRatio: 5 / 8,
//       autoInitialize: true,
//       autoPlay: widget.autoplay,
//       looping: widget.looping,
//       errorBuilder: (context, errorMessage) {
//         return Center(
//           child: Text(
//             errorMessage,
//             style: const TextStyle(color: Colors.white),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Chewie(
//         controller: _chewieController,
//       ),
//     );
//   }
// }

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import 'package:wedding_planner/modelClasses/model_services_photos_videos.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import 'package:wedding_planner/repository/utils/db_handler.dart';

import '../repository/utils/custom_widgets.dart';
import 'video_item.dart';

class VideoPlayerScreen extends StatelessWidget {
  VideoPlayerScreen({Key? key}) : super(key: key);

//   @override
//   _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
// }

// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final bool isLoading = false;
  final ImagePicker _picker = ImagePicker();
  List<XFile> videosCollection = [];

  // late final firebaseStorageRef;
  // late final CollectionReference videosDataCollection;
  final videosDataCollection = DBHandler.videosCollection();
  final firebaseStorageRef = FirebaseStorage.instance.ref();

  // @override
  // void initState() {
  //   super.initState();
  //   videosDataCollection = DBHandler.videosCollection();
  //   firebaseStorageRef = FirebaseStorage.instance.ref();
  // }

  Future<String> uploadVideos(File imageFile) async {
    var random = Random();
    var upload = firebaseStorageRef
        .child('ServicesVideos/${random.nextInt(900000) + 10000000}.MayaRing');
    print('hello');
    await upload.putFile(imageFile);
    return upload.getDownloadURL();
  }

  Future pickVideo() async {
    try {
      final pickedVideo = await _picker.pickVideo(source: ImageSource.gallery);

      if (pickedVideo == null) return;
      var videoUrl = await uploadVideos(File(pickedVideo.path));
      var modelServicesVideos = ModelServicesPhotosAndVideos(url: videoUrl);
      videosDataCollection.doc().set(modelServicesVideos.toMap());
    } on PlatformException catch (e) {
      ShowCustomToast(msg: 'Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Card(
          color: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: StreamBuilder<QuerySnapshot>(
              stream: videosDataCollection.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: const Text('Something went wrong'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> doc = snapshot.data!.docs[index]
                          .data() as Map<String, dynamic>;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 300,
                          width: double.infinity,
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: VideoItem(
                                videoPlayerController:
                                    VideoPlayerController.network(doc[
                                        ModelServicesPhotosAndVideos.urlKey]),
                                looping: false,
                                autoplay: false),
                          ),
                        ),
                      );
                    },
                  );
                }
              })),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.buttonBackgroundColor,
        elevation: 5,
        splashColor: Colors.white70,
        onPressed: () async {
          var status = await Permission.storage.status;

          if (status.isGranted) {
            pickVideo();
          } else if (await Permission.storage.request().isGranted) {
            pickVideo();
          } else {
            ShowCustomToast(msg: 'Permission denied');
          }
        },
        child: const Icon(
          Icons.video_collection_rounded,
          color: CustomColors.buttonTextFontColor,
          size: 30,
        ),
      ),
    );
  }
}
