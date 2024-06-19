import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/constants/constants.dart';

// ignore: must_be_immutable
class CustomContainer extends StatelessWidget {
  Widget containerContent;
  Color? color;

  CustomContainer({
    super.key,
    this.color,
    required this.containerContent,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.80,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r) 
        ),
        child: Container(
          width: width,
          color: color ?? kOffWhite,
          child: SingleChildScrollView(
            child: containerContent,
          ),
        ),
      ),
    );
  }
}