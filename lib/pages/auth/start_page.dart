import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_buttom.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/routes/names.dart';
import 'package:get/get.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/images/login_bg.jpg', 
              fit: BoxFit.cover,
            ),
          ),
             
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white.withOpacity(0.3), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(
                  height: 40.h,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                  child: CustomText(
                    text: "Fast delivery\nof delicious food",
                    maxLines: 2,
                    style: appStyle(24.sp, kWhite, FontWeight.w900),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomText(
                    text: 'Get your food delivered to your doorstep\nwithin 30 minutes—fast, fresh, and \nhassle-free!',
                    maxLines: 3,
                    style: appStyle(12.sp, kWhite, FontWeight.w400),
                  ),
                ),


                const Spacer(),
                
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: CustomButton(
                      onTap: () {
                        Get.offAndToNamed(AppRoutes.onLoginPage);
                      },
                      height: 50.h,
                      width: double.infinity,
                      borderRadius: 12.r,
                      text: "G E T    S T A R T E D",
                      backgroundColor: kWhite,
                      textColor: kDark,
                      borderColor: kWhite,
                    ),
                  ),
                ),

                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
