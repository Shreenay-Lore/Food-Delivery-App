import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/constants/constants.dart';

class BackGroundContainer extends StatelessWidget {
  const BackGroundContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r), 
          topRight:  Radius.circular(20.r), 
        ),
        image: const DecorationImage(
          image: AssetImage(
            'assets/images/restaurant_bk.png',
          ),
          fit: BoxFit.cover,
          opacity: 0.7
        )
      ),
      child: child,
    );
  }
}