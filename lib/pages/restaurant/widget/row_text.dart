import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';

class RowText extends StatelessWidget {
  const RowText({
    super.key,
    required this.firstText,
    required this.secondText,
    this.firstTextColor = kGray,
    this.secondTextColor = kGray,
    this.firstFontSize = 10.0,
    this.secondFontSize = 10.0,
    this.firstFontWeight = FontWeight.w500,
    this.secondFontWeight = FontWeight.w500,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.spacing = 0.0,
  });

  final String firstText;
  final String secondText;
  final Color firstTextColor;
  final Color secondTextColor;
  final double firstFontSize;
  final double secondFontSize;
  final FontWeight firstFontWeight;
  final FontWeight secondFontWeight;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        CustomText(
          text: firstText,
          style: appStyle(firstFontSize, firstTextColor, firstFontWeight),
        ),
        SizedBox(width: spacing),
        CustomText(
          text: secondText,
          style: appStyle(secondFontSize, secondTextColor, secondFontWeight),
        ),
      ],
    );
  }
}
