import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/back_ground_container.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/common/shimmers/foodlist_shimmer.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/hooks/fetch_all_foods.dart';
import 'package:food_delivery_app/models/foods_model.dart';
import 'package:food_delivery_app/views/home/widgets/food_tile.dart';

class RecommendationsPage extends HookWidget {
  const RecommendationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchAllFoods('41007428');
    List<FoodsModel>? foods = hookResult.data;
    final isLoading = hookResult.isLoading;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: kOffWhite,
        elevation: 0,
        centerTitle: true,
        title: CustomText(text: "Recommendations",
        style: appStyle(13, kGray, FontWeight.w600),
        ),
      ),
      body: BackGroundContainer(
        child: isLoading
        ? const FoodsListShimmer()         
        : ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(top: 14.h),
          children: List.generate(
            foods!.length,
            (index){
              FoodsModel food = foods[index];
              return FoodTile(
                food: food,
              );
            }
          ),
        ),
      ),
    );
    
  }
}