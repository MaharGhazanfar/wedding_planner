import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';

import 'data_constants.dart';
class CustomWidget {

static Widget customContainer({required Widget child,
    double height = double.infinity,
    double width = double.infinity,
    void Function()? onTap,
    bool borderEnabled = false}) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
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
            backgroundColor: Colors.white,
            gradient: borderEnabled
                ? LinearGradient(
                colors: [Colors.orange, Colors.pink.shade200],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0, width * 0.5])
                : const LinearGradient(colors: [Colors.white, Colors.white70]),
            child: Center(child: child)),
      ),
    );
  }

  //////////////////////////////////////////////////
static Widget customTextField3(
    {TextEditingController? controller,
      String? initialValue,
      required BuildContext context,
      bool obscureText = false,
      String? titleName,
      Widget? suffix,
      FormFieldValidator<String>? validate,
      TextInputType textInputType = TextInputType.text,
      int? maxLength,
      Key? key,
      List<TextInputFormatter>? inputFormatters,
      String? prefixText}) {
  return Container(
    height: 50,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: Colors.white,
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
    child: TextFormField(
      controller: controller,
      key: key,
      inputFormatters: inputFormatters,
      validator: validate,
      keyboardType: textInputType,
      maxLength: maxLength,
      obscureText: obscureText,
      cursorColor: Colors.black,

      // maxLines: 1,
      style: GoogleFonts.tinos(
          textStyle: Theme.of(context).textTheme.bodyText1,
          color: CustomColors.textFontColor,
          fontSize: 14),
      decoration: InputDecoration(
        prefixText: prefixText,

        suffix: suffix,
        hintText: titleName,
        hintStyle: GoogleFonts.tinos(
            textStyle: Theme.of(context).textTheme.bodyText1,
            color: CustomColors.textFontColor,
            fontSize: 14),
        fillColor: Colors.white70,
        border:  InputBorder.none,
        // errorBorder:  OutlineInputBorder(borderRadius:BorderRadius.circular(50),borderSide: BorderSide(width: 1,color: Colors.red)),
        contentPadding: const EdgeInsets.only(left: 20),
      ),
    ),
  );
}
}