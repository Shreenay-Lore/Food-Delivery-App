import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/constants/constants.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key,
    this.keyboardType, 
    this.controller, 
    this.obscureText, 
    this.prefixIcon,
    this.hintText,
    this.maxLines, 
  });

  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool? obscureText;
  final Widget? prefixIcon;
  final String? hintText;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3, 
      borderRadius: BorderRadius.circular(8.r), 
      color: kWhite,
      child: TextField(
        cursorColor: kDark,
        textInputAction: TextInputAction.next,
        keyboardType: keyboardType ?? TextInputType.emailAddress,
        maxLines: maxLines ?? 1,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: appStyle(12, kGrayLight, FontWeight.normal),
          isDense: true,
          prefixIcon: prefixIcon,
          contentPadding: EdgeInsets.all(6.h),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
            borderSide: const BorderSide(color: kDark, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
            borderSide: const BorderSide(color: Colors.black26, width: 0.5),
          ),
        ),
        obscureText: obscureText ?? false,
        //cursorHeight: 20.h,
        style: appStyle(12, kDark, FontWeight.normal),
        
      ),
    );
  }
}