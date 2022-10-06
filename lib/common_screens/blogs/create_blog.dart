import 'package:flutter/material.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';

import '../../repository/utils/custom_widgets.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({Key? key}) : super(key: key);

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: CustomColors.headingTextFontColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ),
          backgroundColor: CustomColors.appBarColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                Container(
                  width: double.infinity,
                  height: 250,
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
                  child: const Icon(
                    Icons.photo_camera,
                    size: 150,
                    color: CustomColors.buttonBackgroundColor,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomWidget.customTextField3(
                    context: context, titleName: 'Blog Title'),
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
                  child: const TextField(
                    // controller: aboutController,
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
                GestureDetector(
                  onTap: () async {},
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
                            child: Text('Create',
                                style: ButtonsStyle.buttonTextStyle(context))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
