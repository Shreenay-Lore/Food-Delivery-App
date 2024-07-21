import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/common/custom_appbar.dart';
import 'package:food_delivery_app/common/custom_container.dart';
import 'package:food_delivery_app/common/custom_text_field.dart';
import 'package:food_delivery_app/common/heading.dart';
import 'package:food_delivery_app/common/slider_card_widget.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/controller/category_controller.dart';
import 'package:food_delivery_app/views/home/all_fastest_foods_page.dart';
import 'package:food_delivery_app/views/home/all_nearby_restaurants_page.dart';
import 'package:food_delivery_app/views/home/all_recommendations_page.dart';
import 'package:food_delivery_app/views/home/widgets/category_foods_list.dart';
import 'package:food_delivery_app/views/home/widgets/category_list.dart';
import 'package:food_delivery_app/views/home/widgets/food_list.dart';
import 'package:food_delivery_app/views/home/widgets/nearby_restaurants_list.dart';
import 'package:food_delivery_app/views/search/search_page.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryController controller = Get.put(CategoryController());   
    
    return Scaffold(
      backgroundColor: kWhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130.h),
        child: const CustomAppBar(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child : Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: CustomTextField(
                readOnly: true,
                hintText: "Search For Foods . . .",
                prefixIcon: Icon(AntDesign.search1, color: kGray, size: 20.h,),
                fillColor: kOffWhite,
                borderColor: Colors.transparent,
                // suffixIcon: Icon(Ionicons.search, color: kGray, size: 24.h,),
                onTap: () {
                  Get.to(() => SearchPage());
                },
                ),
              ),

              const CategoryList(),

              Obx(()=> controller.categoryValue == '' 
                ? Column(
                  children: [
                    SizedBox(height: 18.h),

                    const Heading(
                      text: 'Check this Out!',
                      more: false,
                    ),
                    const AdvertisementCarousel(),

                    SizedBox(height: 25.h,),

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

                    SizedBox(height: 150.h,)
                            
                  ],
                )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 16.h,),
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