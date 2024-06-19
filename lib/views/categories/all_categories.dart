import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/back_ground_container.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/common/shimmers/foodlist_shimmer.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/hooks/fetch_all_categories.dart';
import 'package:food_delivery_app/models/categories_model.dart';


import 'widgets/category_tile.dart';

class AllCategories extends HookWidget {
  const AllCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchAllCategories();
    List<CategoriesModel>? categories = hookResult.data;
    final isLoading = hookResult.isLoading;
    final error = hookResult.error;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: kOffWhite,
        elevation: 0,
        centerTitle: true,
        title: CustomText(text: "All Categories",
        style: appStyle(12, kGray, FontWeight.w600),
        ),
      ),
      body: BackGroundContainer(
        child: Container(
          height: height,
          padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 10.h),
          child: isLoading
          ? const FoodsListShimmer()         
          : ListView(
            scrollDirection: Axis.vertical,
            children: List.generate(
              categories!.length,
              (index){
                CategoriesModel  category = categories[index];
                return CategoryTile(category: category);
              }
            ),
          ),
        ),
      ),
    );
  }
}
