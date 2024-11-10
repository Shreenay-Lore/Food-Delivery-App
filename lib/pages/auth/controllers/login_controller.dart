// ignore_for_file: prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/data/apis/app_url.dart';
import 'package:food_delivery_app/models/api_error.dart';
import 'package:food_delivery_app/models/login_model.dart';
import 'package:food_delivery_app/models/login_response.dart';
import 'package:food_delivery_app/routes/names.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController{
  final box = GetStorage();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  

  RxBool _isLoading  = false.obs;

  bool get isLoading => _isLoading.value;

  set setLoading(bool value){
    _isLoading.value = value;
  }


  final RxBool _password = true.obs;

  bool get password => _password.value;

  set setPassword(bool newState){
    _password.value = newState;
  }


  void loginFunction(String data) async {
    setLoading = true;

    Uri url = Uri.parse('${AppUrl.baseUrl}/login');

    Map<String, String> headers = {'Content-Type': 'application/json'};

    try{  
      print('Making request to: $url');

      var response = await http.post(
        url,
        headers: headers,
        body: data,
      );
      
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      if(response.statusCode == 200){
        LoginResponse data = loginResponseFromJson(response.body);

        String userId = data.id;
        String userData = jsonEncode(data);

        box.write(userId, userData);
        box.write("token", data.userToken);
        box.write("userId", data.id);
        box.write("verification", data.verification);

        setLoading = false;
        
        Get.snackbar(
          "You are successfully logged in.", "Order Food! ",
          colorText: kWhite,
          backgroundColor: kDark,
          icon: const Icon(Ionicons.fast_food_outline)
        );

        if(data.verification == false){
          Get.offAllNamed(AppRoutes.onEmailVerificationPage);
        }

        if(data.verification == true){
          Get.offAllNamed(AppRoutes.onMainNavBarPage);
        }

      }else{
        var error = apiErrorFromJson(response.body);
        Get.snackbar(
          "Failed to login", error.message!,
          colorText: kWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.error)
        );
      }
    }catch(e){
      debugPrint(e.toString());
    }
  }

  void onLoginButtonPressed() {
    if (emailController.text.isEmpty) {
      Get.snackbar(
        "Email Address",
        "Please enter your email.",
        backgroundColor: kRed,
        colorText: kWhite,
      );
    } else if (passwordController.text.length < 8) {
      Get.snackbar(
        "Password",
        "Password must be at least 8 characters long.",
        backgroundColor: kRed,
        colorText: kWhite,
      );
    } else {
      LoginModel model = LoginModel(
        email: emailController.text,
        password: passwordController.text,
      );
      String data = loginModelToJson(model);
      loginFunction(data);
    }
  }


  void logout(){
    box.erase();
    Get.offAllNamed(AppRoutes.onLoginPage);
  }


  LoginResponse? getUserInfo(){
    String? userId = box.read("userId");
    String? data;

    if(userId != null){
      data = box.read(userId.toString());
    }

    if(data != null){
      return loginResponseFromJson(data);
    }
    return null;
  }


}