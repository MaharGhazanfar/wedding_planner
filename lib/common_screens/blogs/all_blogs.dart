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
      backgroundColor: Colors.white70,
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
            return Card(
              color: Colors.white,
              elevation: 5,
              // shape:
              //     OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const BlogDetails(),
                    ),
                  );
                },
                // leading: const CircleAvatar(
                //   radius: 50,
                //   child: Icon(Icons.person),
                // ),
                leading: const Card(
                  color: Colors.black38,
                  child: Image(
                    width: 50,
                    image: AssetImage(
                      'assets/images/fifth.jpg',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                title: const Text(
                  'Title of Blog',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
            );
          },
        ),
      )),
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const CreateBlog(),
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
