import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/pages/cart/controller/cart_controller.dart';
import 'package:food_delivery_app/pages/food/controller/foods_controller.dart';
import 'package:food_delivery_app/models/cart_request_model.dart';
import 'package:food_delivery_app/models/foods_model.dart';
import 'package:get/get.dart';

class FoodPageBottomNavBar extends StatelessWidget {
  final FoodsModel food;

  const FoodPageBottomNavBar({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    final FoodController foodcontroller = Get.find<FoodController>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.h,),
      decoration: BoxDecoration(
        color: kWhite,
        border: Border.all(color: kOffWhite, width: 2.5),
      ),
      height: 68.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          quantityController(foodcontroller),
          addItemButtom(cartController, foodcontroller),
        ],
      ),
    );
  }

  
  Widget quantityController(FoodController foodcontroller){
    return Container(
      height: 45.h,
      width: 90.w,
      decoration: BoxDecoration(
        color: kOffWhite,
        border: Border.all(color: kDark, width: 0.6),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                foodcontroller.decrement();
              },
              child: const Icon(AntDesign.minus, color: kDark, size: 22),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Obx(
                () => CustomText(
                    text: "${foodcontroller.count.value}",
                    style: appStyle(14, kDark, FontWeight.w600)),
              ),
            ),
            GestureDetector(
              onTap: () {
                foodcontroller.increment();
              },
              child: const Icon(AntDesign.plus, color: kDark, size: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget addItemButtom(CartController cartController, FoodController foodcontroller){
    return GestureDetector(
      onTap: () {
        double totalPrice = (food.price + foodcontroller.additivePrice) *
            foodcontroller.count.value;
        CartRequestModel data = CartRequestModel(
          productId: food.id,
          quantity: foodcontroller.count.value,
          additives: foodcontroller.getCartAdditive(),
          totalPrice: totalPrice,
        );

        String cartItem = cartRequestModelToJson(data);

        cartController.addToCart(cartItem);

        Get.back();
      },
      child: Container(
        height: 45.h,
        width: 240.w,
        decoration: BoxDecoration(
          color: kDark.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10.r)
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                  text: "Add Item",
                  style: appStyle(13.5, kLightWhite, FontWeight.w600)),
              Obx(
                () => CustomText(
                  text:
                      "₹ ${(food.price + foodcontroller.additivePrice) * foodcontroller.count.value}",
                  style: appStyle(13.5, kWhite, FontWeight.w600)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
