import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';

class ImageDetail extends StatefulWidget {
  final String imgPath;

  const ImageDetail({Key? key, required this.imgPath}) : super(key: key);

  @override
  State<ImageDetail> createState() => _ImageDetailState();
}

class _ImageDetailState extends State<ImageDetail> {
  @override
  Widget build(BuildContext context) {
    //We are fetching multiple photos in this screen
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: PhotoView(
                imageProvider: FileImage(
                  File(widget.imgPath),
                ),
                // child: Image.file(
                //   File(widget.imgPath),
                //   fit: BoxFit.fill,
                // ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 30,
                color: CustomColors.backGroundColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
