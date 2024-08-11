// ignore_for_file: prefer_final_fields

import 'package:food_delivery_app/models/api_error.dart';
import 'package:food_delivery_app/models/foods_model.dart';
import 'package:food_delivery_app/models/restaurants_model.dart';
import 'package:food_delivery_app/repository/food/food_repository.dart';
import 'package:food_delivery_app/repository/restaurant/restaurant_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  final RestaurantRepository _restaurantService = RestaurantRepository();
  final FoodRepository _foodService = FoodRepository();
  
  RxList<RestaurantsModel> allRestaurants = <RestaurantsModel>[].obs;
  RxList<FoodsModel> recommendedFood = <FoodsModel>[].obs;
  //RxList<RestaurantsModel> dashboardRestaurants = <RestaurantsModel>[].obs;

  RxBool  isLoading = false.obs;
  var error = ''.obs;
  var apiError = ApiError().obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllNearByRestaurants();
    fetchAllRecommendedFood();
    //fetchDashboardRestaurantList();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  //   fetchAllNearByRestaurants();
  //   fetchAllRecommendedFood();
  //   fetchDashboardRestaurantList();
  // }

  Future<void> fetchAllNearByRestaurants() async {
    isLoading(true);
    try {
      var result = await _restaurantService.fetchAllRestaurants('41007428');
      if (result != null) {
        allRestaurants.assignAll(result);
      }
    } catch (e) {
      error(e.toString());
    } finally {
      isLoading(false);
    }
  }


  Future<void> fetchAllRecommendedFood() async {
    isLoading(true);
    try {
      var result = await _foodService.fetchAllRecommendedFood('41007428');
      if (result != null) {
        recommendedFood.assignAll(result);
      }
    } catch (e) {
      error(e.toString());
    } finally {
      isLoading(false);
    }
  }


  // Future<void> fetchDashboardRestaurantList() async {
  //   isLoading(true);
  //   try {
  //     var result = await _restaurantService.fetchDashboardRestaurants('41007428');
  //     if (result != null) {
  //       dashboardRestaurants.assignAll(result);
  //     }
  //   } catch (e) {
  //     error(e.toString());
  //   } finally {
  //     isLoading(false);
  //   }
  // }



  

}

