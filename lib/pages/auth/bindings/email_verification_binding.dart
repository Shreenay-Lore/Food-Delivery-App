import 'package:food_delivery_app/pages/auth/controllers/email_verification_controller.dart';
import 'package:get/get.dart';

class EmailVerificationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<EmailVerificationController>(() => EmailVerificationController());
  }
}