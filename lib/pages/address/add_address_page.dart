// ignore_for_file: prefer_collection_literals

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/back_ground_container.dart';
import 'package:food_delivery_app/common/custom_buttom.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/pages/address/controller/user_location_controller.dart';
import 'package:food_delivery_app/hooks/fetch_default_address.dart';
import 'package:food_delivery_app/models/addresses_response_model.dart';
import 'package:food_delivery_app/pages/auth/widget/email_textfield.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddress extends HookWidget {
  const AddAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final UserLocationController locationController = Get.put(UserLocationController());
    final hookResult = useFetchDefaultAddress(context);
    AddressResponseModel? defaultAddress = hookResult.data;
    final isLoading = hookResult.isLoading;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: _buildAppBar(locationController),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: PageView(
          controller: locationController.pageController,
          physics: const NeverScrollableScrollPhysics(),
          pageSnapping: false,
          onPageChanged: (index) {
            locationController.pageController.jumpToPage(index);
          },
          children: [
            googleMapPage(locationController),
            submitAddressPage(locationController, defaultAddress, isLoading)      
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(UserLocationController locationController){
    return AppBar(
      backgroundColor: kOffWhite,
      centerTitle: true,
      elevation: 0,
      title: CustomText(
        text: "Shipping Address",
        style: appStyle(14, kGray, FontWeight.w600),
      ),
      leading: Obx(
        () => Padding(
          padding: EdgeInsets.only(right: 0.w),
          child: locationController.tabIndex == 0
            ? IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(AntDesign.closecircleo, color: kRed),
              )
            : IconButton(
                onPressed: () {
                  locationController.setTabIndex = 0;
                  locationController.pageController.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                },
                icon: const Icon(AntDesign.leftcircleo, color: kDark),
              ),
        ),
      ),
      actions: [
        Obx(
          () => locationController.tabIndex == 1
              ? const SizedBox.shrink()
              : Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: IconButton(
                    onPressed: () {
                      locationController.setTabIndex = 1;
                      locationController.pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    icon: const Icon(AntDesign.rightcircleo, color: kDark),
                  ),
                ),
        ),
      ],
    );
  }

  Widget googleMapPage(UserLocationController locationController){
    return Obx(() => Stack(
      children: [
        GoogleMap(
          onMapCreated: (GoogleMapController mapController) {
            locationController.mapController = mapController;
          },
          initialCameraPosition: CameraPosition(
            target: locationController.selectedPosition.value,
            zoom: 15,
          ),
          markers: Set.of([
            Marker(
              markerId: const MarkerId('Your Location'),
              position: locationController.selectedPosition.value,
              draggable: true,
              onDragEnd: (LatLng position) {
                locationController.selectedPosition.value = position;
                locationController.updateSearchController(position);
              },
            ),
          ]),
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: 20.h,
          child: CustomButton(
            height: 40.h,
            text: locationController.isLoadingLocation.value ? "Loading..." : "Get Current Location",
            backgroundColor: kDark,
            textColor: kWhite,
            onTap: locationController.isLoadingLocation.value ? null : locationController.getCurrentLocation,
          ),
        ),
      ],
    ));
  }

  Widget submitAddressPage(
      UserLocationController locationController, 
      AddressResponseModel? defaultAddress, 
      bool isLoading){
    return BackGroundContainer(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: ListView(
          children: [
            SizedBox(height: 30.h),
            EmailTextField(
              controller: locationController.searchController,
              hintText: "Address",
              prefixIcon: const Icon(Ionicons.location_sharp, size: 22, color: kGrayLight),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 15.h),
            EmailTextField(
              controller: locationController.postalCode,
              hintText: "Postal Code",
              prefixIcon: const Icon(Ionicons.location_sharp, size: 22, color: kGrayLight),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 15.h),
            EmailTextField(
              controller: locationController.deliveryInstructions,
              hintText: "Delivery Instructions",
              prefixIcon: const Icon(AntDesign.menu_fold, size: 22, color: kGrayLight),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Set address as default",
                    style: appStyle(12, kDark, FontWeight.w600),
                  ),
                  Obx(
                    () => CupertinoSwitch(
                      thumbColor: kWhite,
                      activeColor: kPrimary,
                      value: locationController.isDefault,
                      onChanged: (value) {
                        locationController.setIsDefault = value;
                        String data = jsonEncode(defaultAddress);
                        locationController.setAddress = data;
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 35.h),
            CustomButton(
              height: 45.h,
              backgroundColor: kPrimary,
              borderColor: kPrimary,
              textColor: kWhite,
              text: isLoading ? 'Loading...' : 'S U B M I T',
              onTap: () {
                locationController.submitAddress(defaultAddress);
              },
            ),
          ],
        ),
      ),
    );
  }
}
