import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedding_planner/repository/utils/data_constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backGroundColor,
      appBar: AppBar(
        backgroundColor: CustomColors.backGroundColor,
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme.copyWith(
              color: CustomColors.iconsColor,
            ),
        centerTitle: true,
        title: const SizedBox(
          height: 100,
        ),
      ),
      body: Center(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
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
                  color: CustomColors.buttonBackgroundColor,
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
            const ListTile(
              contentPadding: EdgeInsets.only(left: 24.0, right: 24),
              title: Text(
                'Name',
                //style: CustomColors.normalTextStyleWithBlackColor(context)
              ),
              trailing: Text(
                'Tim David',
                //style: CustomColors.normalTextStyleWithBlackColor(context)
              ),
            ),
            const ListTile(
              contentPadding: EdgeInsets.only(left: 24.0, right: 24),
              title: Text(
                'Mobile',
                //style: CustomColors.normalTextStyleWithBlackColor(context)
              ),
              trailing: Text(
                '+23477000000',
                //style: CustomColors.normalTextStyleWithBlackColor(context)
              ),
            ),
            const ListTile(
              contentPadding: EdgeInsets.only(left: 24.0, right: 24),
              title: Text(
                'Email',
                //style: CustomColors.normalTextStyleWithBlackColor(context)
              ),
              trailing: Text(
                'abc@gmail.com',
                //style: CustomColors.normalTextStyleWithBlackColor(context)
              ),
            ),
            const ListTile(
              contentPadding: EdgeInsets.only(left: 24.0, right: 24),
              title: Text(
                'Location',
                //style: CustomColors.normalTextStyleWithBlackColor(context)
              ),
              trailing: Text(
                'Lodhran,Pakistan',
                //style: CustomColors.normalTextStyleWithBlackColor(context)
              ),
            ),
            InkWell(
              onTap: () {
                // googleSignIn.disconnect().whenComplete(() async{
                //   await FirebaseAuth.instance.signOut();
                // });
              },
              child: const ListTile(
                  contentPadding: EdgeInsets.only(left: 24.0, right: 24),
                  title: Text(
                    'Log Out',
                    //style: CustomColors.normalTextStyleWithBlackColor(context)
                  ),
                  trailing: Icon(
                    Icons.logout,
                    color: CustomColors.headingTextFontColor,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
