import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/models/addresses_response_model.dart';
import 'package:food_delivery_app/models/api_error.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:food_delivery_app/models/hook_models/default_address_hook.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;


FetchDefaultAddress useFetchDefaultAddress(){
  final box = GetStorage();
  final addresses = useState<AddressResponseModel?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    String accessToken = box.read('token');

    Uri url = Uri.parse('$appBaseUrl/api/address/default');

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
        var data = jsonDecode(response.body);
        addresses.value = AddressResponseModel.fromJson(data);
      }else{
        apiError.value = apiErrorFromJson(response.body);
      }

    }catch(e){
      debugPrint(e.toString());
    }finally{
      isLoading.value = false;
    }
  }

  useEffect((){
    fetchData();
    return null;
  }, []);

  void refetch(){
    isLoading.value = true;
    fetchData();
  }

  return FetchDefaultAddress(
    data: addresses.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );

}