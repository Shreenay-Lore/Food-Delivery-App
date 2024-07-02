import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kWhite,
      elevation: 0,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 12.w),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/usa.svg",
                height: 25.h,
              ),
              SizedBox(width: 5.w,),
              Container(
                color: kGray,
                height: 15.h,
                width: 1.w,
              ),
              SizedBox(width: 5.w,),
              CustomText(text: "USA", style: appStyle(16, kDark, FontWeight.normal)),
              SizedBox(width: 5.w,),
              GestureDetector(
                onTap: (){
                  // Redirect to Settings //
                },
                child: Icon(
                  SimpleLineIcons.settings,
                  size: 18.h,
                ),
              ),       
            ],
          ),
        )
      ],
    );
  }
}