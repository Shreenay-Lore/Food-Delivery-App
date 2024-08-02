import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/pages/home/widgets/home_appbar.dart';
import 'package:food_delivery_app/common/custom_text_field.dart';
import 'package:food_delivery_app/common/heading.dart';
import 'package:food_delivery_app/common/slider_card_widget.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/pages/categories/controller/category_controller.dart';
import 'package:food_delivery_app/pages/home/widgets/category_foods_list.dart';
import 'package:food_delivery_app/pages/home/widgets/category_list.dart';
import 'package:food_delivery_app/pages/home/widgets/food_list.dart';
import 'package:food_delivery_app/pages/home/widgets/nearby_restaurants_list.dart';
import 'package:food_delivery_app/routes/names.dart';
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
        child: const HomeAppBar(),
      ),
      body: buildContent(controller),
    );
  }

  Widget buildContent(CategoryController controller){
    return SafeArea(
      child: SingleChildScrollView(
        child : Column(
          children: [
            _topSearchBar(),

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

                  SizedBox(height: 30.h,),

                  Heading(
                    text: 'Try Something New',
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.onAllFoodRecommendationsPage,
                      );
                    },
                  ),
                  const FoodsList(),
                  
                  Heading(
                    text: 'Nearby Restaurants',
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.onAllNearByRestaurantsPage,
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
    );
  }

  Widget _topSearchBar(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: CustomTextField(
        readOnly: true,
        hintText: "Search For Foods . . .",
        prefixIcon: Icon(AntDesign.search1, color: kGray, size: 20.h,),
        fillColor: kOffWhite,
        borderColor: Colors.transparent,
        onTap: () {
          Get.toNamed(
            AppRoutes.onSearchPage,
          );
        },
      ),
    );
  }


}