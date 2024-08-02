import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';

class CommonAppBar extends StatelessWidget {
  final String title;
  final List<Widget>? actions;

  const CommonAppBar({
    super.key, 
    required this.title, 
    this.actions
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      child: AppBar(
        surfaceTintColor: kWhite,
        backgroundColor: kWhite,
        title: CustomText(
          text: title, 
          style: appStyle(14, kDark, FontWeight.w600)
        ),
        actions: actions,
      ),
    );
  }
}