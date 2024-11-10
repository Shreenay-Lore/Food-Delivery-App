import 'package:food_delivery_app/pages/auth/controllers/phone_verification_controller.dart';
import 'package:get/get.dart';

class PhoneVerificationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PhoneVerificationController>(() => PhoneVerificationController());
  }
}