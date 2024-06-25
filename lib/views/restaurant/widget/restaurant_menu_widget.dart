import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:food_delivery_app/common/shimmers/foodlist_shimmer.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/hooks/foods_by_restaurants.dart';
import 'package:food_delivery_app/models/foods_model.dart';
import 'package:food_delivery_app/views/home/widgets/food_tile.dart';

class RestaurantMenuWidget extends HookWidget {
  const RestaurantMenuWidget( {super.key, required this.restaurantId,});

  final String restaurantId;

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchRestaurantFoods(restaurantId);
    final foods = hookResults.data;
    final isLoading = hookResults.isLoading;

    return Scaffold(
      backgroundColor: kLightWhite,
      body: isLoading
      ? const FoodsListShimmer()
      : SizedBox(
        height: height * 0.7,
        child: ListView(
          padding: EdgeInsets.zero,
          children: List.generate(foods!.length, (index){
            final FoodsModel food = foods[index];
            return FoodTile(food: food);
          }),
        ),
      ),
    );
  }
}