import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/models/api_error.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:food_delivery_app/models/cart_count_response_mode.dart';
import 'package:food_delivery_app/models/hook_models/hook_result.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;


FetchHook useFetchCartItemsCount(){
  final box = GetStorage();
  final cartItemsCount = useState<CartCountResponseModel?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    String accessToken = box.read('token');

    Uri url = Uri.parse('$appBaseUrl/api/cart/count');

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
        cartItemsCount.value = cartCountResponseModelFromJson(response.body);
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

  return FetchHook(
    data: cartItemsCount.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );

}