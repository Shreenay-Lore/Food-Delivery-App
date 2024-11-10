import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/pages/auth/controllers/phone_verification_controller.dart';
import 'package:food_delivery_app/services/verification_service.dart';
import 'package:get/get.dart';
import 'package:phone_otp_verification/phone_verification.dart';

class PhoneVerificationPage extends GetView<PhoneVerificationController> {
  const PhoneVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final VerificationService verificationService = VerificationService();
    return Obx(() => controller.isLoading == false 
      ? PhoneVerification(
          isFirstPage: false,
          enableLogo: false,
          themeColor: kDark,
          backgroundColor: kLightWhite,
          initialPageText: "Verify Phone Number",
          initialPageTextStyle: appStyle(18.sp, Colors.black87, FontWeight.w600),
          textColor: kDark,
          onSend: (String value) {
            controller.setPhoneNumber = value;
            _verifyPhoneNumber(value, controller, verificationService);
          },
          onVerification: (String value) {
            print('OTP: $value');
            _submitVerificationCode(value, controller, verificationService);
          },
        )
      : Container(
        color: kLightWhite,
        width: width,
        height: height,
        child: const Center(
          child: CircularProgressIndicator()
          ),
        ),
    );
  }

  void _verifyPhoneNumber(String phoneNumber,
      PhoneVerificationController controller,
      VerificationService verificationService) async {

    await verificationService.verifyPhoneNumber(
      controller.phone, 
      codeSend: (String verificationId, int? resendToken) {
        controller.setVerificationId = verificationId;
      },
    );
  }

  void _submitVerificationCode(
      String code,
      PhoneVerificationController controller,
      VerificationService verificationService) async {
    await verificationService.verifySmsCode(controller.verificationId, code);
  }


}