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
        backgroundColor: CustomColors.buttonBackgroundColor,
        title: const Text('Feeds'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 100,
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
                  contentPadding: EdgeInsets.only(left: 0, top: 0, bottom: 0),
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
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: const Text(
                      'Title of Blog',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
      )),
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
