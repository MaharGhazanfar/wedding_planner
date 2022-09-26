import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {},
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {},
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  )),
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                color: Colors.white70,
                child: ListView.builder(
                  itemCount: 50,
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
                        title: const Text('Flowers'),
                        tileColor: Colors.white70,
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
