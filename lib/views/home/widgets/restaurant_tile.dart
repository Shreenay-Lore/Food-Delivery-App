import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/models/restaurants_model.dart';

class RestaurantTile extends StatelessWidget {
  const RestaurantTile({super.key, required this.restaurant});

  final RestaurantsModel restaurant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
      },
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8.h,),
            height: 70.h,
            width: width,
            decoration: BoxDecoration(
              color: kOffWhite,
              borderRadius: BorderRadius.circular(9.r),
            ),
            child: Container(
              padding: EdgeInsets.all(4.r),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(9.r)),
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 70.h,
                          width: 70.w,
                          child: Image.network(
                            restaurant.imageUrl, 
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.only(left: 6.w, bottom: 2.h),
                            color: kGray.withOpacity(0.6),
                            height: 16.h,
                            width: width,
                            child: RatingBarIndicator(
                              rating: 5,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return const Icon(
                                  Icons.star,
                                  color: kSecondary,
                                );
                              },
                              itemSize: 12.h,
                            ),
                          )
                        )
                      ],
                    ),
                  ),
                
                  SizedBox(width: 10.w,),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: restaurant.title, 
                        style: appStyle(11, kDark, FontWeight.w400)
                      ),

                      CustomText(
                        text: "Delivery Time: ${restaurant.time}", 
                        style: appStyle(11, kGray, FontWeight.w400)
                      ),

                      SizedBox(
                        width: width*0.7,
                        child: Text(restaurant.coords.address,
                        overflow: TextOverflow.ellipsis,
                        style: appStyle(9, kGray, FontWeight.w400)),
                      ),

                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: 5.w,
            top: 6.h,
            child: Container(
              width: 60.w,
              height: 19.h,
              decoration: BoxDecoration(
                color:  restaurant.isAvailable == true || 
                        restaurant.isAvailable == null 
                        ? kPrimary 
                        : kSecondary,
                borderRadius: BorderRadius.circular(10.r)
              ),
              child: Center(
                child: CustomText(
                  text: restaurant.isAvailable == true || 
                        restaurant.isAvailable == null 
                        ? "Open"
                        : "Closed",
                  style: appStyle(12, kLightWhite, FontWeight.w600)
                ),
              ),
            )
          )
        ]
      ),
    );
  }
}