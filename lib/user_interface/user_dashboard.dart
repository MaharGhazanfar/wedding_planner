import 'package:flutter/material.dart';

import '../repository/utils/custom_widgets.dart';
import '../repository/utils/data_constants.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  bool isTrue = false;
  double? taskContainer;
  double? width;
  double? height;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool getSize = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    getSize ? taskContainer = MediaQuery.of(context).size.height * 0.25 : null;
    getSize = false;
    return Scaffold(
      backgroundColor: Colors.black26,
      key: _scaffoldKey,
      drawer: CustomWidget.myCustomDrawer(
          context: context,
          width: width! * 0.45,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Image(
                image: AssetImage('assets/images/logo.png'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(Icons.account_balance_sharp,
                      color: CustomColors.buttonBackgroundColor),
                  Text('All_ To-dos')
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(Icons.category,
                      color: CustomColors.buttonBackgroundColor),
                  Text('Categories')
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(Icons.ac_unit,
                      color: CustomColors.buttonBackgroundColor),
                  Text('Bookings')
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(Icons.settings,
                      color: CustomColors.buttonBackgroundColor),
                  Text('Settings')
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 12.0, right: 12),
                child: Divider(
                  thickness: 2,
                ),
              ),
              const Text(
                'RATE ON PLAY STORE',
              ),
              const Text('SEND US FEEDBACK'),
              const Text('SHARE THIS APP'),
              const Text('PRIVACY POLICY'),
            ],
          )),
      body: Center(
        child: Stack(
          children: [
            SizedBox(
              height: height!,
              width: width!,
              child: Image.asset("assets/images/first.jpg",
                  alignment: Alignment.center, fit: BoxFit.fill),
            ),
            Transform.rotate(
              origin: const Offset(50, -550),
              angle: -0.2,
              child: Transform.scale(
                scale: 1.15,
                child: Container(
                  color: Colors.teal,
                  width: width! * 0.6,
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              taskContainer = height!;
                            });
                          },
                          child: Container(
                            color: Colors.white,
                            width: width! * 0.4,
                            height: height! * 0.5,
                            child: const Icon(
                              Icons.image,
                              size: 100,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            isTrue
                ? Positioned(
                    top: 20,
                    child: IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState!.openDrawer();
                        },
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 30,
                        )),
                  )
                : Positioned(
                    top: 20,
                    left: 10,
                    right: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.black12,
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  taskContainer = height! * 0.25;
                                });
                              },
                              icon: const Padding(
                                padding: EdgeInsets.only(left: 4),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.black12,
                          child: Padding(
                            padding: const EdgeInsets.only(),
                            child: IconButton(
                              onPressed: () {},
                              alignment: Alignment.center,
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
            AnimatedPositioned(
              top: taskContainer,
              duration: const Duration(milliseconds: 200),
              child: Draggable(
                feedback: const SizedBox(),
                child: Container(
                  width: width!,
                  height: height! * 0.75,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: CustomColors.buttonBackgroundColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 12.0, right: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Container(
                                    height: 38,
                                    width: 38,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: CustomColors.buttonBackgroundColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      '85%',
                                      style: TextStyle(
                                          color: CustomColors.backGroundColor),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Your Tasks',
                                  style: TextStyle(
                                      color: CustomColors.backGroundColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  alignment: Alignment.center,
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: 10,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: SizedBox(
                                width: 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Transform.scale(
                                      scale: 1.5,
                                      child: Checkbox(
                                        activeColor:
                                            CustomColors.buttonBackgroundColor,
                                        value: true,
                                        onChanged: (value) {},
                                      ),
                                    ),
                                    const Icon(
                                      Icons.favorite_outline_sharp,
                                      size: 20,
                                      color: Colors.green,
                                    )
                                  ],
                                ),
                              ),
                              title: const Text('Details of what to do',
                                  textAlign: TextAlign.start),
                              tileColor: Colors.green,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
