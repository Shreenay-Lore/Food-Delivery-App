import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/shimmers/foodlist_shimmer.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/models/foods_model.dart';
import 'package:food_delivery_app/pages/home/widgets/food_tile.dart';
import 'package:food_delivery_app/pages/restaurant/controller/restaurant_controller.dart';
import 'package:get/get.dart';

class RestaurantMenuWidget extends StatelessWidget {
  const RestaurantMenuWidget( {super.key, required this.restaurantId,});

  final String restaurantId;

  @override
  Widget build(BuildContext context) {
    final RestaurantController controller = Get.put(RestaurantController());
    controller.fetchRestaurantMenuFoods(restaurantId);

    return Scaffold(
      backgroundColor: kWhite,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const FoodsListShimmer();
        } else {
          return SizedBox(
            height: height * 0.55.h,
            child: ListView(
              padding: EdgeInsets.only(bottom: 80.h),
              children: List.generate(controller.restaurantMenuFoods.length, (index){
                final FoodsModel food = controller.restaurantMenuFoods[index];
                return Material(
                  child: FoodTile(
                    color: kOffWhite,
                    food: food,
                  ),
                );
              }),
            ),
          );
        }
      }),

    );
  }
}