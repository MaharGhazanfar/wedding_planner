import 'package:flutter/material.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';

import '../repository/utils/custom_widgets.dart';

class PackageDetails extends StatefulWidget {
  const PackageDetails({Key? key}) : super(key: key);

  @override
  State<PackageDetails> createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetails> {
  var list = ['0.0%'];
  String? selectDiscount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: CustomColors.headingTextFontColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ),
          backgroundColor: CustomColors.appBarColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.09),
                          offset: const Offset(
                            0.1,
                            1.5,
                          ),
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.09),
                          offset: const Offset(
                            -0.1,
                            -0.001,
                          ),
                          spreadRadius: -1,
                        ),
                      ]),
                  child: Icon(
                    Icons.photo_camera,
                    size: 150,
                    color: CustomColors.buttonBackgroundColor,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomWidget.customTextField3(
                    context: context, titleName: 'OfferName'),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Flexible(
                        flex: 5,
                        child: CustomWidget.customTextField3(
                            context: context, titleName: 'Price')),
                    Spacer(),
                    Flexible(
                      flex: 5,
                      child: CustomWidget.dropdownButton2(
                          items: list,
                          context: context,
                          titleName: 'Discount',
                          onChanged: (value) {
                            selectDiscount = value;
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.09),
                          offset: const Offset(
                            0.1,
                            1.5,
                          ),
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.09),
                          offset: const Offset(
                            -0.1,
                            -0.001,
                          ),
                          spreadRadius: -1,
                        ),
                      ]),
                  child: const TextField(
                    // controller: aboutController,
                    maxLines: 5,
                    // /maxLength: 500,

                    // autofocus: true,

                    //k;expands: true,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        //labelText: 'Description',

                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Describe about your offer',
                        border: InputBorder.none
                        //fillColor: Colors.white70,
                        // filled: true,
                        // hintStyle: TextStyle(color: AppColors.black),
                        // enabledBorder: OutlineInputBorder(
                        //     borderSide: BorderSide(
                        //       width: 1,
                        //     ),
                        //     borderRadius: BorderRadius.circular(15)),
                        // focusedBorder: OutlineInputBorder(
                        //     borderSide: BorderSide(
                        //       width: 1,
                        //     ),
                        //     borderRadius: BorderRadius.circular(15)),
                        ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {},
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.5,
                            decoration: BoxDecoration(
                                color: CustomColors.buttonBackgroundColor,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.06),
                                      offset: const Offset(
                                        0,
                                        2,
                                      ),
                                      spreadRadius: 3,
                                      blurRadius: 1),
                                ]),
                            child: Text('Add',
                                style: ButtonsStyle.buttonTextStyle(context))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
