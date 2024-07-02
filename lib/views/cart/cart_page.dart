import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/custom_container.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/controller/login_controller.dart';
import 'package:food_delivery_app/models/login_response.dart';
import 'package:food_delivery_app/views/auth/login_redirect.dart';
import 'package:food_delivery_app/views/auth/verification_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginResponse? user;

    final LoginController controller = Get.put(LoginController());

    final box = GetStorage();

    String? token = box.read("token");

    if(token != null){
      user = controller.getUserInfo();
    }

    if(token == null){
      return const LoginRedirectPage();
    }

    if(user != null &&  user.verification == false){
      return const VerificationPage();
    }

    return Scaffold(
      backgroundColor: kWhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130.h),
        child: Container(
          height: 130.h,
        ),
      ),
      body: SafeArea(
        child: CustomContainer(
          containerContent: Container(
             child: Text("CART PAGE"),
          ),
        ),
      ),
    );
  }
}