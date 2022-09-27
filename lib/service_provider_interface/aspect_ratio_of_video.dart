import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';

class AspectRatioVideo extends StatefulWidget {
  const AspectRatioVideo(this.controller, {Key? key}) : super(key: key);

  final VideoPlayerController? controller;

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController? get controller => widget.controller;
  bool initialized = false;
  double opacity = 0;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
    if (initialized != controller!.value.isInitialized) {
      initialized = controller!.value.isInitialized;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controller!.addListener(_onVideoControllerUpdate);
  }

  @override
  void dispose() {
    controller!.removeListener(_onVideoControllerUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  opacity = 1;
                  Future.delayed(const Duration(seconds: 1)).then((value) {
                    setState(() {
                      opacity = 0;
                    });
                  });
                });
              },
              child: AspectRatio(
                //aspectRatio: controller!.value.aspectRatio,
                aspectRatio: 1.5,
                child: VideoPlayer(
                  controller!,
                  key: UniqueKey(),
                ),
              ),
            ),
            // Positioned(
            //   bottom: 2,
            //   width: MediaQuery.of(context).size.width,
            //   child: controller!.value.isInitialized
            //       ? VCaption(controller!)
            //       : Container(),
            // ),
            Positioned(
                bottom: 10,
                width: MediaQuery.of(context).size.width * 0.85,
                child: VideoProgressIndicator(
                  controller!,
                  padding: const EdgeInsets.only(left: 5),
                  allowScrubbing: true,
                  colors: const VideoProgressColors(
                      backgroundColor: Colors.blueGrey,
                      bufferedColor: Colors.blueGrey,
                      playedColor: Colors.redAccent),
                )),
            Positioned(
              top: 55,
              left: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AnimatedOpacity(
                    opacity: opacity,
                    duration: const Duration(milliseconds: 700),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            // pause

                            if (controller!.value.isPlaying) {
                              controller!.pause();
                            } else {
                              // play
                              controller!.play();
                            }
                            opacity = 1;
                            Future.delayed(const Duration(seconds: 1))
                                .then((value) {
                              setState(() {
                                opacity = 0;
                              });
                            });
                          });
                        },
                        icon: Icon(
                          controller!.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: CustomColors.buttonBackgroundColor,
                          size: 50,
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
