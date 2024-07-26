import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';

class Heading extends StatelessWidget {
  const Heading({super.key, required this.text, this.onTap, this.more});

  final String text;
  final void Function()? onTap;
  final bool? more;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: text, 
            style: appStyle(15.5, kDark, FontWeight.bold)
          ),
          
          more == null
          ? GestureDetector(
            onTap: onTap,
            child: Icon(
              AntDesign.appstore1, 
              color: kDark, 
              size: 20.sp,
            ),
          )
          : const SizedBox.shrink(),
        ],
      ),
    );
  }
}