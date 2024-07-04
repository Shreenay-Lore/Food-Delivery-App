import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_container.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/common/shimmers/foodlist_shimmer.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/controller/login_controller.dart';
import 'package:food_delivery_app/hooks/fetch_cart_items.dart';
import 'package:food_delivery_app/models/cart_response_model.dart';
import 'package:food_delivery_app/models/login_response.dart';
import 'package:food_delivery_app/views/auth/login_redirect.dart';
import 'package:food_delivery_app/views/auth/verification_page.dart';
import 'package:food_delivery_app/views/cart/widget/cart_tile.dart';
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

    LoginResponse? user;

    final LoginController controller = Get.put(LoginController());

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

  
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        backgroundColor: kWhite,
        centerTitle: true,
        title: CustomText(text: "CART", style: appStyle(14, kGray, FontWeight.w600)),
      ),
      body: SafeArea(
        child: CustomContainer(
          color: kWhite,
          containerContent: isLoading
            ? const FoodsListShimmer()         
            : SizedBox(
              width: width,
              height: height,
              child: Padding(
                padding:  EdgeInsets.all(12.h),
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    CartResponseModel cartItem = cartItems[index];
                    return CartTile(
                      cartItem: cartItem,
                      refetch: refetch,
                    );
                  },

                ),
              ),
            ),
        ),
      ),
    );
  }
}