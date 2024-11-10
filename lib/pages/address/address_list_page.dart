import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/common_appbar.dart';
import 'package:food_delivery_app/common/custom_buttom.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/common/shimmers/foodlist_shimmer.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/pages/address/controllers/user_location_controller.dart';
import 'package:food_delivery_app/pages/address/widget/address_list_widget.dart';
import 'package:food_delivery_app/routes/names.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AddressListPage extends GetView<UserLocationController> {
  const AddressListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: const CommonAppBar(title: "My Addresses"),
      ),
      body: Stack(
        children: [
          Obx(() => _buildUI()),
          _buildAddAddressButton(),
        ],
      ),
    );
  }

  Widget _buildUI() {
    if (controller.isLoading.value) {
      return const FoodsListShimmer();
    } else if (controller.addresses.isEmpty) {
      return _buildEmptyState();
    } else {
      return AddressListWidget(
        addresses: controller.addresses,
        locationController: controller, 
      );
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 200.h),
          LottieBuilder.asset(
            "assets/anime/no_location.json",
            height: 220.h,
          ),
          SizedBox(height: 5.h),
          CustomText(
            text: "No Address!",
            style: appStyle(14.sp, Colors.black87, FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildAddAddressButton() {
    return Positioned(
      bottom: 20.h,
      left: 12,
      right: 12,
      child: CustomButton(
        onTap: () => Get.toNamed(AppRoutes.onAddUserAddressPage),
        text: 'Add Address',
        backgroundColor: kDark,
        textColor: kWhite,
        height: 50.h,
      ),
    );
  }

}
