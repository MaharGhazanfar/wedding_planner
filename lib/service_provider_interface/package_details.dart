import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wedding_planner/modelClasses/service_packages.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import 'package:wedding_planner/repository/utils/db_handler.dart';
import 'package:wedding_planner/repository/utils/model_location.dart';
import '../repository/utils/custom_widgets.dart';
import 'category_dialogue.dart';

class PackageDetails extends StatefulWidget {
  const PackageDetails({Key? key}) : super(key: key);

  @override
  State<PackageDetails> createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetails> {
  late TextEditingController categoryNameController;
  late TextEditingController offerNameController;
  late TextEditingController locationController;
  late TextEditingController discountController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late ScrollController scrollController;
  late LocationPicker getLocation;
  File? imagesFile;

  bool isSearching = false;
  final firebaseStorage = FirebaseStorage.instance.ref();
  late final CollectionReference generalPackagesCollection;

  Future<String> uploadImage() async {
    var upload = firebaseStorage.child('Package/${DateTime.now().millisecond}');
    await upload.putFile(imagesFile!);
    return upload.getDownloadURL();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation = Provider.of<LocationPicker>(context, listen: false);
    getLocation.getCurrentPosition(context);
    generalPackagesCollection = DBHandler.generalPackagesCollection();
    categoryNameController = TextEditingController();
    discountController = TextEditingController();
    priceController = TextEditingController();
    offerNameController = TextEditingController();
    descriptionController = TextEditingController();
    locationController = TextEditingController();
    scrollController = ScrollController();

    locationController.addListener(() {
      if (getLocation.sessionToken == null) {
        getLocation.sessionToken = getLocation.uuid.v4();
        locationController.text = getLocation.currentAddress;
      } else {
        getLocation.getSuggestions(locationController.text);
      }
    });
  }

  @override
  void dispose() {
    categoryNameController.dispose();
    locationController.dispose();
    scrollController.dispose();
    priceController.dispose();
    discountController.dispose();
    offerNameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: ListView(
                children: [
                  IconButton(
                      padding: const EdgeInsets.only(top: 8),
                      alignment: Alignment.topLeft,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: CustomColors.greenish,
                      )),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Align(
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
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 4, right: 4),
                    child: InkWell(
                      onTap: () async {
                        XFile? xFile = await pickImage();
                        if (xFile != null) {
                          imagesFile = File(xFile.path);
                        }
                        setState(() {});
                      },
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
                        child: imagesFile == null
                            ? const Icon(
                                Icons.photo_camera,
                                size: 150,
                                color: CustomColors.buttonBackgroundColor,
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: FileImage(imagesFile!),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 4, right: 4),
                    child: CustomWidget.customTextField3(
                        controller: offerNameController,
                        context: context,
                        titleName: 'OfferName'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 4, right: 4),
                    child: CustomWidget.customTextField3(
                        readOnly: true,
                        onTap: () async {
                          categoryNameController.text =
                              await CategoryBottomSheetBar.categoryBottomSheet(
                            context: context,
                          );
                        },
                        titleName: 'Categories',
                        textInputType: TextInputType.none,
                        controller: categoryNameController,
                        context: context),
                  ),
                  Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, left: 4, right: 4),
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
                              textInputType: TextInputType.multiline,
                              // onTap: () {
                              //
                              //
                              // },
                              controller: locationController,
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
                                                  locationController.text =
                                                      value.placesList[index]
                                                          ['description'];
                                                  FocusScopeNode currentFocus =
                                                      FocusScope.of(context);

                                                  if (!currentFocus
                                                      .hasPrimaryFocus) {
                                                    currentFocus.unfocus();
                                                  }
                                                  print(
                                                      '_searchController.text ==${locationController.text}/////////');
                                                });
                                          }),
                                )
                              : const SizedBox()
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 4, right: 4),
                    child: Row(
                      children: [
                        Flexible(
                            flex: 5,
                            child: CustomWidget.customTextField3(
                                textInputType: TextInputType.number,
                                controller: priceController,
                                context: context,
                                titleName: 'Price')),
                        const Spacer(),
                        Flexible(
                            flex: 5,
                            child: CustomWidget.customTextField3(
                                textInputType: TextInputType.number,
                                suffix: const Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    '%',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                controller: discountController,
                                context: context,
                                titleName: 'Discount')),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 4, right: 4),
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
                      child: TextField(
                        maxLines: 5,
                        controller: descriptionController,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Describe about your offer',
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      //  print( FirebaseAuth.instance.currentUser!.uid);

                      if (imagesFile != null) {
                        if (offerNameController.text.toString().isNotEmpty &&
                            categoryNameController.text.toString().isNotEmpty &&
                            locationController.text.toString().isNotEmpty &&
                            priceController.text.toString().isNotEmpty &&
                            descriptionController.text.toString().isNotEmpty) {
                          var imageURL = await uploadImage();

                          var packagesInfo = ModelServicePackages(
                            offerName: offerNameController.text.toString(),
                            description: descriptionController.text.toString(),
                            price:
                                double.parse(priceController.text.toString()),
                            discount: discountController.text.toString().isEmpty
                                ? 0
                                : double.parse(
                                    discountController.text.toString()),
                            category: categoryNameController.text.toString(),
                            imageURL: imageURL,
                            location: locationController.text.toString(),
                            uid: FirebaseAuth.instance.currentUser!.uid,
                          );
                          print(
                              '${FirebaseAuth.instance.currentUser!.uid}////////////////');
                          await FirebaseFirestore.instance
                              .collection(Strings.serviceProvider)
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection('Packages')
                              .doc()
                              .set(packagesInfo.toMap());

                          await generalPackagesCollection
                              .doc()
                              .set(packagesInfo.toMap());

                          offerNameController.clear();
                          locationController.clear();
                          categoryNameController.clear();
                          priceController.clear();
                          descriptionController.clear();
                          Navigator.pop(context);
                        } else {
                          ShowCustomToast(msg: 'All Field Are Must Filled');
                        }
                      } else {
                        ShowCustomToast(msg: 'Please Select Image');
                      }
                    },
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

Future<XFile?> pickImage() async {
  try {
    if (await Permission.storage.request().isGranted) {
      final pickedImage = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          maxWidth: 450,
          maxHeight: 450,
          imageQuality: 100);
      if (pickedImage == null) return null;
      return pickedImage;
    }
  } on PlatformException catch (e) {
    print('Failed to pick image: $e');
  }
  return null;
}
