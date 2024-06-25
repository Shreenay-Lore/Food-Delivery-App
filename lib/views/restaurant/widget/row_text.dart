
import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';

class RowText extends StatelessWidget {
  const RowText({
    super.key,
    required this.firstText,
    required this.secondText,
  });

  final String firstText;
  final String secondText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: firstText, 
          style: appStyle(10, kGray, FontWeight.w500)
        ),
        
        CustomText(
          text: secondText, 
          style: appStyle(10, kGray, FontWeight.w500)
        ),
      ],
    );
  }
}
