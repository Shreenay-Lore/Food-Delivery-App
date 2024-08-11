import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/cart_count_container.dart';
import 'package:food_delivery_app/common/common_appbar.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/common/shimmers/foodlist_shimmer.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/pages/address/controller/user_location_controller.dart';
import 'package:food_delivery_app/pages/auth/controller/login_controller.dart';
import 'package:food_delivery_app/pages/orders/controller/orders_controller.dart';
import 'package:food_delivery_app/hooks/fetch_cart_items.dart';
import 'package:food_delivery_app/models/addresses_response_model.dart';
import 'package:food_delivery_app/models/cart_response_model.dart';
import 'package:food_delivery_app/models/login_response.dart';
import 'package:food_delivery_app/pages/auth/login_redirect.dart';
import 'package:food_delivery_app/pages/auth/verification_page.dart';
import 'package:food_delivery_app/pages/cart/widget/cart_bottom_nav_bar.dart';
import 'package:food_delivery_app/pages/cart/widget/cart_tile.dart';
import 'package:food_delivery_app/pages/restaurant/widget/row_text.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartPage extends HookWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final hookResult = useFetchCartItems();
    List<CartResponseModel> cartItems = hookResult.data ?? [];
    final isLoading = hookResult.isLoading;
    final refetch = hookResult.refetch;
    
    final UserLocationController locationController = Get.put(UserLocationController());
    AddressResponseModel? address = locationController.defaultAddress.value;

    LoginResponse? user;

    final LoginController controller = Get.put(LoginController());
    final OrdersController ordersController = Get.put(OrdersController());

    String? token = box.read("token");

    if(token != null){
      user = controller.getUserInfo();
    }

    if(token == null){
      return const LoginRedirectPage();
    }

    if(user != null &&  user.verification == false){
      return const VerificationPage();
    }

    // Calculate total price of all items in the list
    double itemTotalPrice = cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
    double deliveryFee = 50;
    double taxes = 35.40;
    double grandTotalPrice = itemTotalPrice + deliveryFee + taxes;


    return Scaffold(
      backgroundColor: kOffWhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: const CommonAppBar(
          title: "Checkout",
          actions: [
            CartCountContainer(bgColor: kOffWhite,)
          ],
        ),
      ),
      bottomNavigationBar: cartItems.isEmpty
        ? const SizedBox()
        : CartBottomNavBar(
            grandTotalPrice: grandTotalPrice,
            cartItems: cartItems,
            address: address,
            initPaymentSheet: ordersController.initPaymentSheet,
          ),
        body: SafeArea(
          child: isLoading
            ? const FoodsListShimmer()         
            : ListView(
              children: [
                SizedBox(height: 20.h), 

                ...cartItems.map((cartItem) {
                  return CartTile(
                    color: kWhite,
                    cartItem: cartItem,
                    refetch: refetch,
                  );
                }).toList(),

                SizedBox(height: 20.h), 
                cartItems.isEmpty
                ? const SizedBox()
                : Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Bill Summary", 
                        style: appStyle(16, kDark, FontWeight.bold)
                      ),
                      SizedBox(height: 10.h,),
                      RowText(
                        firstText: "Item Total", 
                        secondText:'₹ ${itemTotalPrice.toStringAsFixed(2)}'
                      ),
                      SizedBox(height: 5.h,),
                      const RowText(
                        firstText: "Govt. taxes and restaurant charges", 
                        secondText: '₹ 35.40'
                      ),
                      SizedBox(height: 5.h,),
                      const RowText(
                        firstText: "Delivery Fee", 
                        secondText: '₹ 50'
                      ),
                      SizedBox(height: 14.h,),                     
                      RowText(
                        firstText: "Grand Total", 
                        firstFontSize: 12,
                        firstFontWeight: FontWeight.w600,
                        firstTextColor: kDark,
                        secondText: '₹ ${grandTotalPrice.toStringAsFixed(2)}',
                        secondFontSize: 12,
                        secondFontWeight: FontWeight.w600,
                        secondTextColor: kDark,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 50.h),
              ],
            ),
        ),
    );
  }


}
