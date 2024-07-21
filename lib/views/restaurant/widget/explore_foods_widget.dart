import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/shimmers/foodlist_shimmer.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/hooks/fetch_foods.dart';
import 'package:food_delivery_app/models/foods_model.dart';
import 'package:food_delivery_app/views/home/widgets/food_tile.dart';

class ExploreWidget extends HookWidget {
  const ExploreWidget( {super.key, required this.code,});

  final String code;

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchFoods(code);
    final foods = hookResults.data;
    final isLoading = hookResults.isLoading;

    return Scaffold(
      backgroundColor: kLightWhite,
      body: isLoading
      ? const FoodsListShimmer()
      : SizedBox(
        height: height * 0.50.h,
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