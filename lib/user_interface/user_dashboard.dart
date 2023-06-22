import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:wedding_planner/modelClasses/model_tasks_handler.dart';
import 'package:wedding_planner/repository/utils/todo_dialog.dart';
import '../repository/utils/data_constants.dart';
import '../repository/utils/db_handler.dart';

class UserDashboard extends StatefulWidget {
  final String? status;
  static const pageName = '/UserDashboard';

  const UserDashboard({Key? key, required this.status}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  bool isTrue = true;
  double? taskContainer;
  double? width;
  double? height;
  int count = 0;
  bool size = true;
  late final CollectionReference userTasksCollection;
  var selectedItems = 0;
  String taskPercentage = '';
  late double percentValue;
  late DateTime taskDate;

  @override
  void initState() {
    super.initState();
    taskDate = DateTime.now();
    userTasksCollection = DBHandler.usersTasksCollection();
  }

  Widget getDifference(DateTime date) {
    log(taskDate.toString());
    if (taskDate.day == 0) {

      return Text(
        ' ${(taskDate.hour - date.hour).toString().padLeft(2, '0')} :${(taskDate.minute - date.minute).toString().padLeft(2, '0')} ',
        style: const TextStyle(color: Colors.red, fontSize: 28),
      );
    } else {
      return Text(
        '${(taskDate.day - date.day).toString().padLeft(2, '0')} days : ${(taskDate.hour - date.hour).toString().padLeft(3, '0')} :${(taskDate.minute - date.minute).toString().padLeft(2, '0')} ',
        style: const TextStyle(color: Colors.red, fontSize: 28),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    size = false;
    return Scaffold(
      backgroundColor: Colors.black26,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: height!,
              width: width!,
              child: Image.asset("assets/images/signup.png",
                  alignment: Alignment.center, fit: BoxFit.fill),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: userTasksCollection
                    .orderBy(ModelTasksHandler.selectedKey, descending: false)
                    .orderBy(ModelTasksHandler.dateTimeKey, descending: false)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());

                    /* else
                  if (snapshot.connectionState == ConnectionState.active) {
                    return const Center(child: CircularProgressIndicator(
                      color: CustomColors.greenish,));*/
                  } else if (snapshot.hasData) {
                    print('///////////count////////////${{count++}}');
                    Map<String, dynamic> doc = {};
                    DateTime? dateTime;

                    if (snapshot.data!.docs.isNotEmpty &&
                        !(snapshot.data!.docs[0]
                            .get(ModelTasksHandler.selectedKey))) {
                      doc =
                          snapshot.data!.docs[0].data() as Map<String, dynamic>;

                      print('////////////document/////////${doc}');
                      print('////////////dateTime/////////${dateTime}');

                      dateTime = DateTime(
                          int.parse(doc[ModelTasksHandler.dateTimeKey]
                              .substring(0, 4)),
                          int.parse(doc[ModelTasksHandler.dateTimeKey]
                              .substring(5, 7)),
                          int.parse(doc[ModelTasksHandler.dateTimeKey]
                              .substring(8, 10)),
                          int.parse(doc[ModelTasksHandler.dateTimeKey]
                              .substring(11, 13)),
                          int.parse(doc[ModelTasksHandler.dateTimeKey]
                              .substring(14, 16)));

                      print('////////////after dateTime/////////${dateTime}');
                    } else {
                      dateTime = DateTime.now();
                      print('//////////////else//////////');
                    }

                    selectedItems = snapshot.data!.docs
                        .where((element) =>
                            element[ModelTasksHandler.selectedKey] == true)
                        .length;
                    percentValue = selectedItems != 0
                        ? (selectedItems / snapshot.data!.size)
                        : 0;
                    taskPercentage = (percentValue * 100).toStringAsFixed(0);

                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: snapshot.data!.docs.isNotEmpty &&
                                    !(snapshot.data!.docs[0]
                                        .get(ModelTasksHandler.selectedKey))
                                ? CountdownTimer(
                                    endWidget: getDifference(dateTime),
                                    textStyle: const TextStyle(
                                        color:
                                            CustomColors.buttonBackgroundColor,
                                        fontSize: 28),
                                    endTime: dateTime.millisecondsSinceEpoch,
                                    /* widgetBuilder: (context,  time) {
                                if (time == null) {
                                  return Text('');
                                }
                                return Text(
                                    'days: [ ${time.days} ], hours: [ ${time.hours} ], min: [ ${time.min} ], sec: [ ${time.sec} ]');
                              },*/
                                  )
                                /*TimerCountdown(
                                    colonsTextStyle: const TextStyle(
                                        fontSize: 25,
                                        color:
                                            CustomColors.buttonBackgroundColor),
                                    timeTextStyle: const TextStyle(
                                        fontSize: 25,
                                        color:
                                            CustomColors.buttonBackgroundColor),
                                    format: CountDownTimerFormat
                                        .daysHoursMinutesSeconds,
                                    endTime: dateTime!,
                                    onEnd: () {})*/
                                : const Text(
                                    'No Task Remaining',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                          ),
                        ),
                        Container(
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
                                            radius: height! * 0.04,
                                            animateFromLastPercent: true,
                                            lineWidth: 5.0,
                                            circularStrokeCap:
                                                CircularStrokeCap.round,
                                            animation: true,
                                            animationDuration: 700,
                                            curve: Curves.decelerate,
                                            percent: percentValue,
                                            backgroundColor: Colors.white,
                                            center: Text('$taskPercentage%'),
                                            progressColor: CustomColors
                                                .buttonBackgroundColor,
                                          ),
                                        ),
                                        Text(
                                          'Your Tasks',
                                          style: TextStyle(
                                              color:
                                                  CustomColors.backGroundColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const TOdoDialog(),
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
                                  child: snapshot.data!.docs.isNotEmpty
                                      ? ListView.separated(
                                          shrinkWrap: true,
                                          itemCount: snapshot.data!.docs.length,
                                          separatorBuilder: (context, index) =>
                                              const Divider(),
                                          itemBuilder: (context, index) {
                                            var doc = snapshot.data!.docs[index]
                                                .data() as Map<String, dynamic>;

                                            return ListTile(
                                              leading: SizedBox(
                                                width: 100,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Transform.scale(
                                                      scale: 2,
                                                      child: Checkbox(
                                                        fillColor:
                                                            MaterialStateProperty
                                                                .all(CustomColors
                                                                    .greenish),
                                                        activeColor:
                                                            CustomColors
                                                                .greenish,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                        value: doc[
                                                            ModelTasksHandler
                                                                .selectedKey],
                                                        onChanged: (value) {
                                                          userTasksCollection
                                                              .doc(snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .id)
                                                              .update({
                                                            ModelTasksHandler
                                                                    .selectedKey:
                                                                value
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    const Icon(Icons
                                                        .account_balance_sharp)
                                                  ],
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.pushNamed(context,
                                                    TOdoDialog.pageName,
                                                    arguments: {
                                                      Strings.doc: doc,
                                                      Strings.id: snapshot
                                                          .data!.docs[index].id
                                                    });
                                                /*Navigator.push(context,
                                                    MaterialPageRoute(
                                                  builder: (context) {
                                                    return TOdoDialog(
                                                        doc: doc,
                                                        id: snapshot.data!
                                                            .docs[index].id);
                                                  },
                                                ));*/
                                              },
                                              title: Text(
                                                doc[ModelTasksHandler.toDOKey],
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: CustomColors
                                                        .textFontColor,
                                                    decoration: doc[
                                                            ModelTasksHandler
                                                                .selectedKey]
                                                        ? TextDecoration
                                                            .lineThrough
                                                        : TextDecoration.none,
                                                    fontSize: 16),
                                              ),
                                            );
                                          },
                                        )
                                      : Center(
                                          child: Text(
                                          'No Task Added',
                                          style: TextStyle(
                                              color: CustomColors.greenish,
                                              fontWeight: FontWeight.bold,
                                              fontSize: width! * 0.05),
                                        )))
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: Text('SomeThing Went Wrong'));
                  }
                })
          ],
        ),
      ),
    );
  }
}
