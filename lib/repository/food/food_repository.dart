import 'package:food_delivery_app/data/apis/app_url.dart';
import 'package:food_delivery_app/data/network/network_api_services.dart';
import 'package:food_delivery_app/models/api_error.dart';
import 'package:food_delivery_app/models/foods_model.dart';

class FoodRepository {
  final ApiClient _apiClient = ApiClient();

  Future<List<FoodsModel>?> fetchAllRecommendedFood(String code) async {
    try {
      var response = await _apiClient.getRequest('${AppUrl.fetchAllRecommendedFoodApi}$code');

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return foodsModelFromJson(response.body);
      } else {
        throw apiErrorFromJson(response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<FoodsModel>?> fetchRestaurantMenuFoods(String id) async {
    try {
      var response = await _apiClient.getRequest('${AppUrl.fetchRestaurantMenuFoodsApi}$id');

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return foodsModelFromJson(response.body);
      } else {
        throw apiErrorFromJson(response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }


}
