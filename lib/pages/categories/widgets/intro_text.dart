import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/common/app_style.dart'; 
import 'package:food_delivery_app/constants/constants.dart';
class IntroTextWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const IntroTextWidget({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title,
            style: appStyle(15, kDark, FontWeight.bold),
          ),
          SizedBox(height: 7.h),
          CustomText(
            text: subtitle,
            style: appStyle(9, kGray, FontWeight.w500),
          ),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }
}
