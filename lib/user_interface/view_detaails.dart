import 'package:flutter/material.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';

class ViewDetails extends StatefulWidget {
  const ViewDetails({Key? key}) : super(key: key);

  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            const Image(
              image: AssetImage('assets/images/back image.png'),
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 150,
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
                              const Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Text('Your Order'),
                              ),
                              Container(
                                height: 70,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
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
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Big fire Chicken',
                                            style: TextStyle(
                                                color: CustomColors.blackText),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 6.0),
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
                                                  color:
                                                      CustomColors.blackText),
                                            ),
                                          ),
                                          TextButton(
                                              onPressed: () {},
                                              child: const Text(
                                                'View',
                                                style: TextStyle(
                                                    color:
                                                        CustomColors.greenish),
                                              ))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text('Item Total'),
                                    Text('29'),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      'Item Total',
                                      style: TextStyle(
                                          color: CustomColors.blackText),
                                    ),
                                    Text(
                                      '29',
                                      style: TextStyle(
                                          color: CustomColors.blackText),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      'Item Total',
                                      style: TextStyle(
                                          color: CustomColors.blackText),
                                    ),
                                    Text(
                                      '29',
                                      style: TextStyle(
                                          color: CustomColors.blackText),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      'Item Total',
                                      style: TextStyle(
                                          color: CustomColors.blackText),
                                    ),
                                    Text(
                                      '29',
                                      style: TextStyle(
                                          color: CustomColors.blackText),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      'Item Total',
                                      style: TextStyle(
                                          color: CustomColors.blackText),
                                    ),
                                    Text(
                                      '29',
                                      style: TextStyle(
                                          color: CustomColors.blackText),
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
