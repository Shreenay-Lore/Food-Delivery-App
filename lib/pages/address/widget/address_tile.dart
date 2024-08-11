import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/pages/address/controller/user_location_controller.dart';
import 'package:food_delivery_app/models/addresses_response_model.dart';
import 'package:get/get.dart';

class AddressTile extends HookWidget {
  const AddressTile({super.key, this.address});

  final AddressResponseModel? address;

  @override
  Widget build(BuildContext context) {
    final UserLocationController locationController = Get.put(UserLocationController());

    return GestureDetector(
      onTap: () {
        locationController.setDefaultAddress(address!.id!);
      },
      child: Container(
        padding: EdgeInsets.all(8.0.h),
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Ionicons.location,
              color: kGray,
              size: 30.h,
            ),
            SizedBox(width: 5.w),
            SizedBox(
              width: 275.w,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: address!.deliveryInstructions!,
                    style: appStyle(11.5, kDark, FontWeight.w600),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    address!.addressLine1!,
                    overflow: TextOverflow.ellipsis,
                    style: appStyle(10, kDark, FontWeight.w500),
                  ),
                  SizedBox(height: 6.h),
                  CustomText(
                    text: "Tap to set address as default",
                    style: appStyle(8, kGray, FontWeight.w400),
                  ),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: (){

              },
              child: Icon(
                Ionicons.close,
                color: kGray,
                size: 18.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
