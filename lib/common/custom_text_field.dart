import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/constants/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.keyboardType, 
    this.controller, 
    this.onEditingComplete, 
    this.obscureText, 
    this.suffixIcon, 
    this.prefixIcon,
    this.validator,
    this.hintText,
    this.maxLines, 
    this.focusNode, 
    this.onTap, 
    this.readOnly,
    this.borderColor,
    this.fillColor,
  });

  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final void Function()? onEditingComplete;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final String? hintText;
  final int? maxLines;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final bool? readOnly;
  final Color? borderColor;
  final Color? fillColor; 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6.h),
      padding: EdgeInsets.only(left: 6.h),
      decoration: BoxDecoration(
        color: fillColor ?? Colors.transparent,
        border: Border.all(color: borderColor ?? kGray, width: 0.4),
        borderRadius: BorderRadius.circular(9.r),
      ),
      child: TextFormField(
        maxLines: maxLines ?? 1,
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        onEditingComplete: onEditingComplete,
        obscureText: obscureText ?? false,
        cursorHeight: 20.h,
        style: appStyle(11, kDark, FontWeight.normal),
        validator: validator,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: appStyle(11, kDark, FontWeight.normal),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          contentPadding: EdgeInsets.symmetric(vertical: 15.h), 
        ),
        onTap: onTap,
        readOnly: readOnly ?? false,
      ),
    );
  }
}
