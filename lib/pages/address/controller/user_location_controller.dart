// ignore_for_file: prefer_final_fields


import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/models/address_model.dart';
import 'package:food_delivery_app/models/addresses_response_model.dart';
import 'package:food_delivery_app/models/api_error.dart';
import 'package:food_delivery_app/pages/main_screen/entry_point.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class UserLocationController extends GetxController{
  // GetStorage instance to access stored data
  final box = GetStorage();

  // Observable variables for default address status, tab index, and address string
  RxBool _isDefault = false.obs;
  RxInt _tabIndex = 0.obs;
  RxString _address = ''.obs;

  // Getters and setters for the observable variables
  bool get isDefault => _isDefault.value;
  set setIsDefault(bool value) => _isDefault.value = value;

  int get tabIndex => _tabIndex.value;
  set setTabIndex(int value) => _tabIndex.value = value;

  String get address => _address.value;
  set setAddress(String value) => _address.value = value;

  // Function to add an address using the Google API
  void addAddress(String data,) async {
    String accessToken = box.read('token');

    Uri url = Uri.parse('$appBaseUrl/api/address');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization' : 'Bearer $accessToken',
    };

    try{  
      print('Making request to: $url');

      var response = await http.post(
        url,
        headers: headers,
        body: data,
      );
      
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      if(response.statusCode == 201){
        
        Get.snackbar(
          "Your address has been added.", "Order Food! ",
          colorText: kWhite,
          backgroundColor: kPrimary,
          icon: const Icon(Ionicons.fast_food_outline)
        );

        Get.offAll(()=> MainScreen());

      }else{
        var error = apiErrorFromJson(response.body);
        Get.snackbar( 
          "Failed to add address", error.message,
          colorText: kWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.error)
        );
      }

    }catch(e){
      debugPrint(e.toString());
    }
  }
  
  // Function to set an address as the default address
  void setDefaultAddress(String addressId,) async {
    String accessToken = box.read('token');

    Uri url = Uri.parse('$appBaseUrl/api/address/default/$addressId');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization' : 'Bearer $accessToken',
    };

    try{  
      print('Making request to: $url');

      var response = await http.patch(
        url,
        headers: headers,
      );
      
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      if(response.statusCode == 200){
        
        Get.snackbar(
          "Address set as default", "Order Food! ",
          colorText: kWhite,
          backgroundColor: kDark,
          icon: const Icon(Ionicons.fast_food_outline)
        );

        Get.offAll(()=> MainScreen());

      }else{
        var error = apiErrorFromJson(response.body);
        Get.snackbar( 
          "Failed to set address as default", error.message,
          colorText: kWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.error)
        );

      }

    }catch(e){
      debugPrint(e.toString());
    }
  }
  
  // Controllers for page view and Google Map
  final PageController pageController = PageController(initialPage: 0);
  GoogleMapController? mapController;

  // Controllers for text input fields
  final TextEditingController searchController = TextEditingController();
  final TextEditingController postalCode = TextEditingController();
  final TextEditingController deliveryInstructions = TextEditingController();

  // Observable variables for selected map position and loading status
  Rx<LatLng> selectedPosition = const LatLng(28.7041, 77.1025).obs;
  RxBool isLoadingLocation = false.obs;

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      update();
    });
    updateSearchController(selectedPosition.value);
  }

  @override
  void onClose() {
    pageController.dispose();
    searchController.dispose();
    postalCode.dispose();
    deliveryInstructions.dispose();
    super.onClose();
  }

  // Function to get the current location of the user
  Future<void> getCurrentLocation() async {
    isLoadingLocation.value = true;

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      isLoadingLocation.value = false;
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        isLoadingLocation.value = false;
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      isLoadingLocation.value = false;
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    selectedPosition.value = LatLng(position.latitude, position.longitude);
    updateSearchController(selectedPosition.value);
    moveToSelectedPosition();
    isLoadingLocation.value = false;
  }

  // Function to update the search controller with the address details of the selected position
  Future<void> updateSearchController(LatLng position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      searchController.text =
          "${place.name}, ${place.subLocality}, ${place.locality}-${place.postalCode}, ${place.administrativeArea}, ${place.country}";
      postalCode.text = "${place.postalCode}";
    }
  }

  // Function to move the map camera to the selected position
  void moveToSelectedPosition() {
    if (mapController != null) {
      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: selectedPosition.value,
            zoom: 15,
          ),
        ),
      );
    }
  }

  // Function to submit the address
  void submitAddress( AddressResponseModel? defaultAddress) {
    if (searchController.text.isNotEmpty &&
        postalCode.text.isNotEmpty &&
        deliveryInstructions.text.isNotEmpty) {
      AddressModel model = AddressModel(
        addressLine1: searchController.text,
        postalCode: postalCode.text,
        addressModelDefault: isDefault,
        deliveryInstructions: deliveryInstructions.text,
        latitude: selectedPosition.value.latitude,
        longitude: selectedPosition.value.longitude,
      );

      String data = addressModelToJson(model);
      addAddress(data);
    }
  }

}

