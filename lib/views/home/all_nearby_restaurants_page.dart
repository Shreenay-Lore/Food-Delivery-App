import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/common/shimmers/foodlist_shimmer.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/hooks/fetch_all_restaurants.dart';
import 'package:food_delivery_app/models/restaurants_model.dart';
import 'package:food_delivery_app/views/home/widgets/restaurant_tile.dart';
import 'package:get/get.dart';

class AllNearbyRestaurantsPage extends HookWidget {
  const AllNearbyRestaurantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchAllRestaurants('41007428');
    List<RestaurantsModel>? restaurants = hookResult.data;
    final isLoading = hookResult.isLoading;

    return Scaffold(
      backgroundColor: kWhite,
      body: isLoading
          ? const FoodsListShimmer()
          : Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 130.h,
                      color: kLightWhite,
                      child: CachedNetworkImage(
                        fit: BoxFit.fitWidth,
                        imageUrl: "https://static.vecteezy.com/system/resources/previews/021/706/971/non_2x/cafe-exterior-with-table-and-chair-outside-cartoon-free-vector.jpg",
                      ),
                    ),

                    ///Back Button....
                    Positioned(
                      top: 45.h,
                      left: 14,
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Ionicons.arrow_back_circle,
                          color: kWhite,
                          size: 32.h,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 12.h, right: 12.w, left: 12.w),
                    itemCount: (restaurants?.length ?? 0) + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "Discover Culinary Delights!",
                                style: appStyle(15, kDark, FontWeight.bold),
                              ),
                              SizedBox(height: 7.h,),
                              CustomText(
                                text: "From our kitchen to your table, enjoy every delicious moment.",
                                style: appStyle(9, kGray, FontWeight.w500),
                              ),
                              SizedBox(height: 15.h,),
                            ],
                          ),
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
            ),
    );
  }
}
