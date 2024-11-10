import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/apis/app_url.dart';
import 'package:food_delivery_app/pages/categories/controller/category_controller.dart';
import 'package:food_delivery_app/models/api_error.dart';
import 'package:food_delivery_app/models/foods_model.dart';
import 'package:food_delivery_app/models/hook_models/foods_hook.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


FetchFoods useFetchFoodsByCategory(String code){
  final CategoryController controller = Get.put(CategoryController());   
  final foods = useState<List<FoodsModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try{
      Uri url = Uri.parse('${AppUrl.baseUrl}/api/foods/${controller.categoryValue}/$code');
      final response = await http.get(url);
   
      if(response.statusCode == 200){
        foods.value = foodsModelFromJson(response.body);
      }else{
        apiError.value = apiErrorFromJson(response.body);
      }

    }catch(e){
      error.value = e as Exception;
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

  return FetchFoods(
    data: foods.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );

}