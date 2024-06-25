import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/shimmers/nearby_shimmer.dart';
import 'package:food_delivery_app/hooks/fetch_restaurants.dart';
import 'package:food_delivery_app/models/restaurants_model.dart';
import 'package:food_delivery_app/views/home/widgets/restaurant_widget.dart';
import 'package:food_delivery_app/views/restaurant/restaurant_page.dart';
import 'package:get/get.dart';

class NearbyRestaurants extends HookWidget {
  const NearbyRestaurants({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchRestaurants('41007428');
    List<RestaurantsModel>? restaurants = hookResult.data;
    final isLoading = hookResult.isLoading;


    return isLoading
    ? const NearbyShimmer()
    : Container(
      height: 190.h,
      padding: EdgeInsets.only(left: 12.w, top: 10.h),
      child:  ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          restaurants!.length,
          (index){
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
          }
        ),
      ),
    );
  }
}

