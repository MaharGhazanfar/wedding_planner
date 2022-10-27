// import 'package:flutter/material.dart';
// import 'package:wedding_planner/repository/utils/data_constants.dart';
//
// import '../../repository/utils/custom_widgets.dart';
//
// class CreateWishList extends StatefulWidget {
//   const CreateWishList({Key? key}) : super(key: key);
//
//   @override
//   State<CreateWishList> createState() => _CreateWishListState();
// }
//
// class _CreateWishListState extends State<CreateWishList> {
//   @override
//   Widget build(BuildContext context) {
//     setState(() {});
//     return Scaffold(
//         // backgroundColor: Colors.white,
//         // appBar: AppBar(
//         //   elevation: 0,
//         //   leading: Padding(
//         //     padding: const EdgeInsets.only(left: 8.0),
//         //     child: IconButton(
//         //         icon: const Icon(
//         //           Icons.arrow_back_ios,
//         //           color: CustomColors.headingTextFontColor,
//         //         ),
//         //         onPressed: () {
//         //           Navigator.of(context).pop();
//         //         }),
//         //   ),
//         //   backgroundColor: CustomColors.appBarColor,
//         // ),
//         body: Stack(
//       fit: StackFit.expand,
//       children: [
//         Image.asset("assets/images/white_background.png",
//             alignment: Alignment.center, fit: BoxFit.fill),
//         Padding(
//           padding: const EdgeInsets.only(
//               top: ScreenPading.topPading,
//               left: ScreenPading.leftPading,
//               right: ScreenPading.rightPading),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               IconButton(
//                   padding: EdgeInsets.only(top: 8, right: 16),
//                   icon: const Icon(
//                     Icons.arrow_back_ios,
//                     color: CustomColors.greenish,
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   }),
//               const Align(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   'Create your wish\nlist here...!',
//                   textAlign: TextAlign.start,
//                   style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                       color: CustomColors.headingTextFontColor),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 16.0),
//                 child: Column(
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       height: 250,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.09),
//                               offset: const Offset(
//                                 0.1,
//                                 1.5,
//                               ),
//                               spreadRadius: 1,
//                             ),
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.09),
//                               offset: const Offset(
//                                 -0.1,
//                                 -0.001,
//                               ),
//                               spreadRadius: -1,
//                             ),
//                           ]),
//                       child: const Icon(
//                         Icons.photo_camera,
//                         size: 150,
//                         color: CustomColors.buttonBackgroundColor,
//                       ),
//                     ),
//                     Padding(
//                       padding:
//                           const EdgeInsets.only(top: ScreenPading.topPading),
//                       child: CustomWidget.customTextField3(
//                           context: context, titleName: 'Item Name'),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 16.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.09),
//                                 offset: const Offset(
//                                   0.1,
//                                   1.5,
//                                 ),
//                                 spreadRadius: 1,
//                               ),
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.09),
//                                 offset: const Offset(
//                                   -0.1,
//                                   -0.001,
//                                 ),
//                                 spreadRadius: -1,
//                               ),
//                             ]),
//                         child: const TextField(
//                           // controller: aboutController,
//                           maxLines: 10,
//                           minLines: 5,
//                           keyboardType: TextInputType.multiline,
//                           decoration: InputDecoration(
//                               contentPadding: EdgeInsets.all(10),
//                               hintText: 'Description',
//                               border: InputBorder.none),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () async {},
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 16.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                                 alignment: Alignment.center,
//                                 height: 50,
//                                 width: MediaQuery.of(context).size.width * 0.5,
//                                 decoration: BoxDecoration(
//                                     color: CustomColors.buttonBackgroundColor,
//                                     borderRadius: BorderRadius.circular(50),
//                                     boxShadow: [
//                                       BoxShadow(
//                                           color: Colors.black.withOpacity(0.06),
//                                           offset: const Offset(
//                                             0,
//                                             2,
//                                           ),
//                                           spreadRadius: 3,
//                                           blurRadius: 1),
//                                     ]),
//                                 child: Text('Create',
//                                     style:
//                                         ButtonsStyle.buttonTextStyle(context))),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     ));
//   }
// }
