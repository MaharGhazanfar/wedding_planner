import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageDetail extends StatefulWidget {
  final String imgPath;

  const ImageDetail({Key? key, required this.imgPath}) : super(key: key);

  @override
  State<ImageDetail> createState() => _ImageDetailState();
}

class _ImageDetailState extends State<ImageDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text('Your Image'),
      ),
      body: Center(
        child: Card(
            child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.7,
          child: Image.file(
            File(widget.imgPath),
            fit: BoxFit.fill,
          ),
        )),
      ),
    );
  }
}
