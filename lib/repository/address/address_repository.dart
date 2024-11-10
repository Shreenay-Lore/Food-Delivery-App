import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/data/apis/app_url.dart';
import 'package:food_delivery_app/data/network/network_api_services.dart';
import 'package:food_delivery_app/models/addresses_response_model.dart';
import 'package:food_delivery_app/models/api_error.dart';
import 'package:food_delivery_app/routes/names.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AddressRepository {
  final ApiClient _apiClient = ApiClient();
  final box = GetStorage();

  Future<void> addAddress(String body) async {
    try {
      var response = await _apiClient.postRequest(endpoint: AppUrl.addAddressApi, body: body);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 201) {
        Get.snackbar(
          "Your address has been added.", "Order Food! ",
          colorText: kWhite,
          backgroundColor: kDark,
          icon: const Icon(Ionicons.fast_food_outline)
        );

        Get.offAllNamed(AppRoutes.onMainNavBarPage);

      } else {
        throw apiErrorFromJson(response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<AddressResponseModel>?> fetchAllAddresses() async {
    try {
      var response = await _apiClient.getRequest(AppUrl.addressListApi);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return addressResponseModelFromJson(response.body);
      } else {
        throw apiErrorFromJson(response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<void> setDefaultAddress(String addressId,) async {
    try {
      var response = await _apiClient.patchRequest('${AppUrl.setDefaultAddressApi}$addressId');

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {

        Get.snackbar(
          "Address set as default", "Order Food! ",
          colorText: kWhite,
          backgroundColor: kDark,
          icon: const Icon(Ionicons.fast_food_outline)
        );

        Get.offAllNamed(AppRoutes.onMainNavBarPage);
      } else {
        throw apiErrorFromJson(response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<AddressResponseModel?> fetchDefaultAddress() async {
    try {
      var response = await _apiClient.getRequest(AppUrl.fetchDefaultAddressApi);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        box.write("defaultAddress", true);
        return AddressResponseModel.fromJson(data);
      } else {
        box.write("defaultAddress", false);
        throw apiErrorFromJson(response.body);
      }
    } catch (e) {
      box.write("defaultAddress", false);
      throw Exception(e.toString());
    }
  }
}
