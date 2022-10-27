import 'package:flutter/material.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';

class MyWishList extends StatefulWidget {
  const MyWishList({Key? key}) : super(key: key);

  @override
  State<MyWishList> createState() => _MyWishListState();
}

class _MyWishListState extends State<MyWishList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   leading: Padding(
      //     padding: const EdgeInsets.only(left: 8.0),
      //     child: IconButton(
      //         icon: const Icon(
      //           Icons.arrow_back_ios,
      //           color: CustomColors.headingTextFontColor,
      //         ),
      //         onPressed: () {
      //           Navigator.of(context).pop();
      //         }),
      //   ),
      //   backgroundColor: CustomColors.appBarColor,
      // ),
      // backgroundColor: CustomColors.backGroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/front_page.png",
              alignment: Alignment.center, fit: BoxFit.fill),
          Padding(
            padding: const EdgeInsets.only(
              top: ScreenPading.topPading,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: IconButton(
                      padding: EdgeInsets.only(top: 8),
                      alignment: Alignment.topLeft,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black54,
                      )),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                      top: ScreenPading.topPading,
                      left: ScreenPading.leftPading),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('My Wishlist...!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          textAlign: TextAlign.start)),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //childAspectRatio: 1 / 1.4,
                    crossAxisSpacing: 8,
                    crossAxisCount: 2,
                  ),
                  itemCount: 2,
                  padding: const EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: InkWell(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => CreateWishList(),
                              //     ));
                            },
                            child: Card(
                              elevation: 5,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Icon(
                                Icons.image,
                                size: 50,
                                color: CustomColors.yellowIconsColor,
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                            bottom: 10, left: 10, child: Text('Item Name')),
                      ],
                    );
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 24.0, left: 24.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Favourites',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.builder(
                      itemCount: 5,
                      //  shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) => Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        color: Colors.white,
                        child: SizedBox(
                          height: 160,
                          width: 230,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                              BorderRadius.circular(25),
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                'assets/images/back image.png',
                                              ),
                                              fit: BoxFit.cover)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          height: 30,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(Icons.star,
                                                  color: CustomColors
                                                      .yellowIconsColor),
                                              Text('4.7')
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, left: 8),
                                child: Row(
                                  children: [
                                    Text('Title of Item.....'),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, left: 8, right: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('price'),
                                    TextButton(
                                      onPressed: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //       builder: (context) => ViewDetails(),
                                        //     ));
                                      },
                                      child: Text(
                                        'Details',
                                        style: TextStyle(color: Colors.teal),
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
