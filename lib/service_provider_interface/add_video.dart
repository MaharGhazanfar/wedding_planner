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

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';

import 'aspect_ratio_of_video.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController? _controller;
  List<XFile> videosCollection = [];

  bool isVideo = false;
  VideoPlayerController? _toBeDisposed;
  String? _retrieveDataError;
  final ImagePicker _picker = ImagePicker();

  Future<void> _disposeVideoController() async {
    if (_toBeDisposed != null) {
      await _toBeDisposed!.dispose();
    }
    _toBeDisposed = _controller;
    _controller = null;
  }

  Future<void> _playVideo(XFile? file) async {
    if (file != null && mounted) {
      await _disposeVideoController();
      late VideoPlayerController controller;
      if (kIsWeb) {
        controller = VideoPlayerController.network(file.path);
      } else {
        controller = VideoPlayerController.file(File(file.path));
      }
      _controller = controller;
      const double volume = kIsWeb ? 0.0 : 1.0;
      await controller.setVolume(volume);
      await controller.initialize();
      await controller.setLooping(true);
      await controller.play();
      setState(() {});
    }
  }

  Widget _previewVideo() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_controller == null) {
      return const Text(
        'There are no videos in your collection! \n Please pick from your gallery .',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: CustomColors.buttonBackgroundColor),
        textAlign: TextAlign.center,
      );
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AspectRatioVideo(_controller),
    );
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.video) {
        isVideo = true;
        await _playVideo(response.file);
      }
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller!.setVolume(0.0);
      _controller!.pause();
    }
    super.deactivate();
  }

  Future pickVideo() async {
    try {
      final pickedVideo =
          await ImagePicker().pickVideo(source: ImageSource.gallery);
      if (pickedVideo == null) return;
      await _playVideo(pickedVideo);
      setState(() => videosCollection.add(pickedVideo));
    } on PlatformException catch (e) {
      print('Failed to pick video: $e');
    }
  }

  @override
  void dispose() {
    _disposeVideoController();
    //_controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(
        'dskfhasdjkgfasdhkgasdhjf///////////////${videosCollection}/////////////');
    return Container(
      // decoration: BoxDecoration(
      //   gradient: RadialGradient(
      //       colors: [Colors.tealAccent.shade400, Colors.tealAccent.shade200],
      //       // begin: FractionalOffset(0.0, 0.0),
      //       // end: FractionalOffset(1.0, 0.0),
      //       radius: 0.5,
      //       focalRadius: 0.75,
      //       focal: Alignment(0.7, -0.7),
      //       center: Alignment.topRight,
      //       stops: const [
      //         0.5,
      //         1.0,
      //       ],
      //       tileMode: TileMode.clamp),
      // ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Card(
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 10, right: 10),
                  child: FutureBuilder<void>(
                    future: retrieveLostData(),
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return const Center(
                              child: CircularProgressIndicator(
                            color: CustomColors.buttonBackgroundColor,
                          ));
                        case ConnectionState.done:
                          return ListView.builder(
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              //  _playVideo(videosCollection[index]);
                              return _previewVideo();
                            },
                          );
                        default:
                          if (snapshot.hasError) {
                            return Text(
                              'Pick image/video error: ${snapshot.error}}',
                              textAlign: TextAlign.center,
                            );
                          } else {
                            return const Center(
                              child: Text(
                                'There are no videos in your collection! Please pick from your gallery .',
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          backgroundColor: CustomColors.buttonBackgroundColor,
          elevation: 5,
          onPressed: () {
            pickVideo();
          },
          // icon
          child: const Icon(
            //_controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            Icons.video_collection_rounded,
            color: CustomColors.buttonTextFontColor,
            size: 30,
          ),
        ),
      ),
    );
  }

// Widget build(BuildContext context) {
//   print(
//       'dskfhasdjkgfasdhkgasdhjf///////////////${videosCollection}/////////////');
//   return Scaffold(
//     appBar: AppBar(
//       title: const Text('GeeksForGeeks'),
//       backgroundColor: Colors.green,
//     ),
//     body: videosCollection.isNotEmpty
//         ? ListView.builder(
//       itemCount: videosCollection.length,
//       itemBuilder: (context, index) {
//         _controller =
//             VideoPlayerController.file(videosCollection[index]);
//         _controller!.initialize();
//         _controller!.setLooping(true);
//         _controller!.play();
//         return AspectRatio(
//           aspectRatio: _controller!.value.aspectRatio,
//           child: VideoPlayer(_controller!),
//         );
//       },
//     )
//         : const Center(child: Text('No Videos available yet ')),
//     floatingActionButton: Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         FloatingActionButton(
//           onPressed: () {
//             // setState(() {
//             //   // pause
//             //   if (_controller.value.isPlaying) {
//             //     _controller.pause();
//             //   } else {
//             //     // play
//             //     _controller.play();
//             //   }
//             // });
//             pickVideo();
//           },
//           // icon
//           child: const Icon(
//             //_controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//               Icons.video_collection_rounded),
//         ),
//         // FloatingActionButton(
//         //   onPressed: () {
//         //     setState(() {
//         //       // pause
//         //       if (_controller!.value.isPlaying) {
//         //         _controller!.pause();
//         //       } else {
//         //         // play
//         //         _controller!.play();
//         //       }
//         //     });
//         //   },
//         //   // icon
//         //   child: Icon(
//         //     _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
//         //   ),
//         // ),
//       ],
//     ),
//   );
// }
}
