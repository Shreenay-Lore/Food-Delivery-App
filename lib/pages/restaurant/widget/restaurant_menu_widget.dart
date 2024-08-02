import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/shimmers/foodlist_shimmer.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/hooks/foods_by_restaurants.dart';
import 'package:food_delivery_app/models/foods_model.dart';
import 'package:food_delivery_app/pages/home/widgets/food_tile.dart';

class RestaurantMenuWidget extends HookWidget {
  const RestaurantMenuWidget( {super.key, required this.restaurantId,});

  final String restaurantId;

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchRestaurantFoods(restaurantId);
    final foods = hookResults.data;
    final isLoading = hookResults.isLoading;

    return Scaffold(
      backgroundColor: kWhite,
      body: isLoading
      ? const FoodsListShimmer()
      : SizedBox(
        height: height * 0.55.h,
        child: ListView(
          padding: EdgeInsets.only(bottom: 80.h),
          children: List.generate(foods!.length, (index){
            final FoodsModel food = foods[index];
            return Material(
              child: FoodTile(
                color: kOffWhite,
                food: food,
              ),
            );
          }),
        ),
      ),
    );
  }
}