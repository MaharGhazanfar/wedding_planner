import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import 'package:wedding_planner/user_interface/categories_details.dart';

class CategoryBottomSheetBar {
  static void categoryBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        elevation: 5,
        backgroundColor: Colors.white,
        isScrollControlled: true,
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.065,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: TextFormField(
                      decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search Category',
                    focusColor: CustomColors.buttonBackgroundColor,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: CustomColors.buttonBackgroundColor)),
                    prefixIcon: IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: CustomColors.buttonBackgroundColor,
                      ),
                      onPressed: () {},
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: CustomColors.buttonBackgroundColor,
                      ),
                      onPressed: () {},
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: CustomColors.buttonBackgroundColor,
                            width: 2)),
                  ))),
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                color: Colors.white70,
                child: ListView.builder(
                  itemCount: Categories.categoryList.length,
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
                        title: Text(Categories.categoryList[index]),
                        tileColor: Colors.white70,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoriesDetails(),
                              ));
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        });
  }
}
