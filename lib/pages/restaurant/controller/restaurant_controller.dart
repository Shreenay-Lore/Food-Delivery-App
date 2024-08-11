// ignore_for_file: prefer_final_fields

import 'package:food_delivery_app/models/api_error.dart';
import 'package:food_delivery_app/models/foods_model.dart';
import 'package:food_delivery_app/repository/food/food_repository.dart';
import 'package:get/get.dart';

class RestaurantController extends GetxController{

  final FoodRepository _foodService = FoodRepository();
  
  RxList<FoodsModel> restaurantMenuFoods = <FoodsModel>[].obs;
  RxBool  isLoading = false.obs;
  var error = ''.obs;
  var apiError = ApiError().obs;

  Future<void> fetchRestaurantMenuFoods(String id) async {
    isLoading(true);
    try {
      var result = await _foodService.fetchRestaurantMenuFoods(id);
      if (result != null) {
        restaurantMenuFoods.assignAll(result);
      }
    } catch (e) {
      error(e.toString());
    } finally {
      isLoading(false);
    }
  }


}