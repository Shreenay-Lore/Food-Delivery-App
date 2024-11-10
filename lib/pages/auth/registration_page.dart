import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_buttom.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/pages/auth/controllers/registration_controller.dart';
import 'package:food_delivery_app/pages/auth/widget/email_textfield.dart';
import 'package:food_delivery_app/pages/auth/widget/password_textfield.dart';
import 'package:food_delivery_app/routes/names.dart';
import 'package:get/get.dart';

class RegistrationPage extends GetView<RegistrationController> {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: ListView(
        children: [
          SizedBox(height: 50.h),
          _buildWelcomeText(),
          SizedBox(height: 20.h),
          _buildRegistrationForm(),
          SizedBox(height: 70.h),
          _buildBottomImage(),
        ],
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CustomText(
        text: "Hello! Register to get\nstarted.",
        maxLines: 2,
        style: appStyle(24.sp, Colors.black87, FontWeight.w600),
      ),
    );
  }

  Widget _buildRegistrationForm() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          _buildUserNameField(),
          SizedBox(height: 20.h),
          _buildEmailField(),
          SizedBox(height: 20.h),
          _buildPasswordField(),
          SizedBox(height: 35.h),
          _buildRegisterButton(),
          SizedBox(height: 30.h),
          _buildLoginButton(),
        ],
      ),
    );
  }

  Widget _buildUserNameField() {
    return EmailTextField(
      hintText: "User Name",
      keyboardType: TextInputType.text,
      prefixIcon: const Icon(CupertinoIcons.person, size: 22, color: kGrayLight),
      controller: controller.userNameController,
    );
  }

  Widget _buildEmailField() {
    return EmailTextField(
      hintText: "Email",
      prefixIcon: const Icon(CupertinoIcons.mail, size: 22, color: kGrayLight),
      controller: controller.emailController,
    );
  }

  Widget _buildPasswordField() {
    return PasswordTextField(
      controller: controller.passwordController,
    );
  }

  Widget _buildRegisterButton() {
    return CustomButton(
      onTap: controller.onRegisterButtonPressed,
      text: "R E G I S T E R",
      height: 45.h,
      width: double.infinity,
      borderRadius: 8.r,
      backgroundColor: kDark,
      textColor: kWhite,
    );
  }

  Widget _buildLoginButton() {
    return GestureDetector(
      onTap: () {
        Get.offAllNamed(AppRoutes.onLoginPage);
      },
      child: CustomText(
        text: "Login",
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
