import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/shimmers/foodlist_shimmer.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/models/foods_model.dart';
import 'package:food_delivery_app/pages/categories/widgets/header_widget.dart';
import 'package:food_delivery_app/pages/categories/widgets/intro_text.dart';
import 'package:food_delivery_app/pages/home/controller/home_controller.dart';
import 'package:food_delivery_app/pages/home/widgets/food_tile.dart';
import 'package:get/get.dart';

class RecommendationsPage extends StatelessWidget {
  const RecommendationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: kWhite,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const FoodsListShimmer();
        } else {
          return buildContent(controller.recommendedFood);
        }
      }),
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