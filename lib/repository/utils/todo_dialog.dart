import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wedding_planner/repository/utils/custom_widgets.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import 'package:wedding_planner/repository/utils/db_handler.dart';
import 'package:wedding_planner/service_provider_interface/category_dialogue.dart';

import '../../modelClasses/model_tasks_handler.dart';

class TOdoDialog extends StatefulWidget {
  const TOdoDialog({Key? key}) : super(key: key);

  @override
  State<TOdoDialog> createState() => _TOdoDialogState();
}

class _TOdoDialogState extends State<TOdoDialog> {
  late TextEditingController _todoController;
  late TextEditingController _notesController;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedItem = 'select';
  String pickedDate = 'Select Date';

  //String pickedTime = 'null';
  late final CollectionReference userTasksCollection;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userTasksCollection = DBHandler.usersTasksCollection();
    _todoController = TextEditingController();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _todoController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print('${selectedItem}////////////build///////////////');
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white70,
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 16, right: 16),
        child: SingleChildScrollView(
          child: Container(
            width: width,
            height: height * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: CustomColors.greenish,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.clear,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      const Text(
                        'To Do',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.check,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          var userTasks = ModelTasksHandler(
                            toDO: _todoController.text,
                            dateTime: pickedDate,
                            category: selectedItem,
                            notes: _notesController.text,
                          );
                          print(
                              '${userTasks.toMap()}//////////////////////////');
                          userTasksCollection.doc().set(userTasks.toMap());

                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            'TO_DO',
                            style: TextStyle(color: CustomColors.blackText),
                          )),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: CustomColors.blackText),
                          controller: _todoController,
                          maxLines: 3,
                          minLines: 1,
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(
                    thickness: 1.5,
                  ),
                ),
                InkWell(
                  splashColor: CustomColors.greenish,
                  onTap: () async {
                    pickedDate = await CustomWidget.showDateTimePicker(context);
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'DUE DATE',
                          style: TextStyle(color: CustomColors.blackText),
                        ),
                        Text(
                          pickedDate,
                          style: TextStyle(color: CustomColors.blackText),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(
                    thickness: 1.5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Reminder',
                          style: TextStyle(color: CustomColors.blackText),
                        ),
                        Text(
                          'Off',
                          style: TextStyle(color: CustomColors.blackText),
                        )
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(
                    thickness: 1.5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {
                      // scaffoldKey.currentState!.showBottomSheet((context) {
                      CategoryBottomSheetBar.categoryBottomSheet(
                        context: context,
                        child: ListView.builder(
                          itemCount: Categories.categoryList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                setState(() {
                                  selectedItem = Categories.categoryList[index];
                                  Navigator.pop(context);
                                  print(
                                      '${selectedItem}///////////////////////////');
                                });
                              },
                              title: Text(
                                Categories.categoryList[index],
                                style: TextStyle(color: CustomColors.blackText),
                              ),
                            );
                          },
                        ),
                      );
                      setState(() {});

                      //});
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Category',
                            style: TextStyle(
                                color: CustomColors.blackText,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            selectedItem,
                            style: TextStyle(
                              color: CustomColors.blackText,
                            ),
                          ),
                        ]),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(
                    thickness: 1.5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(
                        flex: 1,
                        child: Text(
                          'Notes',
                          style: TextStyle(color: CustomColors.blackText),
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        child: TextField(
                          textDirection: TextDirection.rtl,
                          controller: _notesController,
                          style: const TextStyle(color: CustomColors.blackText),
                          minLines: null,
                          expands: true,
                          maxLines: null,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              constraints: BoxConstraints(maxHeight: 300)),
                        ),
                      )
                    ],
                  ),
                ),
                Spacer(),
                const Divider(
                  thickness: 1.5,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      Text(
                        'DELETE TO-DO',
                        style: TextStyle(color: CustomColors.blackText),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
