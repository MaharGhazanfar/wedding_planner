import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import 'package:wedding_planner/repository/utils/model_location.dart';

import '../repository/utils/custom_widgets.dart';
import 'category_dialogue.dart';

class PackageDetails extends StatefulWidget {
  const PackageDetails({Key? key}) : super(key: key);

  @override
  State<PackageDetails> createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetails> {
  var list = ['0.0%'];
  String? selectDiscount;
  late TextEditingController categoryNameController;
  late TextEditingController _searchController;
  late ScrollController scrollController;

  late LocationPicker getLocation;

  bool isSearching = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation = Provider.of<LocationPicker>(context, listen: false);
    getLocation.getCurrentPosition(context);

    categoryNameController = TextEditingController();
    _searchController = TextEditingController();
    scrollController = ScrollController();

    _searchController.addListener(() {
      if (getLocation.sessionToken == null) {
        getLocation.sessionToken = getLocation.uuid.v4();
        _searchController.text = getLocation.currentAddress;
      } else {
        getLocation.getSuggestions(_searchController.text);
      }
    });
  }

  @override
  void dispose() {
    categoryNameController.dispose();
    _searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        // appBar: AppBar(
        //   elevation: 0,
        //   leading: Padding(
        //     padding: const EdgeInsets.only(left: 8.0),
        //     child: IconButton(
        //         icon: const Icon(
        //           Icons.arrow_back_ios,
        //           color: CustomColors.headingTextFontColor,
        //         ),
        //         onPressed: () {
        //           Navigator.of(context).pop();
        //         }),
        //   ),
        //   backgroundColor: CustomColors.appBarColor,
        // ),
        body: SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset("assets/images/white_background.png",
                alignment: Alignment.center, fit: BoxFit.fill),
            Padding(
              padding: const EdgeInsets.only(
                  top: ScreenPading.topPading,
                  left: ScreenPading.leftPading,
                  right: ScreenPading.leftPading),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      padding: EdgeInsets.only(top: 8),
                      alignment: Alignment.topLeft,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: CustomColors.greenish,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Create your offer\nhere...!',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Container(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CustomWidget.customTextField3(
                        context: context, titleName: 'OfferName'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CustomWidget.customTextField3(
                        onTap: () {
                          setState(() {
                            CategoryBottomSheetBar.categoryBottomSheet(
                              status: '',
                              context: context,
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
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      title:
                                          Text(Categories.categoryList[index]),
                                      tileColor: Colors.white70,
                                      onTap: () {
                                        setState(() {
                                          categoryNameController.text =
                                              Categories.categoryList[index];
                                          Navigator.pop(context);
                                        });
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
                          });
                        },
                        titleName: 'Categories',
                        inputType: TextInputType.none,
                        controller: categoryNameController,
                        context: context),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                      ),
                      child: Column(
                        children: [
                          CustomWidget.customTextField3(
                              onChanged: (value) async {
                                isSearching = true;
                                if (value.toString().length == 1) {
                                  await Future.delayed(
                                      const Duration(seconds: 1));
                                  scrollController.jumpTo(scrollController
                                          .position.maxScrollExtent -
                                      (MediaQuery.of(context).size.height *
                                          .2));
                                }
                              },
                              // onTap: () =>
                              //     getLocation.getCurrentPosition(context),
                              titleName: 'Location',
                              maxLines: 2,
                              inputType: TextInputType.multiline,
                              // onTap: () {
                              //
                              //
                              // },
                              controller: _searchController,
                              context: context),
                          isSearching
                              ? Consumer<LocationPicker>(
                                  builder: (context, value, child) =>
                                      ListView.builder(
                                          itemCount: value.placesList.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                                title: Text(
                                                  value.placesList[index]
                                                      ['description'],
                                                ),
                                                //     tileColor: Colors.white70,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                onTap: () async {
                                                  isSearching = false;
                                                  _searchController.text =
                                                      value.placesList[index]
                                                          ['description'];
                                                  FocusScopeNode currentFocus =
                                                      FocusScope.of(context);

                                                  if (!currentFocus
                                                      .hasPrimaryFocus) {
                                                    currentFocus.unfocus();
                                                  }
                                                  print(
                                                      '_searchController.text ==${_searchController.text}/////////');
                                                });
                                          }),
                                )
                              : const SizedBox()
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
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
                                  style:
                                      ButtonsStyle.buttonTextStyle(context))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
