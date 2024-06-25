
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/custom_buttom.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/views/restaurant/rating_page.dart';
import 'package:food_delivery_app/views/restaurant/restaurant_page.dart';
import 'package:get/get.dart';

class RestaurantBottomBar extends StatelessWidget {
  const RestaurantBottomBar({
    super.key,
    required this.widget,
  });

  final RestaurantPage widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: kGray.withOpacity(0.6),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r)
        )
      ),
      height: 40.h,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RatingBarIndicator(
            rating: widget.restaurant!.rating.toDouble(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return const Icon(
                Icons.star,
                color: Colors.yellow,
              );
            },
            itemSize: 25,
          ),
          
          ///Rate Restaurant Button....
          CustomButton(
            onTap:() {
              Get.to(()=> const RatingPage());
            },
            fontSize: 12,
            text: "Rate Restaurant",
            width: width/3,
          ),
        ],
      ),
    );
  }
}