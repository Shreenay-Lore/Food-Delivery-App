import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_buttom.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/views/auth/login_page.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginRedirectPage extends StatelessWidget {
  const LoginRedirectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kWhite,
        centerTitle: true,
        title: CustomText(
          text: "Please login to access this page", 
          style: appStyle(12, kGray, FontWeight.w500),
        ),
      ),
      body: Container(
        color: kWhite,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 0.h),
              child: LottieBuilder.asset(
                "assets/anime/delivery.json",
                width: width,
                height: height/2,
              ),
            ),
            
            CustomButton(
              onTap: (){
                Get.to(()=> const LoginPage(),
                transition: Transition.cupertino,
                duration: const Duration(milliseconds: 900),
                );
              },
              height: 40.h,
              borderRadius: 4.r,
              text: "L O G I N",
              backgroundColor: kPrimary,
              textColor: kWhite,
              borderColor: kPrimary,
            ),
          ],
        ),
      ),
    );
  }
}