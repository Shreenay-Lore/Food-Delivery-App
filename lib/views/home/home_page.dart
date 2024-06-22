import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/custom_appbar.dart';
import 'package:food_delivery_app/common/custom_container.dart';
import 'package:food_delivery_app/common/heading.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/controller/category_controller.dart';
import 'package:food_delivery_app/views/home/all_fastest_foods_page.dart';
import 'package:food_delivery_app/views/home/all_nearby_restaurants_page.dart';
import 'package:food_delivery_app/views/home/all_recommendations_page.dart';
import 'package:food_delivery_app/views/home/widgets/category_foods_list.dart';
import 'package:food_delivery_app/views/home/widgets/category_list.dart';
import 'package:food_delivery_app/views/home/widgets/food_list.dart';
import 'package:food_delivery_app/views/home/widgets/nearby_restaurants_list.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryController controller = Get.put(CategoryController());   

    return Scaffold(
      backgroundColor: kPrimary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130.h),
        child: const CustomAppBar(),
      ),
      body: SafeArea(
        child: CustomContainer(
          containerContent : Column(
            children: [
              const CategoryList(),

              Obx(()=> controller.categoryValue == '' 
                ? Column(
                  children: [
                    Heading(
                      text: 'Try Something New',
                      onTap: () {
                        Get.to(
                          ()=> const RecommendationsPage(),
                          transition: Transition.cupertino,
                          duration: const Duration(milliseconds: 900)
                        );
                      },
                    ),
                    const FoodsList(),
                    
                    Heading(
                      text: 'Nearby Restaurants',
                      onTap: () {
                        Get.to(
                          ()=> const AllNearbyRestaurantsPage(),
                          transition: Transition.cupertino,
                          duration: const Duration(milliseconds: 900)
                        );
                      },
                    ),
                    const NearbyRestaurants(),
                              
                    Heading(
                      text: 'Fastest Food closer to you',
                      onTap: () {
                        Get.to(
                          ()=> const AllFastestFoodsPage(),
                          transition: Transition.cupertino,
                          duration: const Duration(milliseconds: 900)
                        );
                      },
                    ),
                    const FoodsList(),
                  ],
                )
                : CustomContainer(
                    containerContent: Column(
                      children: [
                        Heading(
                          more: true, 
                          text: 'Explore ${controller.titleValue} Category',
                        ),
                        const CategoryFoodsList(),
                      ],
                    )
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }


}