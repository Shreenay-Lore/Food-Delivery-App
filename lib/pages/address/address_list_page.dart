import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/common_appbar.dart';
import 'package:food_delivery_app/common/custom_buttom.dart';
import 'package:food_delivery_app/common/shimmers/foodlist_shimmer.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/hooks/fetch_addresses.dart';
import 'package:food_delivery_app/models/addresses_response_model.dart';
import 'package:food_delivery_app/pages/address/add_address_page.dart';
import 'package:food_delivery_app/pages/address/widget/address_list_widget.dart';
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: const CommonAppBar(
          title: "My addresses",
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