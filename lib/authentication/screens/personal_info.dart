import 'package:flutter/material.dart';

import '../../repositry/utils/data_constants.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({Key? key}) : super(key: key);

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
 late TextEditingController firstNameController;
 late TextEditingController lastNameController;
 late TextEditingController phoneNameController;
 var globalKey = GlobalKey<FormState>();

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneNameController = TextEditingController();
  }
  @override
  void dispose() {
   firstNameController.dispose();
   lastNameController.dispose();
   phoneNameController.dispose();
   // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Form(
              key: globalKey,
              child: Column(children: [],),
            ),
          ),
        ),
      ),
    );
  }
}
