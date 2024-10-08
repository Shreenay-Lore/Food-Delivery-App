import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/shimmers/foodlist_shimmer.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/models/restaurants_model.dart';
import 'package:food_delivery_app/pages/categories/widgets/header_widget.dart';
import 'package:food_delivery_app/pages/categories/widgets/intro_text.dart';
import 'package:food_delivery_app/pages/home/controller/home_controller.dart';
import 'package:food_delivery_app/pages/home/widgets/restaurant_tile.dart';
import 'package:get/get.dart';

class AllNearbyRestaurantsPage extends StatelessWidget {
  const AllNearbyRestaurantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: kWhite,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const FoodsListShimmer();
        } else {
          return buildContent(controller.allRestaurants);
        }
      }),
    );
  }


  Widget buildContent(List<RestaurantsModel>? restaurants) {
    return Column(
      children: [
        HeaderWidget(
          imageUrl: "https://static.vecteezy.com/system/resources/previews/021/706/971/non_2x/cafe-exterior-with-table-and-chair-outside-cartoon-free-vector.jpg",
          height: 130.h,
        ),

        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 12.h, right: 12.w, left: 12.w),
            itemCount: (restaurants?.length ?? 0) + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const IntroTextWidget(
                  title: "Discover Culinary Delights!",
                  subtitle: "From our kitchen to your table, enjoy every delicious moment.",
                );
              }
              RestaurantsModel restaurant = restaurants![index - 1];
              return RestaurantTile(
                restaurant: restaurant,
              );
            },
          ),
        ),
      ],
    );
  }


}
