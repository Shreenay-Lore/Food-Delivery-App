import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_buttom.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/common/shimmers/foodlist_shimmer.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/hooks/fetch_addresses.dart';
import 'package:food_delivery_app/models/addresses_response_model.dart';
import 'package:food_delivery_app/views/profile/add_address_page.dart';
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
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: kWhite,
        elevation: 0,
        leadingWidth: 25.w,
        title: CustomText(text: "SELECT ADDRESS",
        style: appStyle(13.5, kGray, FontWeight.w600),
        ),
      ),
      body: Stack(
        children: [
          isLoading
          ? const FoodsListShimmer()         
          : AddressListWidget(addresses: addresses!),
      
          Positioned(
            bottom: 20.h,
            left: 12,
            right: 12,
            child: CustomButton(
              onTap: () {
                Get.to(()=> const AddAddress());
              },
              text: 'Add Address',
              backgroundColor: kDark,
              borderColor: kPrimary,
              textColor: kWhite,
              height: 50.h,
            ),
          )
        ],
      ),
    );
  }
}