import 'package:flutter/material.dart';
import 'package:wedding_planner/common_screens/blogs/blog_details.dart';
import 'package:wedding_planner/common_screens/blogs/create_blog.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';

class BlogsPage extends StatefulWidget {
  const BlogsPage({Key? key}) : super(key: key);

  @override
  State<BlogsPage> createState() => _BlogsPageState();
}

class _BlogsPageState extends State<BlogsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: CustomColors.greenish,
        leading: IconButton(
            padding: EdgeInsets.only(top: 8, left: 16),
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
          // Padding(
          //   padding: const EdgeInsets.only(top: ScreenPading.topPading),
          //   child: Row(
          //     //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [Text('News Feeds')],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
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
                          EdgeInsets.only(left: 0, top: 0, bottom: 0),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const BlogDetails(),
                          ),
                        );
                      },
                      leading: const Card(
                        color: Colors.black38,
                        child: Image(
                          width: 70,
                          height: 100,
                          image: AssetImage(
                            'assets/images/fifth.jpg',
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      title: const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'Title of Blog',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      dense: false,
                      subtitle: const Text(
                          'This is a Blog app made in flutter, with basic features. '
                          'The backend was handle in Firebase, routing with go_router,'
                          ' and state management with Provider.',
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.buttonBackgroundColor,
        isExtended: true,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const CreateBlog(),
          ));
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
