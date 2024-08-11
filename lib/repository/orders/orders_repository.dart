import 'package:food_delivery_app/data/network/network_api_services.dart';
import 'package:food_delivery_app/models/api_error.dart';
import 'package:food_delivery_app/models/client_orders.dart';

class OrdersRepository {
  final ApiClient _apiClient = ApiClient();

  Future<List<ClientOrdersModel>?> fetchOrders(String orderStatus, String paymentStatus) async {
    try {
      var response = await _apiClient.getRequest('/api/orders?orderStatus=$orderStatus&paymentStatus=$paymentStatus');

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return clientOrdersModelFromJson(response.body);
      } else {
        throw apiErrorFromJson(response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }


}
