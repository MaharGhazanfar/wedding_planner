import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

// class AspectRatioVideo extends StatefulWidget {
//   const AspectRatioVideo(this.controller, {Key? key}) : super(key: key);
//
//   final VideoPlayerController? controller;
//
//   @override
//   AspectRatioVideoState createState() => AspectRatioVideoState();
// }
//
// class AspectRatioVideoState extends State<AspectRatioVideo> {
//   VideoPlayerController? get controller => widget.controller;
//   bool initialized = false;
//   double opacity = 0;
//
//   void _onVideoControllerUpdate() {
//     if (!mounted) {
//       return;
//     }
//     if (initialized != controller!.value.isInitialized) {
//       initialized = controller!.value.isInitialized;
//       setState(() {});
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     controller!.addListener(_onVideoControllerUpdate);
//   }
//
//   @override
//   void dispose() {
//     controller!.removeListener(_onVideoControllerUpdate);
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (initialized) {
//       return Center(
//         child: Stack(
//           children: [
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   opacity = 1;
//                   Future.delayed(const Duration(seconds: 1)).then((value) {
//                     setState(() {
//                       opacity = 0;
//                     });
//                   });
//                 });
//               },
//               child: AspectRatio(
//                 //aspectRatio: controller!.value.aspectRatio,
//                 aspectRatio: 1.5,
//                 child: VideoPlayer(
//                   controller!,
//                   key: UniqueKey(),
//                 ),
//               ),
//             ),
//             // Positioned(
//             //   bottom: 2,
//             //   width: MediaQuery.of(context).size.width,
//             //   child: controller!.value.isInitialized
//             //       ? VCaption(controller!)
//             //       : Container(),
//             // ),
//             // Positioned(
//             //     bottom: 10,
//             //     width: MediaQuery.of(context).size.width * 0.85,
//             //     child: VideoProgressIndicator(
//             //       controller!,
//             //       padding: const EdgeInsets.only(left: 5),
//             //       allowScrubbing: true,
//             //       colors: const VideoProgressColors(
//             //           backgroundColor: Colors.blueGrey,
//             //           bufferedColor: Colors.blueGrey,
//             //           playedColor: Colors.redAccent),
//             //     )),
//             // Positioned(
//             //   top: 55,
//             //   left: 120,
//             //   child: Row(
//             //     mainAxisAlignment: MainAxisAlignment.spaceAround,
//             //     children: [
//             //       AnimatedOpacity(
//             //         opacity: opacity,
//             //         duration: const Duration(milliseconds: 700),
//             //         child: IconButton(
//             //             onPressed: () {
//             //               setState(() {
//             //                 // pause
//             //
//             //                 if (controller!.value.isPlaying) {
//             //                   controller!.pause();
//             //                 } else {
//             //                   // play
//             //                   controller!.play();
//             //                 }
//             //                 opacity = 1;
//             //                 Future.delayed(const Duration(seconds: 1))
//             //                     .then((value) {
//             //                   setState(() {
//             //                     opacity = 0;
//             //                   });
//             //                 });
//             //               });
//             //             },
//             //             icon: Icon(
//             //               controller!.value.isPlaying
//             //                   ? Icons.pause
//             //                   : Icons.play_arrow,
//             //               color: CustomColors.buttonBackgroundColor,
//             //               size: 50,
//             //             )),
//             //       )
//             //     ],
//             //   ),
//             // )
//           ],
//         ),
//       );
//     } else {
//       return Container();
//     }
//   }
// }

class VideoItem extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  final bool autoplay;

  const VideoItem(
      {required this.videoPlayerController,
      required this.looping,
      required this.autoplay,
      Key? key})
      : super(key: key);

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight
    // ]);
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      progressIndicatorDelay: Duration(milliseconds: 300),
      // deviceOrientationsAfterFullScreen: [
      //   DeviceOrientation.landscapeLeft,
      //   DeviceOrientation.landscapeRight,
      // ],
      fullScreenByDefault: true,
      overlay: Text('The title of video is blah blah',
          overflow: TextOverflow.ellipsis, maxLines: 2),
      placeholder: Center(child: Text('Loading...')),
      systemOverlaysAfterFullScreen: [SystemUiOverlay.top],
      aspectRatio: 16 / 8,
      autoInitialize: true,
      autoPlay: widget.autoplay,
      looping: widget.looping,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  void deactivate() {
    widget.videoPlayerController.setVolume(0.0);
    widget.videoPlayerController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewieController,
    );
  }
}
