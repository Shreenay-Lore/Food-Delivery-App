import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/apis/app_url.dart';
import 'package:food_delivery_app/models/api_error.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:food_delivery_app/models/cart_response_model.dart';
import 'package:food_delivery_app/models/hook_models/hook_result.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;


FetchHook useFetchCartItems(){
  final box = GetStorage();
  final cartItems = useState<List<CartResponseModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    String accessToken = box.read('token');

    Uri url = Uri.parse('${AppUrl.baseUrl}/api/cart');

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
        cartItems.value = cartResponseModelFromJson(response.body);
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
    data: cartItems.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );

}