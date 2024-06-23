import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final double? borderRadius;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final Color textColor;
  final FontWeight fontWeight;
  final double fontSize;

  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.width = 195,
    this.height,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    this.borderRadius,
    this.backgroundColor = kWhite,
    this.borderColor = kDark,
    this.borderWidth = 0.3,
    this.textColor = kDark,
    this.fontWeight = FontWeight.w600,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? width,
        height: height ?? 28.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 9.r),
          border: Border.all(color: borderColor, width: borderWidth),
        ),
        padding: padding,
        child: GestureDetector(
          onTap: onTap,
          child: CustomText(
            text: text,
            style: appStyle(
              fontSize, 
              textColor, 
              fontWeight
            )
          ),
        ),
      ),
    );
  }
}
