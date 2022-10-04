import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import 'package:wedding_planner/user_interface/vendorsof_spcific_categorie.dart';

class CategoriesDetails extends StatefulWidget {
  const CategoriesDetails({Key? key}) : super(key: key);

  @override
  State<CategoriesDetails> createState() => _CategoriesDetailsState();
}

class _CategoriesDetailsState extends State<CategoriesDetails> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
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
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: CustomColors.buttonBackgroundColor,
                            width: 2)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: CustomColors.buttonBackgroundColor,
                            width: 2))),
              )),
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            color: Colors.white70,
            child: ListView.builder(
              itemCount: Categories.categoriesList.length,
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
                    title: Text(Categories.categoriesList[index]),
                    tileColor: Colors.white70,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const VendorsOfSpecificCategories(),
                          ));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
