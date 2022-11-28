import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';

class VendorsOfSpecificCategories extends StatefulWidget {
  const VendorsOfSpecificCategories({Key? key}) : super(key: key);

  @override
  State<VendorsOfSpecificCategories> createState() =>
      _VendorsOfSpecificCategoriesStates();
}

class _VendorsOfSpecificCategoriesStates
    extends State<VendorsOfSpecificCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Service Providers'),
        elevation: 5,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: CustomColors.backGroundColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        backgroundColor: CustomColors.buttonBackgroundColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(
              //     height: MediaQuery.of(context).size.height * 0.065,
              //     width: MediaQuery.of(context).size.width * 0.85,
              //     child: TextFormField(
              //       decoration: InputDecoration(
              //           filled: true,
              //           fillColor: Colors.white,
              //           hintText: 'Search Category',
              //           prefixIcon: IconButton(
              //             icon: const Icon(Icons.search),
              //             onPressed: () {},
              //           ),
              //           suffixIcon: IconButton(
              //             icon: const Icon(Icons.clear),
              //             onPressed: () {},
              //           ),
              //           border: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(10))),
              //     )),
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                color: Colors.white70,
                child: ListView.builder(
                  itemCount: 5,
                  dragStartBehavior: DragStartBehavior.start,
                  physics: const BouncingScrollPhysics(),
                  itemExtent: 70.0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, bottom: 2, top: 2),
                      child: ListTile(
                        leading: const CircleAvatar(
                            radius: 30,
                            backgroundColor: CustomColors.buttonBackgroundColor,
                            child: Icon(
                              Icons.person,
                              size: 25,
                            )),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        title: const Text('Service Provider'),
                        tileColor: Colors.white70,
                        trailing: const Text('Location'),
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => ChatPage(name: '',senderNumber: '',receiverNumber: ''),
                          //     ));
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
