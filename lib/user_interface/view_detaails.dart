import 'package:flutter/material.dart';
import 'package:wedding_planner/common_screens/appointments_page.dart';
import 'package:wedding_planner/modelClasses/model_personal_login_info.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import 'package:wedding_planner/repository/utils/db_handler.dart';
import 'package:wedding_planner/service_provider_interface/add_images.dart';
import 'package:wedding_planner/service_provider_interface/add_video.dart';

import '../modelClasses/service_packages.dart';
import '../service_provider_interface/provider_peckages.dart';

class ViewDetails extends StatefulWidget {
  final Map<String, dynamic> doc;

  const ViewDetails({Key? key, required this.doc}) : super(key: key);

  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .3,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                        image: NetworkImage(
                            widget.doc[ModelServicePackages.imageURLKey]),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 6, right: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Package Name',
                      style: TextStyle(
                          color: CustomColors.blackText, fontSize: 16),
                    ),
                    Text(
                      widget.doc[ModelServicePackages.offerNameKey],
                      style: TextStyle(
                          color: CustomColors.blackText,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 6, right: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Package category',
                      style: TextStyle(
                          color: CustomColors.blackText, fontSize: 16),
                    ),
                    Text(
                      widget.doc[ModelServicePackages.categoryKey],
                      style: TextStyle(
                          color: CustomColors.blackText,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 6, right: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Package Price',
                      style: TextStyle(
                          color: CustomColors.blackText, fontSize: 16),
                    ),
                    Row(
                      children: [
                        widget.doc[ModelServicePackages.discountKey] != 0
                            ? RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text:
                                          '${widget.doc[ModelServicePackages.priceKey].toString()}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text:
                                          '  ${widget.doc[ModelServicePackages.priceKey] - (widget.doc[ModelServicePackages.discountKey] / 100) * widget.doc[ModelServicePackages.priceKey]}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ]),
                              )
                            : Text(
                                widget.doc[ModelServicePackages.priceKey]
                                    .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.textFontColor),
                              ),
                        widget.doc[ModelServicePackages.discountKey] != 0
                            ? Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  '${widget.doc[ModelServicePackages.discountKey].toString()}%',
                                  style: TextStyle(
                                      // fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: CustomColors.textFontColor),
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 6, right: 6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Description :',
                      style: TextStyle(
                          color: CustomColors.blackText, fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 4),
                      child: Text(
                        '''The RatingBar widget is used to show a rating or collect ratings from users (this is an interactive RatingBar). For example, you can use the RatingBar widget inside an e-commerce app to show ratings for a product.
                        ''',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: CustomColors.blackText,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 6, right: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Package Rating : ',
                      style: TextStyle(
                          color: CustomColors.blackText, fontSize: 16),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: CustomColors.yellowIconsColor,
                        ),
                        Text(
                          widget.doc[ModelServicePackages.ratingKey].toString(),
                          style: TextStyle(color: CustomColors.greenish),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                stream: DBHandler.personalInfoCollectionForProvider()
                    .doc(widget.doc[ModelServicePackages.uidKey])
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 6.0, top: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'More Details : ',
                            style: TextStyle(
                                color: CustomColors.blackText, fontSize: 16),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Images',
                                  style: TextStyle(
                                      color: CustomColors.blackText,
                                      fontSize: 16),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AddImages(
                                                    UID: widget.doc[
                                                        ModelServicePackages
                                                            .uidKey],
                                                  )));
                                    },
                                    child: Text('Image'))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Video',
                                  style: TextStyle(
                                      color: CustomColors.blackText,
                                      fontSize: 16),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  VideoPlayerScreen(
                                                    UID: widget.doc[
                                                        ModelServicePackages
                                                            .uidKey],
                                                  )));
                                    },
                                    child: Text('Video'))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'All Packages',
                                  style: TextStyle(
                                      color: CustomColors.blackText,
                                      fontSize: 16),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProviderPackages(
                                                    UID: widget.doc[
                                                        ModelServicePackages
                                                            .uidKey],
                                                  )));
                                    },
                                    child: Text('Packages'))
                              ],
                            ),
                          ),
                          StreamBuilder(
                            stream:
                                DBHandler.personalInfoCollectionForServiceUser()
                                    .doc(DBHandler.user!.uid)
                                    .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                print(snapshot
                                    .data![ModelPersonalLoginInfo.numberKey]);
                                return Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Appointment',
                                        style: TextStyle(
                                            color: CustomColors.blackText,
                                            fontSize: 16),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Appointments(
                                                  senderNumber: snapshot.data![
                                                          ModelPersonalLoginInfo
                                                              .numberKey]
                                                      .toString(),
                                                  senderName:
                                                      '${snapshot.data![ModelPersonalLoginInfo.firstNameKey].toString()} ${snapshot.data![ModelPersonalLoginInfo.lastNameKey].toString()}',
                                                  UID: widget.doc[
                                                      ModelServicePackages
                                                          .uidKey],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text('Appointment'))
                                    ],
                                  ),
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                          const Text(
                            'Service Provider Contact Info : ',
                            style: TextStyle(
                                color: CustomColors.blackText, fontSize: 16),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6, right: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Name',
                                  style: TextStyle(
                                      color: CustomColors.blackText,
                                      fontSize: 16),
                                ),
                                Text(
                                  '${snapshot.data![ModelPersonalLoginInfo.firstNameKey]} ${snapshot.data![ModelPersonalLoginInfo.lastNameKey]}',
                                  style: TextStyle(
                                      color: CustomColors.blackText,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6, right: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Phone Number',
                                  style: TextStyle(
                                      color: CustomColors.blackText,
                                      fontSize: 16),
                                ),
                                Text(
                                  '${snapshot.data![ModelPersonalLoginInfo.numberKey]}',
                                  style: TextStyle(
                                      color: CustomColors.blackText,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6, right: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Email',
                                  style: TextStyle(
                                      color: CustomColors.blackText,
                                      fontSize: 16),
                                ),
                                Text(
                                  'mail',
                                  style: TextStyle(
                                      color: CustomColors.blackText,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Container(
//   height: 70,
//   decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(12),
//       boxShadow: const [
//         BoxShadow(
//             color: Colors.black26,
//             offset: Offset(2, 2),
//             blurRadius: 3),
//       ]),
//   child: Row(
//     children: [
//       Container(
//         width: 70,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//             borderRadius:
//                 BorderRadius.circular(12),
//             image: const DecorationImage(
//                 image: AssetImage(
//                   'assets/images/back image.png',
//                 ),
//                 fit: BoxFit.cover)),
//       ),
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisAlignment:
//               MainAxisAlignment.center,
//           crossAxisAlignment:
//               CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Big fire Chicken',
//               style: TextStyle(
//                   color: CustomColors.blackText),
//             ),
//             Padding(
//               padding:
//                   const EdgeInsets.only(top: 6.0),
//               child: Row(
//                 children: const [
//                   Icon(
//                     Icons.star,
//                     color: CustomColors
//                         .yellowIconsColor,
//                   ),
//                   Text(
//                     '4.5',
//                     style: TextStyle(
//                         color: CustomColors
//                             .greenish),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//       Expanded(
//         child: Column(
//           mainAxisAlignment:
//               MainAxisAlignment.center,
//           crossAxisAlignment:
//               CrossAxisAlignment.end,
//           children: [
//             const Padding(
//               padding: EdgeInsets.only(
//                   right: 20.0, top: 6),
//               child: Text(
//                 'Price',
//                 style: TextStyle(
//                     color:
//                         CustomColors.blackText),
//               ),
//             ),
//             TextButton(
//                 onPressed: () {},
//                 child: const Text(
//                   'View',
//                   style: TextStyle(
//                       color:
//                           CustomColors.greenish),
//                 ))
//           ],
//         ),
//       )
//     ],
//   ),
// ),
