import 'dart:convert';

import 'package:food_delivery_app/data/apis/app_url.dart';
import 'package:food_delivery_app/data/network/network_api_services.dart';
import 'package:food_delivery_app/models/api_error.dart';
import 'package:food_delivery_app/models/restaurants_model.dart';

class RestaurantRepository {
  final ApiClient _apiClient = ApiClient();

  Future<List<RestaurantsModel>?> fetchAllRestaurants(String code) async {
    try {
      var response = await _apiClient.getRequest('${AppUrl.fetchAllRestaurantsApi}$code');

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return restaurantsModelFromJson(response.body);
      } else {
        throw apiErrorFromJson(response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<RestaurantsModel?> fetchRestaurantsById(String code) async {
    try {
      var response = await _apiClient.getRequest('/api/restaurant/byId/$code');

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        var restaurant = jsonDecode(response.body);
        return RestaurantsModel.fromJson(restaurant);
      } else {
        throw apiErrorFromJson(response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }



}
