import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RestaurantWidget extends StatelessWidget {
  const RestaurantWidget({
    super.key,
    required this.image, 
    required this.logo, 
    required this.title, 
    required this.time, 
    required this.rating, 
    required this.ratingCount, 
    this.onTap,
  });

  final String image;
  final String logo;
  final String title;
  final String time;
  final double rating;
  final String ratingCount;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: Container(
          height: 192.h,
          width: width * 0.75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: kLightWhite
          ),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.all(8.0.w),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: SizedBox(
                        height: 112.h,
                        width: width * 0.8,
                        child: Image.network(image, fit: BoxFit.fitWidth,),
                      ),
                    ),
                    Positioned(
                      right: 10.w,
                      top: 10.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.r),
                        child: Container(
                          color: kLightWhite,
                          child: Padding(
                            padding: EdgeInsets.all(2.h),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.r),
                              child: Image.network(
                                logo,
                                fit: BoxFit.cover,
                                height: 20.h,
                                width: 20.w,
                              ),
                            ),
                          ),

                        ),
                      )
                    )
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: title, 
                      style: appStyle(12, kDark, FontWeight.w500)
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Delivery Time', 
                          style: appStyle(9, kGray, FontWeight.w500)
                        ),
                        CustomText(
                          text: time, 
                          style: appStyle(9, kGray, FontWeight.w500)
                        ),
                      ],
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBarIndicator(
                          rating: rating,
                          itemBuilder: (context, index) {
                            return const Icon(
                              Icons.star,
                              color: kPrimary,
                            );
                          },
                          itemCount: 5,
                          itemSize: 15.h,
                        ),
                        SizedBox(width: 10.w,),
                        CustomText(
                          text: "+ $ratingCount reviews & ratings", 
                          style: appStyle(9, kGray, FontWeight.w500)
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}