import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';

import '../../modelClasses/model_blog_post.dart';

class BlogDetails extends StatefulWidget {
  final Map<String, dynamic> map;

  const BlogDetails({required this.map, Key? key}) : super(key: key);

  @override
  State<BlogDetails> createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/signup.png",
              alignment: Alignment.center, fit: BoxFit.fill),
          Padding(
            padding: const EdgeInsets.only(
              top: 30,
            ),
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          child: CachedNetworkImage(
                            imageUrl: widget.map[ModelBlogPost.keyBlogImageUrl],
                            //width: 70,

                            colorBlendMode: BlendMode.colorDodge,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.fill,
                          ),
                        ),
                        // Positioned(
                        //     bottom: 10,
                        //     left: 20,
                        //     child: Text(
                        //       widget.map[ModelBlogPost.keyBlogTitle],
                        //       style: TextStyle(
                        //           color: CustomColors.buttonBackgroundColor,
                        //           fontWeight: FontWeight.bold,
                        //           fontSize: 25),
                        //     ))
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.map[ModelBlogPost.keyBlogTitle],
                      maxLines: 2,
                      style: TextStyle(
                          color: CustomColors.buttonBackgroundColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: SizedBox(
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 32.0, top: 12, right: 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.map[ModelBlogPost.keyBlogBody],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
          Positioned(
              top: 24,
              left: 6,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ))),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: CustomColors.buttonBackgroundColor,
          onPressed: () {},
          child: const Icon(Icons.favorite_border)),
    );
  }
}
