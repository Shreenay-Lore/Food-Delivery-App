import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/models/api_error.dart';
import 'package:food_delivery_app/models/categories_model.dart';
import 'package:food_delivery_app/models/hook_models/hook_result.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchHook useFetchCategories() {
  final categoriesItems = useState<List<CategoriesModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try{
      Uri url = Uri.parse('$appBaseUrl/api/category/random');
      final response = await http.get(url);
      
      print(response.statusCode);
      
      if(response.statusCode == 200){
        categoriesItems.value = categoriesModelFromJson(response.body);
      }else{
        apiError.value = apiErrorFromJson(response.body);
      }

    }catch(e){
      error.value = e as Exception;
    }finally{
      isLoading.value = false;
    }
  }

  // void fetchData() async {
  //   final response = await http.get(Uri.parse('https://dummyjson.com/recipes'));

  //   if (response.statusCode == 200) {
  //     CategoriesModel categoriesModel = categoriesModelFromJson(response.body);
  //     print('Total recipes: ${categoriesModel.total}');
  //     print('First recipe name: ${categoriesModel.recipes[0].name}');
  //   } else {
  //     throw Exception('Failed to load recipes');
  //   }
  // }

  useEffect(() {
    fetchData();
    return null;
  }, []);

  void refetch(){
    isLoading.value = true;
    fetchData();
  }

  return FetchHook(
    data: categoriesItems.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
