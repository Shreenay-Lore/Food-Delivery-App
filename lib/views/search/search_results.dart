import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/controller/search_controller.dart';
import 'package:food_delivery_app/models/foods_model.dart';
import 'package:food_delivery_app/views/home/widgets/food_tile.dart';
import 'package:get/get.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchFoodController());
    
    return Container(
      height: height,
      padding: EdgeInsets.fromLTRB(0.w, 10.h, 0.w, 0.h),
      child: ListView.builder(
        itemCount: controller.searchResults!.length,
        itemBuilder: (context, index) {
          FoodsModel food = controller.searchResults![index];
          return FoodTile(food: food);
        },
      ),
    );
  }
}