import 'package:food_delivery_app/data/network/network_api_services.dart';
import 'package:food_delivery_app/models/api_error.dart';
import 'package:food_delivery_app/models/cart_count_response_mode.dart';


class CartRepository {
  final ApiClient _apiClient = ApiClient();

  Future<CartCountResponseModel?> fetchCartCount() async {
    try {
      var response = await _apiClient.getRequest('/api/cart/count');

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return cartCountResponseModelFromJson(response.body);
      } else {
        throw apiErrorFromJson(response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}
