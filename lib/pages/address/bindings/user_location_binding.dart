import 'package:food_delivery_app/pages/address/controllers/user_location_controller.dart';
import 'package:get/get.dart';

class UserLocationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<UserLocationController>(() => UserLocationController());
  }
}