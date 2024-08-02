import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/shimmers/foodlist_shimmer.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/hooks/fetch_all_foods.dart';
import 'package:food_delivery_app/models/foods_model.dart';
import 'package:food_delivery_app/pages/categories/widgets/header_widget.dart';
import 'package:food_delivery_app/pages/categories/widgets/intro_text.dart';
import 'package:food_delivery_app/pages/home/widgets/food_tile.dart';

class RecommendationsPage extends HookWidget {
  const RecommendationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchAllFoods('41007428');
    List<FoodsModel>? foods = hookResult.data;
    final isLoading = hookResult.isLoading;

    return Scaffold(
      backgroundColor: kWhite,
      body: isLoading
        ? const FoodsListShimmer()         
        : buildContent(foods),
    ); 
  }

  Widget buildContent(List<FoodsModel>? foods) {
    return Column(
      children: [
        HeaderWidget(
          imageUrl: "https://www.agilitypr.com/wp-content/uploads/2022/10/fastfood.jpg",
          height: 130.h,
        ),
        
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 12.h,),
            itemCount: (foods?.length ?? 0) + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: const IntroTextWidget(
                    title: "Recommendations!",
                    subtitle: "From our kitchen to your table, enjoy every delicious moment.",
                  ),
                );
              }
              FoodsModel food = foods![index - 1];
              return FoodTile(
                food: food,
              );
            },
          ),
        ),
      ],
    );
  }



}