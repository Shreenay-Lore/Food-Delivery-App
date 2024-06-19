import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/back_ground_container.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/common/shimmers/foodlist_shimmer.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/hooks/fetch_all_restaurants.dart';
import 'package:food_delivery_app/models/restaurants_model.dart';
import 'package:food_delivery_app/views/home/widgets/restaurant_tile.dart';

class AllNearbyRestaurantsPage extends HookWidget {
  const AllNearbyRestaurantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchAllRestaurants('41007428');
    List<RestaurantsModel>? restaurants = hookResult.data;
    final isLoading = hookResult.isLoading;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kOffWhite,
        elevation: 0,
        centerTitle: true,
        title: CustomText(text: "Nearby Restaurants",
        style: appStyle(13, kGray, FontWeight.w600),
        ),
      ),
      body: BackGroundContainer(
        child: isLoading
        ? const FoodsListShimmer()         
        : Padding(
          padding:  EdgeInsets.all(12.h),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: List.generate(
              restaurants!.length,
              (index){
                RestaurantsModel restaurant = restaurants[index];
                return RestaurantTile(
                  restaurant: restaurant,
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}