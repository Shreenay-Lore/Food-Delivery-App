import 'package:food_delivery_app/models/api_error.dart';
import 'package:food_delivery_app/repository/cart/cart_repository.dart';
import 'package:get/get.dart';

class MainScreenController extends GetxController{
  final RxInt _tabIndex = 0.obs;

  int get tabIndex => _tabIndex.value;

  set setTabIndex(int newValue){
    _tabIndex.value = newValue;
  }

  @override
  void onInit() {
    fetchCurrentCartCount();
    super.onInit();
  }

  final CartRepository _cartService = CartRepository();

  RxInt? cartCurrentCount = 0.obs;
  RxBool  isLoading = false.obs;
  var error = ''.obs;
  var apiError = ApiError().obs;

  Future<void> fetchCurrentCartCount() async {
    isLoading(true);
    try {
      var result = await _cartService.fetchCartCount();
      if (result != null) {
        cartCurrentCount!.value = result.count!;
      }
    } catch (e) {
      error(e.toString());
    } finally {
      isLoading(false);
    }
  }


  
}