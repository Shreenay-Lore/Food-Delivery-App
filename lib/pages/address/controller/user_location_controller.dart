// ignore_for_file: prefer_final_fields


import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/models/api_error.dart';
import 'package:food_delivery_app/pages/main_screen/entry_point.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class UserLocationController extends GetxController{
  final box = GetStorage();

  RxBool _isDefault  = false.obs;

  bool get isDefault => _isDefault.value;

  set setIsDefault(bool value){
    _isDefault.value = value;
  }
  

  RxInt _tabIndex  = 0.obs;

  int get tabIndex => _tabIndex.value;

  set setTabIndex(int value){
    _tabIndex.value = value;
  }


  RxString _address  = ''.obs;

  String get address => _address.value;

  set setAddress(String value){
    _address.value = value;
  }

  ///Google API Function..
  ///

  void addAddress(String data,) async {
    String accessToken = box.read('token');

    Uri url = Uri.parse('$appBaseUrl/api/address');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization' : 'Bearer $accessToken',
    };

    try{  
      print('Making request to: $url');

      var response = await http.post(
        url,
        headers: headers,
        body: data,
      );
      
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      if(response.statusCode == 201){
        
        Get.snackbar(
          "Your address has been added.", "Order Food! ",
          colorText: kWhite,
          backgroundColor: kPrimary,
          icon: const Icon(Ionicons.fast_food_outline)
        );

        Get.offAll(()=> MainScreen());

      }else{
        var error = apiErrorFromJson(response.body);
        Get.snackbar( 
          "Failed to add address", error.message,
          colorText: kWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.error)
        );

      }

    }catch(e){
      debugPrint(e.toString());
    }
  }
  
  void setDefaultAddress(String addressId,) async {
    String accessToken = box.read('token');

    Uri url = Uri.parse('$appBaseUrl/api/address/default/$addressId');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization' : 'Bearer $accessToken',
    };

    try{  
      print('Making request to: $url');

      var response = await http.patch(
        url,
        headers: headers,
      );
      
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      if(response.statusCode == 200){
        
        Get.snackbar(
          "Address set as default", "Order Food! ",
          colorText: kWhite,
          backgroundColor: kDark,
          icon: const Icon(Ionicons.fast_food_outline)
        );

        Get.offAll(()=> MainScreen());

      }else{
        var error = apiErrorFromJson(response.body);
        Get.snackbar( 
          "Failed to set address as default", error.message,
          colorText: kWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.error)
        );

      }

    }catch(e){
      debugPrint(e.toString());
    }
  }
  
}