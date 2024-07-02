// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class UserLocationController extends GetxController{

  // var address = ''.obs;

  // void updateAddress(String newAddress) {
  //   address.value = newAddress;
  // }

  RxBool _isDefault  = false.obs;

  bool get isDefault => _isDefault.value;

  set setIsDefault(bool value){
    _isDefault.value = value;
  }

  RxInt _tabIndex  = 0.obs;

  int get tabIndex => _tabIndex.value;

  set setTabIndex(int value){
    _tabIndex.value = value;
  }

  LatLng position = const LatLng(0, 0);

  void setPosition(LatLng value){
    value = position;
    update();
  }
  
  RxString _address  = ''.obs;

  String get address => _address.value;

  set setAddress(String value){
    _address.value = value;
  }

  RxString _postalCode  = ''.obs;

  String get postalCode => _postalCode.value;

  set setPostalCode(String value){
    _postalCode.value = value;
  }

  void getUserAddress(LatLng position) async {
    Uri url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$googleApiKey');
    

    print('Making request to: $url');

    final response = await http.get(url);
      
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    
    if(response.statusCode == 200){
      final responseBody = jsonDecode(response.body);

      final address = responseBody['results'][0]['formatted_address'];
      setAddress = address;

      final addressComponents = responseBody['results'][0]['address_components'];

      for(var component in addressComponents){
        if(component['types'].contains('postal_code')){
          setPostalCode = component['long_name'];
          break;
        }
      }
      
    }

  }
  

}