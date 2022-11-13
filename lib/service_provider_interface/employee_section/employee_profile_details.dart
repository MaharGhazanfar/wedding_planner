import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';

class EmployeeProfilePage extends StatefulWidget {
  const EmployeeProfilePage({Key? key}) : super(key: key);

  @override
  State<EmployeeProfilePage> createState() => _EmployeeProfilePageState();
}

class _EmployeeProfilePageState extends State<EmployeeProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: CustomColors.backGroundColor,
      // appBar: AppBar(
      //   backgroundColor: CustomColors.backGroundColor,
      //   elevation: 0,
      //   iconTheme: Theme.of(context).iconTheme.copyWith(
      //       //color: CustomColors.iconsColor,
      //       ),
      //   centerTitle: true,
      //   title: const SizedBox(
      //     height: 100,
      //   ),
      // ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/white_background.png",
              alignment: Alignment.center, fit: BoxFit.fill),
          Padding(
            padding: const EdgeInsets.only(top: ScreenPading.topPading),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                // IconButton(
                //     padding: EdgeInsets.only(top: 16),
                //     alignment: Alignment.topLeft,
                //     onPressed: () {
                //       Navigator.pop(context);
                //     },
                //     icon: Icon(
                //       Icons.arrow_back_ios,
                //       color: CustomColors.backGroundColor,
                //     )),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0, bottom: 8),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 120,
                      color: CustomColors.greenish,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Edit',
                    style: GoogleFonts.tinos(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: ScreenPading.topPading,
                      left: ScreenPading.leftPading,
                      right: ScreenPading.rightPading),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Card(
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.only(left: 24.0, right: 24),
                          title: Text(
                            'Name',
                            //style: CustomColors.normalTextStyleWithBlackColor(context)
                          ),
                          trailing: Text(
                            'Tim David',
                            //style: CustomColors.normalTextStyleWithBlackColor(context)
                          ),
                        ),
                      ),
                      const Card(
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.only(left: 24.0, right: 24),
                          title: Text(
                            'Mobile',
                            //style: CustomColors.normalTextStyleWithBlackColor(context)
                          ),
                          trailing: Text(
                            '+23477000000',
                            //style: CustomColors.normalTextStyleWithBlackColor(context)
                          ),
                        ),
                      ),
                      const Card(
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.only(left: 24.0, right: 24),
                          title: Text(
                            'Email',
                            //style: CustomColors.normalTextStyleWithBlackColor(context)
                          ),
                          trailing: Text(
                            'abc@gmail.com',
                            //style: CustomColors.normalTextStyleWithBlackColor(context)
                          ),
                        ),
                      ),
                      const Card(
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.only(left: 24.0, right: 24),
                          title: Text(
                            'Location',
                            //style: CustomColors.normalTextStyleWithBlackColor(context)
                          ),
                          trailing: Text(
                            'Lodhran,Pakistan',
                            //style: CustomColors.normalTextStyleWithBlackColor(context)
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // googleSignIn.disconnect().whenComplete(() async{
                          //   await FirebaseAuth.instance.signOut();
                          // });
                        },
                        child: const ListTile(
                          contentPadding:
                              EdgeInsets.only(left: 24.0, right: 24),
                          title: Text(
                            'Log Out',
                            // style: TextStyle(color: Colors.white10),
                          ),
                          // trailing: Icon(
                          //   Icons.logout,
                          //   color: CustomColors.headingTextFontColor,
                          // )
                          // tileColor: Colors.white10,
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: ScreenPading.topPading,
                            left: ScreenPading.leftPading),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'RATE ON PLAY STORE',
                              style: TextStyle(color: Colors.black54),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 24.0),
                              child: Text(
                                'SEND US FEEDBACK',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 24.0),
                              child: Text(
                                'SHARE THIS APP',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 24.0),
                              child: Text(
                                'PRIVACY POLICY',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
