import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wedding_planner/common_screens/blogs/blogs_page.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import 'package:wedding_planner/user_interface/view_detaails.dart';

class MarketPlaceView extends StatefulWidget {
  final String status;

  const MarketPlaceView({Key? key, required this.status}) : super(key: key);

  @override
  State<MarketPlaceView> createState() => _MarketPlaceViewState();
}

class _MarketPlaceViewState extends State<MarketPlaceView> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            const Image(
              image: AssetImage('assets/images/signup.png'),
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PopupMenuButton(
                          color: CustomColors.backGroundColor,
                          position: PopupMenuPosition.under,
                          itemBuilder: (context) => [
                            PopupMenuItem(onTap: () {}, child: Text('Filters')),
                            PopupMenuItem(
                                onTap: () {}, child: Text('Category')),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BlogsPage(),
                                      ));
                                },
                                color: CustomColors.backGroundColor,
                                icon: Icon(
                                  Icons.favorite,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                color: CustomColors.backGroundColor,
                                icon: Icon(CupertinoIcons.color_filter),
                              ),
                              IconButton(
                                onPressed: () {},
                                color: CustomColors.backGroundColor,
                                icon: Icon(Icons.notifications_sharp),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: const BorderSide(color: Colors.white38),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(24)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, left: 16, right: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Recommended',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                    TextButton(
                                        child: const Text(
                                          'See All',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.teal),
                                        ),
                                        onPressed: () {}),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 230,
                                child: ListView.builder(
                                  itemCount: 5,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      color: Colors.white,
                                      child: SizedBox(
                                        height: 160,
                                        width: 230,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              flex: 7,
                                              child: Stack(
                                                fit: StackFit.loose,
                                                //alignment: Alignment.center,
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                        image:
                                                            const DecorationImage(
                                                                image:
                                                                    AssetImage(
                                                                  'assets/images/back image.png',
                                                                ),
                                                                fit: BoxFit
                                                                    .cover)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Container(
                                                        height: 30,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: const [
                                                            Icon(Icons.star,
                                                                color: CustomColors
                                                                    .yellowIconsColor),
                                                            Text(
                                                              '4.7',
                                                              style: TextStyle(
                                                                  color: CustomColors
                                                                      .greenish),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, left: 8),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Title of Item.....',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, left: 8, right: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'price',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ViewDetails(),
                                                          ));
                                                    },
                                                    child: Text(
                                                      'Details',
                                                      style: TextStyle(
                                                          color: Colors.teal),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 4.0, left: 16, right: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Near of you',
                                      style: TextStyle(
                                          color: CustomColors.blackText,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextButton(
                                        child: const Text(
                                          'See All',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.teal),
                                        ),
                                        onPressed: () {}),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: ListView.builder(
                                  itemCount: 5,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.only(
                                        top: 8.0,
                                        left: 8,
                                        right: 8,
                                      ),
                                      child: Container(
                                        height: 70,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.black26,
                                                  offset: Offset(2, 2),
                                                  blurRadius: 3),
                                            ]),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 70,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  image: const DecorationImage(
                                                      image: AssetImage(
                                                        'assets/images/back image.png',
                                                      ),
                                                      fit: BoxFit.cover)),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Big fire Chicken',
                                                    style: TextStyle(
                                                        color: CustomColors
                                                            .blackText),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 6.0),
                                                    child: Row(
                                                      children: const [
                                                        Icon(
                                                          Icons.star,
                                                          color: CustomColors
                                                              .yellowIconsColor,
                                                        ),
                                                        Text(
                                                          '4.5',
                                                          style: TextStyle(
                                                              color: CustomColors
                                                                  .greenish),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 20.0, top: 6),
                                                    child: Text(
                                                      'Price',
                                                      style: TextStyle(
                                                          color: CustomColors
                                                              .blackText),
                                                    ),
                                                  ),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const ViewDetails(),
                                                            ));
                                                      },
                                                      child: const Text(
                                                        'Details',
                                                        style: TextStyle(
                                                            color: Colors.teal),
                                                      ))
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )

                                      // ListTile(
                                      //
                                      //   leading:  Container(
                                      //     width: 70,
                                      //
                                      //
                                      //     alignment: Alignment.center,
                                      //     decoration: BoxDecoration(
                                      //       boxShadow: ,
                                      //         borderRadius:
                                      //         BorderRadius
                                      //             .circular(25),
                                      //         image:
                                      //         const DecorationImage(
                                      //             image:
                                      //             AssetImage(
                                      //               'assets/back.png',
                                      //             ),
                                      //             )),
                                      //   ),
                                      //   title: Row(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.spaceBetween,
                                      //     children: const [
                                      //       Text('Big Fire Chicken'),
                                      //       Text('4.5'),
                                      //     ],
                                      //   ),
                                      //   subtitle: Row(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.spaceBetween,
                                      //     children: [
                                      //       Row(
                                      //         children: const [
                                      //           Icon(
                                      //             Icons.star,
                                      //             color: Colors.yellow,
                                      //             size: 18,
                                      //           ),
                                      //           Text('4.5'),
                                      //         ],
                                      //       ),
                                      //       TextButton(
                                      //           onPressed: () {
                                      //             Navigator.push(context, MaterialPageRoute(builder: (context) =>const  ViewDetails(),));
                                      //           },
                                      //           child: const Text('Details'))
                                      //     ],
                                      //   ),
                                      // ),
                                      ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
