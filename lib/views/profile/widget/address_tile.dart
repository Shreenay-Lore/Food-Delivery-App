import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/controller/user_location_controller.dart';
import 'package:food_delivery_app/hooks/fetch_default_address.dart';
import 'package:food_delivery_app/models/addresses_response_model.dart';
import 'package:get/get.dart';

class AddressTile extends HookWidget {
  const AddressTile({super.key, this.address});

  final AddressResponseModel? address;

  @override
  Widget build(BuildContext context) {
    final UserLocationController locationController = Get.put(UserLocationController());
    final hookResult = useFetchDefaultAddress(context);
    AddressResponseModel? defaultAddress = hookResult.data;
    final isLoading = hookResult.isLoading;

    return isLoading 
      ? const Center(child: CircularProgressIndicator())
      : ListTile(
        onTap: () {
          // locationController.setIsDefault = true;
          // String data = jsonEncode(defaultAddress);
          // locationController.setAddress1 = data;
        },
        visualDensity: VisualDensity.compact,
        leading: Icon(
          SimpleLineIcons.location_pin,
          color: kPrimary,
          size: 28.h,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r)
        ),
        title: CustomText(
          text: address!.addressLine1,
          style: appStyle(11, kDark, FontWeight.w500),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: address!.postalCode,
              style: appStyle(11, kGray, FontWeight.w500),
            ),
            CustomText(
              text: "Tap to set address as default",
              style: appStyle(8, kGray, FontWeight.w500),
            ),
          ],
        ),
      );
  }
}