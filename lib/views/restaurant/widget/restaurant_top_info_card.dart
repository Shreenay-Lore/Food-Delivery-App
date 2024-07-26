
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/cart_count_container.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/views/cart/cart_page.dart';
import 'package:food_delivery_app/views/restaurant/rating_page.dart';
import 'package:food_delivery_app/views/restaurant/restaurant_page.dart';
import 'package:food_delivery_app/views/restaurant/widget/row_icon_text.dart';
import 'package:get/get.dart';

class RestaurantTopInfoCard extends StatelessWidget {
  const RestaurantTopInfoCard({
    super.key,
    required this.widget,
  });

  final RestaurantPage widget;

  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: BoxDecoration(
          color: kOffWhite,
          borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(30.r),
          bottomLeft: Radius.circular(30.r)
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(14.w, 0.h, 14.w, 22.h),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30.r),
            bottomLeft: Radius.circular(30.r)
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 95.h),
                child: Material(
                  elevation: 20,
                  borderRadius: BorderRadius.all(Radius.circular(20.r)),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.r)),
                      color: kWhite,
                    ),
                    width: width,
                    height: 170.h,
                    child: Padding(
                      padding: EdgeInsets.only(top: 44.h,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ///Restaurant Title...
                          CustomText(
                            text: widget.restaurant!.title,
                            style: appStyle(19, kDark, FontWeight.w700),
                          ),
                          SizedBox(height: 8.h,),
                          GestureDetector(
                            onTap: () {
                              Get.to(()=> const RatingPage());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  MaterialCommunityIcons.star_circle,
                                  color: Colors.green,
                                  size: 21,
                                ),
                                SizedBox(width: 1.w,),
                                CustomText(
                                  text: widget.restaurant!.rating.toString(),
                                  style: appStyle(11.5, kGray, FontWeight.w600),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(top: 1.h),
                                  child: CustomText(
                                    text: "  (${widget.restaurant!.ratingCount}+ rating)",
                                    style: appStyle(10.5, kGray, FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 6.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RowIconText(
                                icon: Icons.access_time,
                                text: "${widget.restaurant!.time}  |  ",
                              ),
                              const RowIconText(
                                icon: MaterialCommunityIcons.truck_fast_outline,
                                text: "Free Delivery",
                              ),
                            ],
                          ),
                          SizedBox(height: 6.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RowIconText(
                                icon: Ionicons.location,
                                text: widget.restaurant!.coords.address,
                              ),
                            ],
                          ),
                          SizedBox(height: 6.h,),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      
              Positioned(
                top: 58.h,
                bottom: 140.h,
                right: 140.w,
                left: 140.w,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6.r)),
                    border: Border.all(color: kGrayLight),
                    color: kWhite,
                  ),
                  height: 200.h,
                  width: 200.w,
                  child: Padding(
                    padding: EdgeInsets.all(10.h),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      child: Image.network(
                        widget.restaurant!.logoUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              ),
      
                      
              ///Back Button....
              Positioned(
                top: 45.h,
                left: 0,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Ionicons.arrow_back_circle,
                    color: kGray,
                    size: 32.h,
                  ),
                ),
              ),  

              Positioned(
                top: 45.h,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    Get.to(()=> const CartPage());
                  },
                  child: const CartCountContainer()
                ),
              ),      
            ],
          ),
        ),
      ),
    );
    
  }
}