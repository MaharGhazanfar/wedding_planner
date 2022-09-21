import 'package:flutter/material.dart';

import '../../repositry/utils/data_constants.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({Key? key}) : super(key: key);

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
 late TextEditingController firstNameController;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
              child: Column(),
            ),
          ),
        ),
      ),
    );
  }
}
