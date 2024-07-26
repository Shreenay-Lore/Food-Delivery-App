// ignore_for_file: prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/models/api_error.dart';
import 'package:food_delivery_app/models/cart_count_response_mode.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController{
  final box = GetStorage();
  
  RxBool _isLoading  = false.obs;

  bool get isLoading => _isLoading.value;

  set setLoading(bool value){
    _isLoading.value = value;
  }
  
  RxString _count  = ''.obs;

  String get count => _count.value;

  set updateCount(String value){
    _count.value = value;
  }



  void addToCart(String cart) async {
    setLoading = true;
    String accessToken = box.read('token');

    Uri url = Uri.parse('$appBaseUrl/api/cart');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization' : 'Bearer $accessToken',
    };

    try{  
      print('Making request to: $url');

      var response = await http.post(
        url,
        headers: headers,
        body: cart,
      );

      // var cartItem = jsonDecode(cart);
      // print("aaaaaaaaaaaaaaaaaaaaaaaasssssssssss${cartItem}.");
      // if (cartItem["quantity"] == 2) {
      //   Get.snackbar(
      //     "Error", "Already",
      //     colorText: kWhite,
      //     backgroundColor: kRed,
      //     icon: const Icon(Icons.error_outline, color: kLightWhite,)
      //   );
      // }
      
      
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      if(response.statusCode == 201){
        var data = cartCountResponseModelFromJson(response.body);
        updateCount = data.count.toString();
        Get.snackbar(
          "Added to Cart", "Enjoy your food!",
          colorText: kWhite,
          backgroundColor: kSecondary,
          icon: const Icon(Icons.check_circle_outline),
          duration: const Duration(milliseconds: 600),
        );
        setLoading = false;

      }else{
        var error = apiErrorFromJson(response.body);
        Get.snackbar( 
          "Error", error.message,
          colorText: kWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.error_outline, color: kLightWhite,)
        );
      }

    }catch(e){
      debugPrint(e.toString());
    }finally{
      setLoading = false;
    }
  }



  void removeFromCart(String productId, Function refetch) async {
    setLoading = true;
    String accessToken = box.read('token');

    Uri url = Uri.parse('$appBaseUrl/api/cart/$productId');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization' : 'Bearer $accessToken',
    };


    try{  
      print('Making request to: $url');

      var response = await http.delete(url, headers: headers,);
      
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      if(response.statusCode == 200){

        var data = cartCountResponseModelFromJson(response.body);
        String currentCount = jsonEncode(data.count);
        updateCount = currentCount;

        setLoading = false;

        refetch();

        print("Product removed successfully");

        // Get.snackbar(
        //   "Product removed successfully", "Explore more! ",
        //   colorText: kWhite,
        //   backgroundColor: kPrimary,
        //   icon: const Icon(Icons.check_circle_outline)
        // );

      }else{
        var error = apiErrorFromJson(response.body);
        Get.snackbar( 
          "Error", error.message,
          colorText: kWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.error_outline, color: kLightWhite,)
        );
      }

    }catch(e){
      debugPrint(e.toString());
    }finally{
      setLoading = false;
    }
  }
  

  void decrementProductQtyCart(String productId, Function refetch) async {
    setLoading = true;
    String accessToken = box.read('token');

    Uri url = Uri.parse('$appBaseUrl/api/cart/decrement/$productId');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization' : 'Bearer $accessToken',
    };


    try{  
      print('Making request to: $url');

      var response = await http.get(url, headers: headers,);
      
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      if(response.statusCode == 200){

        setLoading = false;

        refetch();

        print("Decremented successfully");

        // Get.snackbar(
        //   "Decrement successfully", "Explore more! ",
        //   colorText: kWhite,
        //   backgroundColor: kPrimary,
        //   icon: const Icon(Icons.check_circle_outline)
        // );

      }else{
        var error = apiErrorFromJson(response.body);
        Get.snackbar( 
          "Error", error.message,
          colorText: kWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.error_outline, color: kLightWhite,)
        );
      }

    }catch(e){
      debugPrint(e.toString());
    }finally{
      setLoading = false;
    }
  }
    
}