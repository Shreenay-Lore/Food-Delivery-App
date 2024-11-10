import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_buttom.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/pages/auth/controllers/email_verification_controller.dart';
import 'package:food_delivery_app/routes/names.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:lottie/lottie.dart';

class EmailVerificationPage extends GetView<EmailVerificationController> {
  const EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 80.h, horizontal: 10.w),
        children: [
          _buildAnimation(),
          SizedBox(height: 30.h),
          _buildTitle(),
          SizedBox(height: 40.h),
          _buildOtpField(context),
          SizedBox(height: 20.h),
          _buildVerifyButton(),
          SizedBox(height: 50.h),
          _buildGoBackButton(),
        ],
      ),
    );
  }

  Widget _buildAnimation() {
    return LottieBuilder.asset(
      "assets/anime/email_otp_verify.json",
      height: 250.h,
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          "OTP Verification",
          textAlign: TextAlign.center,
          style: appStyle(24.sp, Colors.black87, FontWeight.w600),
        ),
        SizedBox(height: 5.h),
        Text(
          "Enter the 6-digit code sent to your email. If you don't see the code, please check your spam folder.",
          style: appStyle(9.sp, kGray, FontWeight.normal),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }


  Widget _buildOtpField(BuildContext context) {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width,
      otpFieldStyle: OtpFieldStyle(borderColor: kPrimary),
      spaceBetween: 0,
      fieldWidth: 50.w,
      style: appStyle(17.sp, kDark, FontWeight.w600),
      keyboardType: TextInputType.number,
      textFieldAlignment: MainAxisAlignment.spaceBetween,
      fieldStyle: FieldStyle.box,
      onCompleted: (String pin) {
        controller.setOtp = pin;
      },
    );
  }

  Widget _buildVerifyButton() {
    return CustomButton(
      onTap: controller.onTapVerifyButton,
      height: 45.h,
      text: "V E R I F Y",
      borderRadius: 8.r,
      backgroundColor: kDark,
      textColor: kWhite,
    );
  }

  Widget _buildGoBackButton() {
    return GestureDetector(
      onTap: () {
        Get.offAllNamed(AppRoutes.onLoginPage);
      },
      child: Text(
        "Go back to login methods",
        textAlign: TextAlign.center,
        style: appStyle(10.sp, kRed, FontWeight.w600),
      ),
    );
  }
}
