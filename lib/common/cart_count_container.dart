import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/pages/cart/controller/cart_controller.dart';
import 'package:get/get.dart';

class CartCountContainer extends StatelessWidget {
  const CartCountContainer({
    super.key, this.bgColor, this.iconColor,
  });

  final Color? bgColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    return Padding(
      padding: EdgeInsets.only(right: 12.w),
      child: Container(
        height: 32.h,
        width: 50.w,
        decoration: BoxDecoration(
          color: bgColor ?? kWhite,
          borderRadius: BorderRadius.circular(10)
        ),
        padding: EdgeInsets.symmetric(horizontal: 6.w,),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Ionicons.cart,
              color: iconColor ?? kDark,
              size: 22,
            ),
            Obx(
              ()=> CustomText(
                text: cartController.count,
                style: appStyle(
                  13.5, 
                  iconColor ?? kDark, 
                  FontWeight.w700
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}