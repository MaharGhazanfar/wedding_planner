import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wedding_planner/common_screens/blogs/blog_details.dart';
import 'package:wedding_planner/common_screens/blogs/create_blog.dart';
import 'package:wedding_planner/modelClasses/model_blog_post.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';

import '../../repository/utils/db_handler.dart';

class BlogsPage extends StatefulWidget {
  static const pageName = '/BlogsPage';
  const BlogsPage({Key? key}) : super(key: key);

  @override
  State<BlogsPage> createState() => _BlogsPageState();
}

class _BlogsPageState extends State<BlogsPage> {
  late final CollectionReference blogPostCollection;

  @override
  void initState() {
    super.initState();
    blogPostCollection = DBHandler.blogsPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: CustomColors.greenish,
        leading: IconButton(
            padding: const EdgeInsets.only(top: 8, left: 16),
            alignment: Alignment.topLeft,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: CustomColors.backGroundColor,
            )),
        title: Text(
          'News Feeds',
          style: TextStyle(color: CustomColors.backGroundColor),
        ),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/white_background.png",
              alignment: Alignment.center, fit: BoxFit.fill),
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: StreamBuilder<QuerySnapshot>(
                stream: blogPostCollection.snapshots(),
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
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            height: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: CustomColors.backGroundColor,
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
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.only(left: 0, top: 0, bottom: 0),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => BlogDetails(
                                      map: doc,
                                    ),
                                  ),
                                );
                              },
                              leading: Card(
                                color: Colors.black38,
                                child: CachedNetworkImage(
                                  imageUrl: doc[ModelBlogPost.keyBlogImageUrl],
                                  width: 70,
                                  height: 100,
                                  colorBlendMode: BlendMode.colorDodge,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  doc[ModelBlogPost.keyBlogTitle],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              dense: false,
                              subtitle: Text(doc[ModelBlogPost.keyBlogBody],
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.buttonBackgroundColor,
        isExtended: true,
        onPressed: () {
         Navigator.pushNamed(context, CreateBlog.pageName);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
