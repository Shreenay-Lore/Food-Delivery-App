import 'package:food_delivery_app/pages/search/controller/search_controller.dart';
import 'package:get/get.dart';

class SearchBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SearchFoodController>(() => SearchFoodController());
  }
}