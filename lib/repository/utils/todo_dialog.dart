import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wedding_planner/repository/utils/custom_widgets.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import 'package:wedding_planner/repository/utils/db_handler.dart';
import 'package:wedding_planner/service_provider_interface/category_dialogue.dart';

import '../../modelClasses/model_tasks_handler.dart';

class TOdoDialog extends StatefulWidget {
  final Map<String, dynamic>? doc;
  final String? id;

  const TOdoDialog({Key? key, this.doc, this.id}) : super(key: key);

  @override
  State<TOdoDialog> createState() => _TOdoDialogState();
}

class _TOdoDialogState extends State<TOdoDialog> {
  late TextEditingController _todoController;
  late TextEditingController _notesController;
  late String selectedItem;
  late String pickedDate;
  late bool reminder;
  late final CollectionReference userTasksCollection;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userTasksCollection = DBHandler.usersTasksCollection();
    _todoController = TextEditingController(
        text: widget.doc != null ? widget.doc![ModelTasksHandler.toDOKey] : '');
    _notesController = TextEditingController(
        text:
            widget.doc != null ? widget.doc![ModelTasksHandler.notesKey] : '');
    selectedItem = widget.doc != null
        ? widget.doc![ModelTasksHandler.categoryKey]
        : 'Select';
    pickedDate = widget.doc != null
        ? widget.doc![ModelTasksHandler.dateTimeKey]
        : 'Select Date';
    reminder =
        widget.doc != null ? widget.doc![ModelTasksHandler.reminderKey] : false;
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
    return Scaffold(
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
                  decoration: const BoxDecoration(
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
                            //reminder: false
                          );
                          userTasksCollection
                              .doc(widget.id.toString().isNotEmpty
                                  ? widget.id
                                  : null)
                              .set(userTasks.toMap());

                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
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
                          style: const TextStyle(color: CustomColors.blackText),
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
                        const Text(
                          'DUE DATE',
                          style: TextStyle(color: CustomColors.blackText),
                        ),
                        Text(
                          pickedDate,
                          style: const TextStyle(color: CustomColors.blackText),
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
                        const Text(
                          'Reminder',
                          style: TextStyle(color: CustomColors.blackText),
                        ),
                        Text(
                          reminder ? 'On' : 'Off',
                          style: const TextStyle(color: CustomColors.blackText),
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
                    onTap: () async {
                      selectedItem =
                          await CategoryBottomSheetBar.categoryBottomSheet(
                              context: context);
                      setState(() {});
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Category',
                            style: TextStyle(
                                color: CustomColors.blackText,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            selectedItem,
                            style: const TextStyle(
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
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              constraints:
                                  BoxConstraints(maxHeight: height * 0.4)),
                        ),
                      )
                    ],
                  ),
                ),
                const Spacer(),
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
