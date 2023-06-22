import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wedding_planner/modelClasses/service_packages.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';
import 'package:wedding_planner/repository/utils/db_handler.dart';
import 'package:wedding_planner/repository/utils/my_custom_card.dart';
import 'package:wedding_planner/service_provider_interface/package_details.dart';

class ProviderPackages extends StatefulWidget {
  final String UID;
  static const pageName = '/ProviderPackages';
  const ProviderPackages({Key? key, this.UID = ''}) : super(key: key);

  @override
  State<ProviderPackages> createState() => _ProviderPackagesState();
}

class _ProviderPackagesState extends State<ProviderPackages> {
  late final CollectionReference providerPackages;
  @override
  void initState() {
   
    super.initState();
    providerPackages = DBHandler.providerPackages(UID: widget.UID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Image(
            image: AssetImage('assets/images/front_page.png'),
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: ScreenPadding.topPadding,
                left: ScreenPadding.leftPadding,
                right: ScreenPadding.rightPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    padding: const EdgeInsets.only(top: 8),
                    alignment: Alignment.topLeft,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: CustomColors.backGroundColor,
                    )),
                TextField(
                  // controller: searchController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: 'Search',
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(color: Colors.white38),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(24)),
                  ),
                ),
                // MyCustomCard.customCard(
                //   color: CustomColors.buttonBackgroundColor,
                //   height: 250.0,
                //   width: MediaQuery.of(context).size.width,
                //   child: Center(
                //     child: Text(
                //       'Awesome deals ready to\n delivered for you...',
                //       textAlign: TextAlign.center,
                //       style: TextStyle(
                //           fontSize: 30,
                //           fontWeight: FontWeight.bold,
                //           color: CustomColors.backGroundColor),
                //     ),
                //   ),
                // ),

                Expanded(
                  flex: 7,
                  child: StreamBuilder(
                    stream: providerPackages.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return MyCustomCard.customCard(
                                height: 150,
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      flex: 4,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        elevation: 2,
                                        color: Colors.white,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.40,
                                          decoration: BoxDecoration(
                                              //color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: CachedNetworkImage(
                                              imageUrl: snapshot.data!.docs[
                                                      index][
                                                  ModelServicePackages
                                                      .imageURLKey],
                                              alignment: Alignment.center,
                                              imageBuilder: (context,
                                                      imageProvider) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                              placeholder: (context, url) =>
                                                  const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Container()),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 6,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 16.0, left: 6.0, right: 6.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              snapshot.data!.docs[index][
                                                  ModelServicePackages
                                                      .offerNameKey],
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: CustomColors
                                                      .textFontColor),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  snapshot.data!.docs[index][
                                                              ModelServicePackages
                                                                  .discountKey] !=
                                                          0
                                                      ? RichText(
                                                          text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                    text:
                                                                        '${snapshot.data!.docs[index][ModelServicePackages.priceKey].toString()}',
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        decoration:
                                                                            TextDecoration
                                                                                .lineThrough,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                TextSpan(
                                                                    text:
                                                                        '  ${snapshot.data!.docs[index][ModelServicePackages.priceKey] - ((snapshot.data!.docs[index][ModelServicePackages.discountKey] / 100) * snapshot.data!.docs[index][ModelServicePackages.priceKey])}',
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ]),
                                                        )
                                                      : Text(
                                                          snapshot
                                                              .data!
                                                              .docs[index][
                                                                  ModelServicePackages
                                                                      .priceKey]
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: CustomColors
                                                                  .textFontColor),
                                                        ),
                                                  snapshot.data!.docs[index][
                                                              ModelServicePackages
                                                                  .discountKey] !=
                                                          0
                                                      ? Text(
                                                          '${snapshot.data!.docs[index][ModelServicePackages.discountKey].toString()}%',
                                                          style:
                                                              const TextStyle(
                                                                  // fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: CustomColors
                                                                      .textFontColor),
                                                        )
                                                      : const SizedBox()
                                                ],
                                              ),
                                            ),
                                            ////////
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20.0),
                                              child: Text(
                                                snapshot
                                                    .data!
                                                    .docs[index][
                                                        ModelServicePackages
                                                            .descriptionKey]
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: CustomColors
                                                        .textFontColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ));
                          },
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                // MyCustomCard.customCard(
                //   height: 250.0,
                //   width: MediaQuery.of(context).size.width,
                //   child: const Align(
                //     alignment: Alignment.bottomCenter,
                //     child: Text(
                //       'Standard Peckage',
                //       textAlign: TextAlign.center,
                //       style:
                //           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                //     ),
                //   ),
                // ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: MyCustomCard.customCard(
                //     height: 250.0,
                //     width: MediaQuery.of(context).size.width,
                //     child: Align(
                //       alignment: Alignment.bottomCenter,
                //       child: Text(
                //         'Basic Peckage',
                //         textAlign: TextAlign.center,
                //         style: TextStyle(
                //             fontSize: 20, fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: widget.UID == ''
          ? FloatingActionButton(
              backgroundColor: CustomColors.buttonBackgroundColor,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PackageDetails(),
                    ));
              },
              child: const Icon(Icons.add),
            )
          : const SizedBox(),
    );
  }
}
