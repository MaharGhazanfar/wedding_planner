import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wedding_planner/modelClasses/model_chat.dart';

import '../../repository/utils/data_constants.dart';

class SingleItemView extends StatefulWidget {
  final Map<String, dynamic> snap;

  const SingleItemView({Key? key, required this.snap}) : super(key: key);

  @override
  State<SingleItemView> createState() => _SingleItemViewState();
}

class _SingleItemViewState extends State<SingleItemView> {
  // var isPlaying = false;
  // var durationAudio = Duration.zero;
  // var positionAudio = Duration.zero;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.snap[ModelChat.isSendByMeKey] == Strings.online
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          constraints: BoxConstraints.tightFor(
              width: widget.snap[ModelChat.URLKey].toString().isNotEmpty
                  ? MediaQuery.of(context).size.width * .65
                  : widget.snap[ModelChat.msgKey].toString().length < 5
                      ? MediaQuery.of(context).size.width * .2
                      : widget.snap[ModelChat.msgKey].toString().length < 15
                          ? MediaQuery.of(context).size.width * .4
                          : MediaQuery.of(context).size.width * .7),
          decoration: BoxDecoration(
              color: widget.snap[ModelChat.isSendByMeKey] == Strings.online
                  ? Colors.green
                  : Colors.blue,
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 4, left: 5, right: 5, bottom: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.snap[ModelChat.msgKey] != ''
                    ? Text(
                        widget.snap[ModelChat.msgKey],
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      )
                    : CachedNetworkImage(
                        imageUrl: widget.snap[ModelChat.URLKey],
                        height: 250,
                        alignment: Alignment.center,
                        imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                        placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                        errorWidget: (context, url, error) => const Icon(
                              Icons.camera_alt,
                              size: 100,
                              color: Colors.grey,
                            )),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        DateFormat.jm().format(
                          DateTime.parse(widget.snap[ModelChat.sendingTimeKey]),
                        ),
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      // widget.snap[ModelMsgSend.isSendByMeKey] ==
                      //         ConstValue.onlineStatus
                      //     ? Padding(
                      //         padding: const EdgeInsets.only(left: 3.0),
                      //         child: widget.snap[ModelMsgSend.seenStatusKey] ==
                      //                 ConstValue.statusSend
                      //             ? const Icon(
                      //                 Icons.check,
                      //                 color: Colors.white,
                      //                 size: 16,
                      //               )
                      //             : Padding(
                      //                 padding:
                      //                     const EdgeInsets.only(bottom: 3.0),
                      //                 child: Stack(
                      //                   children: [
                      //                     Icon(
                      //                       Icons.check,
                      //                       color: widget.snap[ModelMsgSend
                      //                                   .seenStatusKey] ==
                      //                               ConstValue.statusSeen
                      //                           ? Colors.cyanAccent
                      //                           : Colors.white,
                      //                       size: 16,
                      //                     ),
                      //                     Positioned(
                      //                       top: 4,
                      //                       child: Icon(
                      //                         Icons.check,
                      //                         color: widget.snap[ModelMsgSend
                      //                                     .seenStatusKey] ==
                      //                                 ConstValue.statusSeen
                      //                             ? Colors.cyanAccent
                      //                             : Colors.white,
                      //                         size: 16,
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ))
                      //     : const SizedBox()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
