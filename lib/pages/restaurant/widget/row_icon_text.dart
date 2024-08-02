
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';

class RowIconText extends StatelessWidget {
  const RowIconText({
    super.key,
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.black, 
          size: 14.h
        ),
        SizedBox(width: 5.w,),
        CustomText(
          text: text, 
          style: appStyle(10, kGray, FontWeight.w500)
        ),
      ],
    );
  }
}
