// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/models/api_error.dart';
import 'package:food_delivery_app/models/foods_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class SearchFoodController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  
  RxBool _isLoading  = false.obs;

  bool get isLoading => _isLoading.value;

  set setLoading(bool value){
    _isLoading.value = value;
  }

  RxBool _isTriggered  = false.obs;

  bool get isTriggered => _isTriggered.value;

  set setTrigger(bool value){
    _isTriggered.value = value;
  }


  ///Search API CAll...
  List<FoodsModel>? searchResults;

  void searchFoods(String key) async {
    setLoading = true;

    Uri url = Uri.parse('$appBaseUrl/api/foods/search/$key');

    try{  
      print('Making request to: $url');
      var response = await http.get(url);
      
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      if(response.statusCode == 200){
        searchResults = foodsModelFromJson(response.body);
        setLoading = false;
      }else{
        setLoading = false;
        var error = apiErrorFromJson(response.body);
        print('Error: $error');
      }

    }catch(e){
      setLoading = false;
      debugPrint(e.toString());
    }

  }
  
}