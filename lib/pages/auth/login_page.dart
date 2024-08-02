import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/back_ground_container.dart';
import 'package:food_delivery_app/common/custom_buttom.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/pages/auth/controller/login_controller.dart';
import 'package:food_delivery_app/models/login_model.dart';
import 'package:food_delivery_app/pages/auth/registration_page.dart';
import 'package:food_delivery_app/pages/auth/widget/email_textfield.dart';
import 'package:food_delivery_app/pages/auth/widget/password_textfield.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: kOffWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kOffWhite,
        centerTitle: true,
        title: CustomText(
          text: "EatEz", 
          style: appStyle(20, kGray, FontWeight.bold),
        ),
      ),
      body: BackGroundContainer(
        child: ClipRRect(
            borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r), 
            topRight:  Radius.circular(20.r), 
          ),
          child: ListView(
            children: [
              SizedBox(height: 30.h,),

              LottieBuilder.asset("assets/anime/delivery.json"),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    EmailTextField(
                      hintText: "Email",
                      prefixIcon: const Icon(CupertinoIcons.mail, size: 22, color: kGrayLight,),
                      controller: _emailController,
                    ),

                    SizedBox(height: 25.h,),

                    PasswordTextField(
                      controller: _passwordController,
                    ),

                    SizedBox(height: 30.h,),

                    CustomButton(
                      text: "L O G I N",
                      onTap: (){
                        if(_emailController.text.isNotEmpty && _passwordController.text.length >= 8) {
                          LoginModel model = LoginModel(
                            email: _emailController.text, 
                            password: _passwordController.text
                          );

                          String data = loginModelToJson(model);

                          controller.loginFunction(data);
                        }
                      },
                      height: 35.h,
                      width: width,
                      borderRadius: 4.r,
                      backgroundColor: kPrimary,
                      textColor: kWhite,
                      borderColor: kPrimary,
                    ),

                    SizedBox(height: 30.h,),

                    GestureDetector(
                      onTap: (){
                        Get.to(()=> const RegistrationPage(),
                        transition: Transition.cupertino,
                        duration: const Duration(milliseconds: 1000),
                        );
                      },
                      child: CustomText(
                        text: "Register", 
                        style: appStyle(12, kGray, FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}