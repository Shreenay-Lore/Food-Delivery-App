import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/shimmers/nearby_shimmer.dart';
import 'package:food_delivery_app/hooks/fetch_foods.dart';
import 'package:food_delivery_app/models/foods_model.dart';
import 'package:food_delivery_app/views/home/widgets/food_widget.dart';

class FoodsList extends HookWidget {
  const FoodsList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchFoods('41007428');
    List<FoodsModel>? foods = hookResult.data;
    final isLoading = hookResult.isLoading;


    return isLoading
    ? const NearbyShimmer()
    : Container(
      //color: Colors.black12,
      height: 184.h,
      padding: EdgeInsets.only(left: 12.w, top: 10.h),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          foods!.length,
          (index){
            FoodsModel food = foods[index];
            return FoodWidget(
              image: food.imageUrl[0],
              title: food.title,
              price: food.price.toStringAsFixed(2),
              time: food.time,
            );
          }
        ),
      ),
    );
  }
}