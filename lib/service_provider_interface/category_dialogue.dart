import 'package:flutter/material.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';

class CategoryBottomSheetBar {
  static void categoryBottomSheet(
      {required BuildContext context, required Widget child}) {
    showModalBottomSheet(
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
                      onPressed: () {},
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: CustomColors.buttonBackgroundColor,
                            width: 2)),
                  ))),
              Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  color: Colors.white70,
                  child: child),
            ],
          );
        });
  }
}
