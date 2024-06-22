import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/models/foods_model.dart';

class FoodTile extends StatelessWidget {
  const FoodTile({super.key, required this.food, this.color});

  final FoodsModel food;
  final Color? color;

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
              color: color ?? kOffWhite,
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
                            food.imageUrl[0], 
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
                        text: food.title, 
                        style: appStyle(11, kDark, FontWeight.w400)
                      ),

                      CustomText(
                        text: "Delivery Time: ${food.time}", 
                        style: appStyle(11, kGray, FontWeight.w400)
                      ),

                      SizedBox(
                        width: width*0.7,
                        height: 15.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: food.additives.length,
                          itemBuilder: (context, index) {
                            Additive additive = food.additives[index];
                            return Container(
                              margin: EdgeInsets.only(right: 5.w),
                              decoration: BoxDecoration(
                                color: kSecondaryLight,
                                borderRadius: BorderRadius.all(Radius.circular(9.h))
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                  child: CustomText(
                                    text: additive.title, 
                                    style: appStyle(8, kGray, FontWeight.w400)
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
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
                color: kPrimary,
                borderRadius: BorderRadius.circular(10.r)
              ),
              child: Center(
                child: CustomText(
                  text: '\$ ${food.price.toStringAsFixed(2)}',
                  style: appStyle(12, kLightWhite, FontWeight.bold)
                ),
              ),
            )
          ),

          Positioned(
            right: 75.w,
            top: 6.h,
            child: GestureDetector(
              onTap: () {
                
              },
              child: Container(
                width: 19.w,
                height: 19.h,
                decoration: BoxDecoration(
                  color: kSecondary,
                  borderRadius: BorderRadius.circular(10.r)
                ),
                child: Center(
                  child: Icon(
                    MaterialCommunityIcons.cart, 
                    size: 15.h,
                    color: kLightWhite,
                  )
                ),
              ),
            )
          ),
        ]
      ),
    );
  }
}