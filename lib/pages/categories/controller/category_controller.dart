// ignore_for_file: prefer_final_fields

import 'package:food_delivery_app/models/api_error.dart';
import 'package:food_delivery_app/models/categories_model.dart';
import 'package:food_delivery_app/repository/categories/category_repository.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController{
  RxString _category  = ''.obs;

  String get categoryValue => _category.value;

  set updateCategory(String value){
    _category.value = value;
  }

  RxString _title  = ''.obs;

  String get titleValue => _title.value;

  set updateTitle(String value){
    _title.value = value;
  }

  final CategoryRepository _categoryService = CategoryRepository();
  
  RxList<CategoriesModel> allCategories = <CategoriesModel>[].obs;


  RxBool  isLoading = false.obs;
  var error = ''.obs;
  var apiError = ApiError().obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllCategories();
  }

  Future<void> fetchAllCategories() async {
    isLoading(true);
    try {
      var result = await _categoryService.fetchAllCategories();
      if (result != null) {
        allCategories.assignAll(result);
      }
    } catch (e) {
      error(e.toString());
    } finally {
      isLoading(false);
    }
  }


}