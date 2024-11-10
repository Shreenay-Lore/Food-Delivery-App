import 'package:food_delivery_app/pages/auth/controllers/registration_controller.dart';
import 'package:get/get.dart';

class RegistrationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RegistrationController>(() => RegistrationController());
  }
}