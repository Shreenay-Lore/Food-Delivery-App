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
import 'package:food_delivery_app/models/address_model.dart';
import 'package:food_delivery_app/models/addresses_response_model.dart';
import 'package:food_delivery_app/pages/auth/widget/email_textfield.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class AddAddress extends StatefulHookWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  late final PageController _pageController = PageController(initialPage: 0);
  GoogleMapController? _mapController;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _postalCode = TextEditingController();
  final TextEditingController _deliveryInstructions = TextEditingController();
  LatLng? _selectedPosition = const LatLng(28.7041, 77.1025); 
  bool _isLoadingLocation = false;

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {});
    });
    _updateSearchController(_selectedPosition!); 
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoadingLocation = true;
    });

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _isLoadingLocation = false;
      });
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _isLoadingLocation = false;
        });
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _isLoadingLocation = false;
      });
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _selectedPosition = LatLng(position.latitude, position.longitude);
      _updateSearchController(_selectedPosition!);
      moveToSelectedPosition();
      _isLoadingLocation = false;
    });
  }

  Future<void> _updateSearchController(LatLng position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      setState(() {
        _searchController.text = "${place.name}, ${place.subLocality}, ${place.locality}-${place.postalCode}, ${place.administrativeArea}, ${place.country}";
        _postalCode.text = "${place.postalCode}";
      });
    }
  }

  void moveToSelectedPosition() {
    if (_selectedPosition != null && _mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _selectedPosition!,
            zoom: 15,
          ),
        ),
      );
    }
  }

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
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          pageSnapping: false,
          onPageChanged: (index) {
            _pageController.jumpToPage(index);
          },
          children: [
            googleMapPage(),
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
                  _pageController.previousPage(
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
                      _pageController.nextPage(
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

  Widget googleMapPage(){
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
          },
          initialCameraPosition: CameraPosition(
            target: _selectedPosition ?? const LatLng(28.7041, 77.1025),
            zoom: 15,
          ),
          markers: Set.of([
            Marker(
              markerId: const MarkerId('Your Location'),
              position: _selectedPosition!,
              draggable: true,
              onDragEnd: (LatLng position) {
                //locationController.getUserAddress(position);
                setState(() {
                  _selectedPosition = position;
                  _updateSearchController(_selectedPosition!);
                });
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
            text: _isLoadingLocation ? "Loading..." : "Get Current Location",
            backgroundColor: kDark,
            textColor: kWhite,
            onTap: _isLoadingLocation ? null : _getCurrentLocation,
          ),
        ),
      ],
    );
  }

  Widget submitAddressPage
        (UserLocationController locationController, AddressResponseModel? defaultAddress, bool isLoading){
    return BackGroundContainer(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: ListView(
          children: [
            SizedBox(height: 30.h),
            EmailTextField(
              controller: _searchController,
              hintText: "Address",
              prefixIcon: const Icon(Ionicons.location_sharp, size: 22, color: kGrayLight),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 15.h),
            EmailTextField(
              controller: _postalCode,
              hintText: "Postal Code",
              prefixIcon: const Icon(Ionicons.location_sharp, size: 22, color: kGrayLight),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 15.h),
            EmailTextField(
              controller: _deliveryInstructions,
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
                if (_searchController.text.isNotEmpty &&
                    _postalCode.text.isNotEmpty &&
                    _deliveryInstructions.text.isNotEmpty) {
                  AddressModel model = AddressModel(
                    addressLine1: _searchController.text,
                    postalCode: _postalCode.text,
                    addressModelDefault: locationController.isDefault,
                    deliveryInstructions: _deliveryInstructions.text,
                    latitude: _selectedPosition!.latitude,
                    longitude: _selectedPosition!.longitude,
                  );

                  String data = addressModelToJson(model);

                  locationController.addAddress(data);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
