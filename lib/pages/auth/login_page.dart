import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_buttom.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/pages/auth/controllers/login_controller.dart';
import 'package:food_delivery_app/pages/auth/widget/email_textfield.dart';
import 'package:food_delivery_app/pages/auth/widget/password_textfield.dart';
import 'package:food_delivery_app/routes/names.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: ListView(
        children: [
          SizedBox(height: 50.h),
          _buildWelcomeText(),
          SizedBox(height: 20.h),
          _buildLoginForm(),
          SizedBox(height: 130.h),
          _buildBottomImage(),
        ],
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CustomText(
        text: "Welcome back! Glad\nto see you, Again!",
        maxLines: 2,
        style: appStyle(24.sp, Colors.black87, FontWeight.w600),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          EmailTextField(
            hintText: "Email",
            prefixIcon: const Icon(CupertinoIcons.mail, size: 22, color: kGrayLight),
            controller: controller.emailController,
          ),
          SizedBox(height: 20.h),
          PasswordTextField(
            controller: controller.passwordController,
          ),
          SizedBox(height: 35.h),
          CustomButton(
            text: "L O G I N",
            onTap: controller.onLoginButtonPressed,
            height: 45.h,
            width: double.infinity,
            borderRadius: 8.r,
            backgroundColor: kDark,
            textColor: kWhite,
          ),
          SizedBox(height: 30.h),
          _buildRegisterButton(),
        ],
      ),
    );
  }

  Widget _buildRegisterButton() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.onRegistrationPage);
      },
      child: CustomText(
        text: "Register",
        style: appStyle(12, kGray, FontWeight.normal),
      ),
    );
  }

  Widget _buildBottomImage() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Image.asset(
        'assets/images/login_sign_up_bg.jpg',
        fit: BoxFit.fitHeight,
        height: 250.h,
      ),
    );
  }


}
