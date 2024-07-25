import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/shimmers/foodlist_shimmer.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/hooks/fetch_category_foods.dart';
import 'package:food_delivery_app/models/foods_model.dart';
import 'package:food_delivery_app/views/home/widgets/food_tile.dart';

class CategoryFoodsList extends HookWidget {
  const CategoryFoodsList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchFoodsByCategory('41007428');
    List<FoodsModel>? foods = hookResult.data;
    final isLoading = hookResult.isLoading;

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: isLoading
      ? const FoodsListShimmer()
      : Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: ListView.builder(
            itemCount: foods!.length + 1,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              if (index == foods.length) {
                return  SizedBox(height: 400.h,);
              } else {
                FoodsModel food = foods[index];
                return FoodTile(
                  color: kOffWhite,
                  food: food,
                );
              }
            },
          ),
        ),
    );
  }
}
