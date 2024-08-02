import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/constants/constants.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
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
    this.initialValue,
  });

  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final void Function()? onEditingComplete;
  final String? initialValue;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final String? hintText;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: kDark,
      textInputAction: TextInputAction.next,
      onEditingComplete: onEditingComplete,
      keyboardType: keyboardType ?? TextInputType.emailAddress,
      initialValue: initialValue,
      maxLines: maxLines ?? 1,
      controller: controller,
      validator: (value) {
        if(value!.isEmpty){
          return "Please enter valid data";
        }else{
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: appStyle(12, kGrayLight, FontWeight.normal),
        isDense: true,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        contentPadding: EdgeInsets.all(6.h),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.r)),
          borderSide: const BorderSide(color: kRed, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.r)),
          borderSide: const BorderSide(color: kPrimary, width: 0.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.r)),
          borderSide: const BorderSide(color: kRed, width: 0.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.r)),
          borderSide: const BorderSide(color: kGray, width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.r)),
          borderSide: const BorderSide(color: kPrimary, width: 0.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.r)),
          borderSide: const BorderSide(color: kPrimary, width: 0.5),
        ),
      ),
      obscureText: obscureText ?? false,
      //cursorHeight: 20.h,
      style: appStyle(12, kDark, FontWeight.normal),
      
    );
  }
}