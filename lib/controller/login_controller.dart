// ignore_for_file: prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/models/api_error.dart';
import 'package:food_delivery_app/models/login_response.dart';
import 'package:food_delivery_app/views/auth/verification_page.dart';
import 'package:food_delivery_app/views/entry_point.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController{
  final box = GetStorage();
  
  RxBool _isLoading  = false.obs;

  bool get isLoading => _isLoading.value;

  set setLoading(bool value){
    _isLoading.value = value;
  }


  void loginFunction(String data) async {
    setLoading = true;

    Uri url = Uri.parse('$appBaseUrl/login');

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
          backgroundColor: kPrimary,
          icon: const Icon(Ionicons.fast_food_outline)
        );

        if(data.verification == false){
          Get.offAll(()=> const VerificationPage(),
          transition: Transition.fade,
          duration: const Duration(milliseconds: 900),);
        }

        if(data.verification == true){
          Get.offAll(()=> MainScreen(),
          transition: Transition.fade,
          duration: const Duration(milliseconds: 900),);
        }

      }else{
        var error = apiErrorFromJson(response.body);
        Get.snackbar(
          "Failed to login", error.message,
          colorText: kWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.error)
        );

      }

    }catch(e){
      debugPrint(e.toString());
    }
  }
  

  void logout(){
    box.erase();
    Get.offAll(()=> MainScreen(),
        transition: Transition.fade,
        duration: const Duration(milliseconds: 900));
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