import 'package:food_delivery_app/pages/main_screen/controller/main_screen_controller.dart';
import 'package:get/get.dart';

class MainScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MainScreenController>(() => MainScreenController());
  }
}