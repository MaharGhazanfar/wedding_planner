
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

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
      //progressIndicatorDelay: Duration(milliseconds: 300),
      // deviceOrientationsAfterFullScreen: [
      //   DeviceOrientation.landscapeLeft,
      //   DeviceOrientation.landscapeRight,
      // ],
      fullScreenByDefault: true,
      overlay: const Text('The title of video is blah blah',
          overflow: TextOverflow.ellipsis, maxLines: 2),
      placeholder: const Center(child: Text('Loading...')),
      systemOverlaysAfterFullScreen: [SystemUiOverlay.top],
      aspectRatio: 16 / 8,
      autoInitialize: true,
      autoPlay: widget.autoplay,
      looping: widget.looping,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
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
