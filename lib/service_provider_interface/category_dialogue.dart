import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:wedding_planner/repository/utils/data_constants.dart';

class CategoryBottomSheetBar {
  static late TextEditingController controller;
  static Future<String> categoryBottomSheet({
    required BuildContext context,
  }) async {
    String selectedValue = '';
    controller = TextEditingController();
    List<String> tempList = Categories.categoryList;
    await showModalBottomSheet(
        context: context,
        isDismissible: true,
        elevation: 5,
        backgroundColor: Colors.white,
        isScrollControlled: true,
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.065,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: TextFormField(
                        controller: controller,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Search Category',
                          focusColor: CustomColors.buttonBackgroundColor,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: CustomColors.buttonBackgroundColor)),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: CustomColors.buttonBackgroundColor,
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.clear,
                              color: CustomColors.buttonBackgroundColor,
                            ),
                            onPressed: () {
                              setState(() {
                                controller.clear();
                                tempList = Categories.categoryList;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: CustomColors.buttonBackgroundColor,
                                  width: 2)),
                        ),
                        onChanged: (value) {
                          setState(() {
                            tempList = _buildSearchList(value);
                          });
                        },
                      )),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      color: Colors.white70,
                      child: ListView.builder(
                        itemCount: tempList.length,
                        dragStartBehavior: DragStartBehavior.start,
                        physics: const BouncingScrollPhysics(),
                        itemExtent: 50.0,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 2, top: 2),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              title: Text(tempList[index]),
                              tileColor: Colors.white70,
                              onTap: () {
                                selectedValue = tempList[index];
                                controller.clear();
                                Navigator.pop(context);
                                // controller.dispose();
                              },
                            ),
                          );
                        },
                      )),
                ],
              );
            },
          );
        });
    return selectedValue;
  }

  static List<String> _buildSearchList(String value) {
    List<String> searchList = [];
    for (int i = 0; i < Categories.categoryList.length; i++) {
      if (Categories.categoryList[i]
          .toLowerCase()
          .contains(value.toLowerCase())) {
        searchList.add(Categories.categoryList[i]);
      }
    }
    return searchList;
  }
}
