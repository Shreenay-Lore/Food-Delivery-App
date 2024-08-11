import 'package:food_delivery_app/data/apis/app_url.dart';
import 'package:food_delivery_app/data/network/network_api_services.dart';
import 'package:food_delivery_app/models/api_error.dart';
import 'package:food_delivery_app/models/categories_model.dart';
import 'package:food_delivery_app/models/foods_model.dart';
import 'package:food_delivery_app/pages/categories/controller/category_controller.dart';
import 'package:get/get.dart';

class CategoryRepository {
  final ApiClient _apiClient = ApiClient();

  Future<List<CategoriesModel>?> fetchAllCategories() async {
    try {
      var response = await _apiClient.getRequest(AppUrl.fetchAllCategoriesApi);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return categoriesModelFromJson(response.body);
      } else {
        throw apiErrorFromJson(response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<List<FoodsModel>?> fetchFoodsByCategory(String code) async {
    final CategoryController controller = Get.put(CategoryController());  

    try {
      var response = await _apiClient.getRequest('/api/foods/${controller.categoryValue}/$code');

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
