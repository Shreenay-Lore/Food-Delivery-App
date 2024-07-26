import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/models/api_error.dart';
import 'package:food_delivery_app/models/success_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;


class RegistrationController extends GetxController{

  final box = GetStorage();
  
  RxBool _isLoading  = false.obs;

  bool get isLoading => _isLoading.value;

  set setLoading(bool value){
    _isLoading.value = value;
  }


  void registrationFunction(String data) async {
    setLoading = true;

    Uri url = Uri.parse('$appBaseUrl/register');

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
      
      if(response.statusCode == 201){
        var data = successModelFromJson(response.body);

        setLoading = false;

        Get.back();
        
        Get.snackbar(
          "You are successfully registered", data.message,
          colorText: kWhite,
          backgroundColor: kPrimary,
          icon: const Icon(Ionicons.fast_food_outline)
        );

      }else{
        var error = apiErrorFromJson(response.body);

        Get.snackbar(
          "Failed to register", error.message,
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