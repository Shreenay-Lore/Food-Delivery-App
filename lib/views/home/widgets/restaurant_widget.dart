import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
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
        padding: EdgeInsets.only(bottom: 18.h, left: 12.w, right: 12.w,),
        child: Material(
          elevation: 4, 
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            height: 220.h,
            width: width * 0.75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: kWhite
            ),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.r),
                          topRight: Radius.circular(12.r),
                        ),
                        child: SizedBox(
                          height: 155.h,
                          width: width,
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
                                  height: 28.h,
                                  width: 28.w,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: title, 
                            style: appStyle(13.5, kDark, FontWeight.w600)
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Icon(
                                MaterialCommunityIcons.motorbike,
                                color: Colors.black, 
                                size: 20
                              ),
                              SizedBox(width: 5.w,),
                              CustomText(
                                text: time, 
                                style: appStyle(9, kGray, FontWeight.w500)
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RatingBarIndicator(
                            rating: rating,
                            itemBuilder: (context, index) {
                              return const Icon(
                                Icons.star,
                                color: kDark,
                                //color: Color.fromARGB(255, 248, 227, 32),
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
      ),
    );
  }
}