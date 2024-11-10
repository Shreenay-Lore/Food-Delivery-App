import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/data/apis/app_url.dart';
import 'package:food_delivery_app/models/login_response.dart';
import 'package:food_delivery_app/routes/names.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class EmailVerificationController extends GetxController{
  final box = GetStorage();

  String _otp  = "";

  String get otp => _otp;

  set setOtp(String value){
    _otp = value;
  }

  
  RxBool _isLoading  = false.obs;

  bool get isLoading => _isLoading.value;

  set setLoading(bool value){
    _isLoading.value = value;
  }


  void verificationFunction() async {
    setLoading = true;
    String accessToken = box.read('token');

    Uri url = Uri.parse('${AppUrl.baseUrl}/api/users/verify/$otp');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization' : 'Bearer $accessToken',
    };

    try{  
      print('Making request to: $url');

      var response = await http.get(
        url,
        headers: headers,
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
          "Your account is successfully verified.", "Order Food Now! ",
          colorText: kWhite,
          backgroundColor: kDark,
          icon: const Icon(Ionicons.fast_food_outline)
        );

        Get.offAllNamed(AppRoutes.onMainNavBarPage);

      }else{
        //var error = apiErrorFromJson(response.body);
        Get.snackbar( 
          "Failed to Verify Account", "Please enter valid OTP",
          colorText: kWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.error)
        );
      }
    }catch(e){
      debugPrint(e.toString());
    }
  }


  void onTapVerifyButton() {
    if (otp.isEmpty) {
      Get.snackbar(
        "OTP Validation",
        "OTP must be 6-digits long.",
        backgroundColor: kRed,
        colorText: kWhite,
      );
    } else {
      verificationFunction();
    }
  }
  
}