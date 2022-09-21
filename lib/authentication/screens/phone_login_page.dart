import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../repositry/utils/custom_widgets.dart';
import '../../repositry/utils/data_constants.dart';

class PhoneLoginPage extends StatefulWidget {
  const PhoneLoginPage({Key? key}) : super(key: key);

  @override
  State<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  late TextEditingController phoneController;
  GlobalKey globalKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    phoneController.dispose();
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
      body: Align(
        alignment: Alignment.topCenter,
        child: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.9,
          child: Column(children: [
            Text(
              "Great!\nLets get you started…",
              textAlign: TextAlign.start,
              style: GoogleFonts.tinos(
                textStyle: Theme.of(context).textTheme.headline4,
                fontWeight: FontWeight.bold,
                color: CustomColors.headingTextFontColor,
              ),
            ),
            const SizedBox(
              height: 150,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: CustomWidget.customTextField3(
                key: globalKey,
                titleName: 'Phone',
                context: context,
                controller: phoneController,
                textInputType: TextInputType.emailAddress,
                // validate: (value) =>
                //     ModelValidation.gmailValidation(value!)
              ),
            ),
             Padding(
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
                      child: Text('Create Account',
                          style:
                          ButtonsStyle.buttonTextStyle(context))),
                ],
              ),
            ),
          ],),),
        ),
      ),
    );
  }
}
