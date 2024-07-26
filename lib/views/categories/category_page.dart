import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/back_ground_container.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/common/shimmers/foodlist_shimmer.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/controller/category_controller.dart';
import 'package:food_delivery_app/hooks/fetch_category_foods.dart';
import 'package:food_delivery_app/models/foods_model.dart';
import 'package:food_delivery_app/views/home/widgets/food_tile.dart';
import 'package:get/get.dart';

class CategoryPage extends HookWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryController controller = Get.put(CategoryController());   
    
    final hookResult = useFetchFoodsByCategory('41007428');
    List<FoodsModel>? foods = hookResult.data;
    final isLoading = hookResult.isLoading;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kOffWhite,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            controller.updateCategory = '';
            controller.updateTitle = '';
            Get.back();
          }, 
          icon: const Icon(Icons.arrow_back_ios, color: kDark,),
        ),
        centerTitle: true,
        title: CustomText(text: "${controller.titleValue} Category",
        style: appStyle(12, kGray, FontWeight.w600),
        ),
      ),
      body: BackGroundContainer(
        child: SizedBox(
          height: height,
          child: isLoading
          ? const FoodsListShimmer()         
          : Padding(
            padding:  EdgeInsets.only(top: 12.h),
            child: ListView(
              scrollDirection: Axis.vertical,
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
        ),
      ),
    );
  }
}