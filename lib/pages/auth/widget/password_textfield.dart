import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/pages/auth/controllers/login_controller.dart';
import 'package:get/get.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    super.key,
    this.controller, 
  });

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put<LoginController>(LoginController());

    return Obx(
      () => Material(
        elevation: 3, 
        borderRadius: BorderRadius.circular(8.r), 
        color: kWhite,
        child: TextField(
          cursorColor: const Color.fromRGBO(0, 0, 0, 1),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.visiblePassword,
          maxLines: 1,
          controller: controller,
          obscureText: loginController.password,
          decoration: InputDecoration(
            hintText: "Password",
            hintStyle: appStyle(12, kGrayLight, FontWeight.normal),
            isDense: true,
            suffixIcon: GestureDetector(
              onTap: () {
                loginController.setPassword = !loginController.password;
              },
              child: Icon(
                loginController.password
                    ? Icons.visibility
                    : Icons.visibility_off,
                size: 22,
                color: kGrayLight,
              ),
            ),
            prefixIcon: const Icon(
              CupertinoIcons.lock_circle,
              size: 26,
              color: kGrayLight,
            ),
            contentPadding: EdgeInsets.all(6.h),
            focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
            borderSide: const BorderSide(color: kDark, width: 0.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
              borderSide: const BorderSide(color: Colors.black26, width: 0.5),
            ),
          ),
          style: appStyle(12, kDark, FontWeight.normal),
        ),
      ),
    );
  }
}
