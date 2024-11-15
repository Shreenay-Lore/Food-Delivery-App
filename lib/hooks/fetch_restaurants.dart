import 'package:food_delivery_app/data/apis/app_url.dart';
import 'package:food_delivery_app/models/api_error.dart';
import 'package:food_delivery_app/models/hook_models/hook_result.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:food_delivery_app/models/restaurants_model.dart';
import 'package:http/http.dart' as http;


FetchHook useFetchRestaurants(String code){
  final restaurants = useState<List<RestaurantsModel>?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<Exception?>(null);
  final apiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try{
      Uri url = Uri.parse('${AppUrl.baseUrl}/api/restaurant/$code');
      final response = await http.get(url);
      
      if(response.statusCode == 200){
        restaurants.value = restaurantsModelFromJson(response.body);
      }else{
        apiError.value = apiErrorFromJson(response.body);
      }

    }catch(e){
      error.value = e as Exception;
      print(e.toString());
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
    data: restaurants.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );

}