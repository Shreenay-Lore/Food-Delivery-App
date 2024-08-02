import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/back_ground_container.dart';
import 'package:food_delivery_app/common/custom_buttom.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/pages/auth/controller/registration_controller.dart';
import 'package:food_delivery_app/models/registration_model.dart';
import 'package:food_delivery_app/pages/auth/widget/email_textfield.dart';
import 'package:food_delivery_app/pages/auth/widget/password_textfield.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late final TextEditingController _userNameController = TextEditingController();
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final RegistrationController controller = Get.put(RegistrationController());

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
                      hintText: "User Name",
                      keyboardType: TextInputType.text,
                      prefixIcon: const Icon(CupertinoIcons.person, size: 22, color: kGrayLight,),
                      controller: _userNameController,
                    ),

                    SizedBox(height: 25.h,),

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
                      onTap: (){
                        if(_userNameController.text.isNotEmpty && 
                           _emailController.text.isNotEmpty && 
                           _passwordController.text.length >= 8) {
                        RegistrationModel model = RegistrationModel(
                            username: _userNameController.text, 
                            email: _emailController.text, 
                            password: _passwordController.text);

                            String data = registrationModelToJson(model);

                            controller.registrationFunction(data);
                        }
                      },
                      height: 35.h,
                      width: width,
                      borderRadius: 4.r,
                      text: "R E G I S T E R",
                      backgroundColor: kPrimary,
                      textColor: kWhite,
                      borderColor: kPrimary,
                    ),

                    SizedBox(height: 30.h,),

                    // GestureDetector(
                    //   onTap: (){
                    //     Get.to(()=> const LoginPage(),
                    //     transition: Transition.leftToRight,
                    //     duration: const Duration(milliseconds: 900),
                    //     );
                    //   },
                    //   child: CustomText(
                    //     text: "Login", 
                    //     style: appStyle(12, kGray, FontWeight.normal),
                    //   ),
                    // ),
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