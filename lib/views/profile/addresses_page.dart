import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/back_ground_container.dart';
import 'package:food_delivery_app/common/custom_buttom.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/common/shimmers/foodlist_shimmer.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/hooks/fetch_addresses.dart';
import 'package:food_delivery_app/models/addresses_response_model.dart';
import 'package:food_delivery_app/views/profile/shipping_address.dart';
import 'package:food_delivery_app/views/profile/widget/address_list_widget.dart';
import 'package:get/get.dart';

class AddressesPage extends HookWidget {
  const AddressesPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchAllAddresses();
    List<AddressResponseModel>? addresses = hookResult.data;
    final isLoading = hookResult.isLoading;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kOffWhite,
        elevation: 0,
        centerTitle: true,
        title: CustomText(text: "Addresses",
        style: appStyle(13, kGray, FontWeight.w600),
        ),
      ),
      body: BackGroundContainer(
        child: Stack(
          children: [
            isLoading
            ? const FoodsListShimmer()         
            : Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: AddressListWidget(addresses: addresses!),
              ),

            Positioned(
              bottom: 30.h,
              left: 12,
              right: 12,
              child: CustomButton(
                onTap: () {
                  Get.to(()=> const ShippingAddress());
                },
                text: 'Add Address',
                backgroundColor: kPrimary,
                borderColor: kPrimary,
                textColor: kWhite,
                height: 40.h,
              ),
            )
          ],
        )
      ),
    );
  }
}