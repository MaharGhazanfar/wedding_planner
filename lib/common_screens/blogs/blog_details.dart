import 'package:flutter/material.dart';

class BlogDetails extends StatefulWidget {
  const BlogDetails({Key? key}) : super(key: key);

  @override
  State<BlogDetails> createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          child: const Image(
                            image: AssetImage(
                              'assets/images/forth.jpg',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        const Positioned(
                            bottom: 10,
                            left: 20,
                            child: Text(
                              'Title of Blog',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ))
                      ],
                    )),
                const Expanded(
                    flex: 3,
                    child: SizedBox(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'This is a Blog app made in flutter, with basic features. '
                          'The backend was handle in Firebase, routing with go_router,'
                          ' and state management with Provider.'
                          'This is a Blog app made in flutter, with basic features. '
                          'The backend was handle in Firebase, routing with go_router,'
                          ' and state management with Provider.'
                          'This is a Blog app made in flutter, with basic features. '
                          'The backend was handle in Firebase, routing with go_router,'
                          ' and state management with Provider.',
                          style: TextStyle(),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ))
              ],
            ),
          ),
          Positioned(
              top: 10,
              left: 10,
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
    );
  }
}
