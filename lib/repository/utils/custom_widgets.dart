import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'package:outline_gradient_button/outline_gradient_button.dart';

import 'data_constants.dart';
import 'my_custom_card.dart';

class CustomWidget {
  static Widget customContainer(
      {required Widget child,
      double height = double.infinity,
      double width = double.infinity,
      void Function()? onTap,
      bool borderEnabled = false}) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: CustomColors.buttonBackgroundColor,
          borderRadius: BorderRadius.circular(50),
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
      child: SizedBox(
        height: height,
        width: width,
        child: OutlineGradientButton(
            strokeWidth: 2,
            onTap: onTap,
            radius: const Radius.circular(50),
            inkWell: true,
            elevation: 5,
            backgroundColor: CustomColors.buttonBackgroundColor,
            gradient: borderEnabled
                ? LinearGradient(
                    colors: const [Colors.white, Colors.white],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0, width * 0.5])
                : const LinearGradient(colors: [Colors.white, Colors.white]),
            child: Center(child: child)),
      ),
    );
  }

  //////////////////////////////////////////////////
  static Widget customTextField3({
    TextEditingController? controller,
    String? initialValue,
    required BuildContext context,
    bool obscureText = false,
    String? titleName,
    bool readOnly = false,
    Widget? suffix,
    void Function()? onTap,
    FormFieldValidator<String>? validate,
    TextInputType textInputType = TextInputType.text,
    int? maxLength,
    Key? key,
    void Function(String)? onChanged,
    List<TextInputFormatter>? inputFormatters,
    String? prefixText,
    int? maxLines = 1,
    int? minLines = 1,
    EdgeInsetsGeometry? contentPadding = const EdgeInsets.only(left: 20),
  }) {
    return Container(
      height: 50,
      alignment: Alignment.center,
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
      child: TextFormField(
        controller: controller,
        key: key,
        onTap: onTap,
        onChanged: onChanged,
        readOnly: readOnly,
        inputFormatters: inputFormatters,
        validator: validate,
        autofocus: false,
        minLines: minLines,
        maxLines: maxLines,
        keyboardType: textInputType,
        maxLength: maxLength,
        obscureText: obscureText,
        cursorColor: Colors.black,
        // maxLines: 1,
        style: const TextStyle(color: CustomColors.textFontColor, fontSize: 14),
        decoration: InputDecoration(
          prefixText: prefixText,

          suffix: suffix,
          hintText: titleName,
          hintStyle:
              const TextStyle(color: CustomColors.textFontColor, fontSize: 14),
          fillColor: Colors.white70,
          border: InputBorder.none,
          // errorBorder:  OutlineInputBorder(borderRadius:BorderRadius.circular(50),borderSide: BorderSide(width: 1,color: Colors.red)),
          contentPadding: contentPadding,
        ),
      ),
    );
  }

  ////////////////////////////////DropDown//////////////////////

/*  static Widget dropdownButton2({
    required List items,
    double? dropDownMaxHeight,
    required BuildContext context,
    void Function(String?)? onChanged,
    void Function(String?)? onSaved,
    required String titleName,
    FormFieldValidator<String>? validate,
  }) {
    return Container(
      height: 50,
      alignment: Alignment.center,
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
      child: DropdownButtonFormField2(
          decoration: const InputDecoration(
            //isDense: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
          ),
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down,
              color: CustomColors.textFontColor),
          iconSize: 25,
          buttonHeight: 50,
          hint: Text(titleName,
              style: const TextStyle(
                  color: CustomColors.textFontColor, fontSize: 14)),
          style:
              const TextStyle(color: CustomColors.textFontColor, fontSize: 14),
          scrollbarAlwaysShow: true,
          scrollbarRadius: const Radius.circular(20),
          scrollbarThickness: 10,
          buttonPadding: const EdgeInsets.only(left: 20, right: 10),
          dropdownMaxHeight: 300,
          dropdownOverButton: false,
          dropdownDecoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                          color: CustomColors.textFontColor, fontSize: 14),
                    ),
                  ))
              .toList(),
          validator: validate,
          onChanged: onChanged,
          onSaved: onSaved),
    );
  }*/

  ////////////////////////////Drawer/////////////////////

  static Widget myCustomDrawer(
      {required BuildContext context,
      double? height = double.infinity,
      double? width = double.infinity,
      //Color? color,
      Widget? child}) {
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        color: CustomColors.greenish,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child: child,
    );
  }

  static Widget customCardButton({
    double? height,
    double? width,
    IconData? icon,
    double? iconSize,
    String? title,
    Color? color,
    required void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          MyCustomCard.customCard(
              height: height!,
              width: width!,
              color: color,
              child: Icon(
                icon!,
                size: iconSize!,
                color: CustomColors.buttonBackgroundColor,
              )),
          const SizedBox(
            height: 15,
          ),
          Text(
            title!,
            style: TextStyle(fontSize: 18, color: CustomColors.backGroundColor),
          )
        ],
      ),
    );
  }

  static Widget customCardForProfileData(
      {required String title, required String value}) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 1,
                child: Text(title,
                    style: const TextStyle(color: CustomColors.textFontColor))),
            Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(value,
                      style:
                          const TextStyle(color: CustomColors.textFontColor)),
                ))
          ],
        ),
      ),
    );
  }

  //Date picker method



  static Future<String> selectDateTime(BuildContext context) async {
    DateTime? combinedDateTime;
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );

    if (pickedDateTime != null) {

        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (pickedTime != null) {
          combinedDateTime = DateTime(
            pickedDateTime.year,
            pickedDateTime.month,
            pickedDateTime.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        }

    }
    return combinedDateTime.toString().substring(0,combinedDateTime.toString().length -7);
  }
}

Widget backButton(BuildContext context) {
  return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
        size: 30,
      ));
}

showCustomToast({required String msg}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
