import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';

class FoodWidget extends StatelessWidget {
  const FoodWidget({
    super.key,
    required this.image, 
    required this.price, 
    required this.title, 
    required this.time, 
    this.onTap, required this.rating,
  });

  final String image;
  final String price;
  final String title;
  final String time;
  final double rating;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(left: 14.w, bottom: 10.h,),
        child: Material(
          elevation: 4, 
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            height: 180.h,
            width: width * 0.35.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: kWhite,
            ),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: SizedBox(
                    height: 122.h,
                    width: width,
                    child: Image.network(image, fit: BoxFit.fill,),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: title, 
                        maxLines: 1,
                        style: appStyle(11, kDark, FontWeight.w600)
                      ),
                      SizedBox(height: 2.h,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Ionicons.star,
                            color: Colors.black, 
                            size: 15
                          ),
                          SizedBox(width: 11.w,),
                          CustomText(
                            text: rating.toString(), 
                            style: appStyle(9, kGray, FontWeight.w500)
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h,),
                      CustomText(
                        text: "₹ $price", 
                        style: appStyle(12, kDark, FontWeight.w600)
                      ),
                      
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