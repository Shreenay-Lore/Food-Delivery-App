import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/controller/password_controller.dart';
import 'package:get/get.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    super.key,
    this.controller, 
  });

  final TextEditingController? controller;


  @override
  Widget build(BuildContext context) {
    final PasswordController passwordController = Get.put(PasswordController());

    return Obx(
      ()=> TextFormField(
        cursorColor: kDark,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.visiblePassword,
        maxLines: 1,
        controller: controller,
        obscureText:  passwordController.password,
        validator: (value) {
          if(value!.isEmpty){
            return "Please enter valid password";
          }else{
            return null;
          }
        },
        decoration: InputDecoration(
          hintText: "Password",
          hintStyle: appStyle(12, kGrayLight, FontWeight.normal),
          isDense: true,
          suffixIcon: GestureDetector(
            onTap: () {
              passwordController.setPassword = !passwordController.password;
            },
            child: Icon(
              passwordController.password
              ? Icons.visibility
              : Icons.visibility_off,
              size: 22, 
              color: kGrayLight,
            ),
          ),
          prefixIcon: const Icon(CupertinoIcons.lock_circle, size: 26, color: kGrayLight,),
          contentPadding: EdgeInsets.all(6.h),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.r)),
            borderSide: const BorderSide(color: kRed, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.r)),
            borderSide: const BorderSide(color: kPrimary, width: 0.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.r)),
            borderSide: const BorderSide(color: kRed, width: 0.5),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.r)),
            borderSide: const BorderSide(color: kGray, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.r)),
            borderSide: const BorderSide(color: kPrimary, width: 0.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.r)),
            borderSide: const BorderSide(color: kPrimary, width: 0.5),
          ),
        ),
        
        //cursorHeight: 20.h,
        style: appStyle(12, kDark, FontWeight.normal),
        
      ),
    );
  }
}