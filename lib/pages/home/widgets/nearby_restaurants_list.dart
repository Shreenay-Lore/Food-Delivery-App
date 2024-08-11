import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/shimmers/nearby_shimmer.dart';
import 'package:food_delivery_app/hooks/fetch_restaurants.dart';
import 'package:food_delivery_app/models/restaurants_model.dart';
import 'package:food_delivery_app/pages/home/controller/home_controller.dart';
import 'package:food_delivery_app/pages/home/widgets/restaurant_widget.dart';
import 'package:food_delivery_app/pages/restaurant/restaurant_page.dart';
import 'package:get/get.dart';

class NearbyRestaurants extends HookWidget {
  const NearbyRestaurants({super.key});

  @override
  Widget build(BuildContext context) {
    //final HomeController controller = Get.put(HomeController());
    final hookResult = useFetchRestaurants('41007428');
    List<RestaurantsModel>? restaurants = hookResult.data;
    final isLoading = hookResult.isLoading;
    // return Obx(() {
    //   if (controller.isLoading.value) {
    //     return const NearbyShimmer();
    //   } else {
    //     return Container(
    //       height: 1200.h,
    //       padding: EdgeInsets.only(top: 12.h,),
    //       child:  ListView.builder(
    //         physics: const NeverScrollableScrollPhysics(),
    //         itemCount: controller.dashboardRestaurants.length,
    //         scrollDirection: Axis.vertical,
    //         itemBuilder: (context, index) {
    //           RestaurantsModel restaurant = controller.dashboardRestaurants[index];
    //           return  RestaurantWidget(
    //             onTap:() => Get.to(()=> RestaurantPage(restaurant: restaurant,)),
    //             image: restaurant.imageUrl,
    //             logo: restaurant.logoUrl,
    //             title: restaurant.title,
    //             time: restaurant.time,
    //             rating: restaurant.rating.toDouble(),
    //             ratingCount: restaurant.ratingCount,
    //           );
    //         },
    //       ),
    //     );
    //   }
    // });

    return isLoading
    ? const NearbyShimmer()
    : Container(
      height: 1200.h,
      padding: EdgeInsets.only(top: 12.h,),
      child:  ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: restaurants!.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          RestaurantsModel restaurant = restaurants[index];
          return  RestaurantWidget(
            onTap:() => Get.to(()=> RestaurantPage(restaurant: restaurant,)),
            image: restaurant.imageUrl,
            logo: restaurant.logoUrl,
            title: restaurant.title,
            time: restaurant.time,
            rating: restaurant.rating.toDouble(),
            ratingCount: restaurant.ratingCount,
          );
        },
      ),
    );
  }
}

