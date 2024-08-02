import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_buttom.dart';
import 'package:food_delivery_app/common/custom_container.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/pages/auth/controller/verification_controller.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:lottie/lottie.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final VerificationController controller = Get.put(VerificationController());

    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kWhite,
        elevation: 0,
        title: CustomText(
          text: "Verify Account",
          style: appStyle(12, kGray, FontWeight.w600),
        ),
      ),
      body: CustomContainer(
        color: kWhite,
        containerContent: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: SizedBox(
            height: height,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                LottieBuilder.asset("assets/anime/delivery.json",),
          
                SizedBox(height: 30.h,),
          
                CustomText(
                  text: "Verify Your Account",
                  style: appStyle(20, kPrimary, FontWeight.w600),
                ),

                SizedBox(height: 5.h,),

                Text(
                  "Enter the 6-digit code sent to your email, if you don't see the code, please check your spam folder.",
                  style: appStyle(10, kGray, FontWeight.normal),
                  textAlign: TextAlign.justify,
                ),

                SizedBox(height: 35.h,),

                OTPTextField(
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  otpFieldStyle: OtpFieldStyle(
                    borderColor: kPrimary 
                  ),
                  spaceBetween: 0,
                  fieldWidth: 50.w,
                  style: appStyle(17, kDark, FontWeight.w600),
                  onChanged: (value) {},
                  keyboardType: TextInputType.number,
                  textFieldAlignment: MainAxisAlignment.spaceBetween,
                  fieldStyle: FieldStyle.box,
                  onCompleted: (String pin) {
                    controller.setOtp = pin;
                  },
                ),

                

                SizedBox(height: 50.h,),

                CustomButton(
                  onTap: (){
                    controller.verificationFunction();
                  },
                  height: 35.h,
                  borderRadius: 4.r,
                  text: "V E R I F Y",
                  backgroundColor: kPrimary,
                  borderColor: kPrimary,
                  textColor: kWhite,
                ),
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}