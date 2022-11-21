import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:wedding_planner/modelClasses/model_tasks_handler.dart';
import 'package:wedding_planner/repository/utils/todo_dialog.dart';

import '../repository/utils/data_constants.dart';
import '../repository/utils/db_handler.dart';

class UserDashboard extends StatefulWidget {
  final String? status;

  const UserDashboard({Key? key, required this.status}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  bool isTrue = true;
  double? taskContainer;
  double? width;
  double? height;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool size = true;
  late final CollectionReference userTasksCollection;
  var selectedItems = 0;
  var taskPercentage = '0';
  late double percentValue;

  @override
  void initState() {
    super.initState();
    userTasksCollection = DBHandler.usersTasksCollection();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    size ? taskContainer = MediaQuery.of(context).size.height * 0.25 : null;
    size = false;
    return Scaffold(
      backgroundColor: Colors.black26,
      key: _scaffoldKey,
      body: Center(
        child: Stack(
          children: [
            SizedBox(
              height: height!,
              width: width!,
              child: Image.asset("assets/images/white_background.png",
                  alignment: Alignment.center, fit: BoxFit.fill),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: userTasksCollection
                    .orderBy(ModelTasksHandler.selectedKey, descending: false)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('SomeThing Went Wrong'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    selectedItems = snapshot.data!.docs
                        .where((element) =>
                            element[ModelTasksHandler.selectedKey] == true)
                        .length;
                    percentValue = (selectedItems / snapshot.data!.size);
                    taskPercentage =
                        '${(percentValue * 100).toStringAsFixed(0)}';
                    return AnimatedPositioned(
                      top: taskContainer,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        width: width!,
                        height: height! * 0.75,
                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: CustomColors.greenish,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, right: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16.0),
                                        child: CircularPercentIndicator(
                                          radius: width! * 0.06,
                                          animateFromLastPercent: true,
                                          lineWidth: 5.0,
                                          circularStrokeCap:
                                              CircularStrokeCap.round,
                                          animation: true,
                                          animationDuration: 700,
                                          curve: Curves.decelerate,
                                          percent: percentValue,
                                          backgroundColor: Colors.white,
                                          center:
                                              new Text(taskPercentage + '%'),
                                          progressColor: CustomColors
                                              .buttonBackgroundColor,
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
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    TOdoDialog(),
                                              ));
                                        },
                                        alignment: Alignment.center,
                                        icon: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 35,
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
                                  itemCount: snapshot.data!.docs.length,
                                  separatorBuilder: (context, index) =>
                                      const Divider(),
                                  itemBuilder: (context, index) {
                                    Map<String, dynamic> doc =
                                        snapshot.data!.docs[index].data()
                                            as Map<String, dynamic>;

                                    return ListTile(
                                      leading: SizedBox(
                                        width: 100,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Transform.scale(
                                              scale: 2,
                                              child: Checkbox(
                                                fillColor:
                                                    MaterialStateProperty.all(
                                                        CustomColors.greenish),
                                                activeColor:
                                                    CustomColors.greenish,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                value: doc[ModelTasksHandler
                                                    .selectedKey],
                                                onChanged: (value) {
                                                  userTasksCollection
                                                      .doc(snapshot
                                                          .data!.docs[index].id)
                                                      .update({
                                                    ModelTasksHandler
                                                        .selectedKey: value
                                                  });
                                                },
                                              ),
                                            ),
                                            Icon(Icons.account_balance_sharp)
                                          ],
                                        ),
                                      ),

                                      title: Text(
                                        doc[ModelTasksHandler.toDOKey],
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: CustomColors.textFontColor,
                                            decoration: doc[ModelTasksHandler
                                                    .selectedKey]
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                            fontSize: 16),
                                      ),

                                      // tileColor: Colors.green,
                                    );
                                  },
                                ))
                          ],
                        ),
                      ),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
