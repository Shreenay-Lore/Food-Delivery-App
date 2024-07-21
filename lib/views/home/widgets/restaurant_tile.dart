import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/models/restaurants_model.dart';
import 'package:food_delivery_app/views/restaurant/restaurant_page.dart';
import 'package:food_delivery_app/views/restaurant/widget/row_icon_text.dart';
import 'package:get/get.dart';

class RestaurantTile extends StatelessWidget {
  const RestaurantTile({super.key, required this.restaurant});

  final RestaurantsModel restaurant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(()=> RestaurantPage(restaurant: restaurant,));
      },
      child: Container(
        color: kWhite,
        margin: EdgeInsets.only(bottom: 34.h,),
        width: width,
        child: Row(
          children: [
            Material(
              elevation: 6,
              borderRadius: BorderRadius.all(Radius.circular(14.r)),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(14.r)),
                child: SizedBox(
                  height: 135.h,
                  width: 120.w,
                  child: Image.network(
                    restaurant.imageUrl, 
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          
            SizedBox(width: 10.w,),
            
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: restaurant.title, 
                  style: appStyle(14, kDark, FontWeight.w700)
                ),
                SizedBox(
                  height: 6.h,
                ),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      MaterialCommunityIcons.star_circle,
                      color: Colors.green,
                      size: 21,
                    ),
                    SizedBox(width: 1.w,),
                    CustomText(
                      text: restaurant.rating.toString(),
                      style: appStyle(14, kDark, FontWeight.w600),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 1.h),
                      child: CustomText(
                        text: "  (${restaurant.ratingCount}+ rating)",
                        style: appStyle(12, kDark, FontWeight.w600),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 6.h,
                ),
                RowIconText(
                  icon: MaterialCommunityIcons.truck_fast_outline,
                  text: restaurant.time,
                ),

                SizedBox(
                  height: 6.h,
                ),
            
                Row(
                  children: [
                    Icon(
                      Ionicons.location,
                      color: kDark,
                      size: 14.h,
                    ),
                    SizedBox(
                      width: 5.h,
                    ),
                    SizedBox(
                      width: width*0.5,
                      child: Text(restaurant.coords.address,
                      overflow: TextOverflow.ellipsis,
                      style: appStyle(10, kGray, FontWeight.w500)),
                    ),
                  ],
                ),
            
              ],
            )
          ],
        ),
      ),
    );
  }
}

//Positioned(
//   right: 5.w,
//   top: 6.h,
//   child: Container(
//     width: 60.w,
//     height: 19.h,
//     decoration: BoxDecoration(
//       color:  restaurant.isAvailable == true || 
//               // ignore: unnecessary_null_comparison
//               restaurant.isAvailable == null 
//               ? kPrimary 
//               : kSecondary,
//       borderRadius: BorderRadius.circular(10.r)
//     ),
//     child: Center(
//       child: CustomText(
//         text: restaurant.isAvailable == true || 
//               // ignore: unnecessary_null_comparison
//               restaurant.isAvailable == null 
//               ? "Open"
//               : "Closed",
//         style: appStyle(12, kLightWhite, FontWeight.w600)
//       ),
//     ),
//   )
// )