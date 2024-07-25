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
import 'package:food_delivery_app/controller/user_location_controller.dart';
import 'package:food_delivery_app/hooks/fetch_default_address.dart';
import 'package:food_delivery_app/models/address_model.dart';
import 'package:food_delivery_app/models/addresses_response_model.dart';
import 'package:food_delivery_app/views/auth/widget/email_textfield.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class TestLocation extends StatefulHookWidget {
  const TestLocation({super.key});

  @override
  State<TestLocation> createState() => _TestLocationState();
}

class _TestLocationState extends State<TestLocation> {
  late final PageController _pageController = PageController(initialPage: 0);
  GoogleMapController? _mapController;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _postalCode = TextEditingController(text: "444666");
  final TextEditingController _deliveryInstructions = TextEditingController();
  LatLng? _selectedPosition;
  List<dynamic> _placeList = [];
  List<dynamic> _selectedPlace = [];


  @override
  void initState() {
    _pageController.addListener(() {
      setState(() { });
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String searchQuery) async {
    if(searchQuery.isNotEmpty){
      final Uri url = Uri.parse(
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchQuery&key=$googleApiKey'); 
    
      print('Making request to: $url');

      final response = await http.get(url);
        
      print('Response status: ${response.statusCode}');
      //print('Response body: ${response.body}');
      
      if(response.statusCode == 200){
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
          print('Places Status: $_placeList');
        });        
      }

    }else{
      _placeList = [];
    }
  }

  void _getPlaceDetails(String placeId) async {
    final Uri url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$googleApiKey'); 
  
    print('Making request to: $url');

    final response = await http.get(url);
      
    print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    if(response.statusCode == 200){
      final location = json.decode(response.body);   

      final lat = location['result']['geometry']['location']['lat'] as double;  
      final lng = location['result']['geometry']['location']['lng'] as double;  

      final address = location['result']['formatted_address'];  

      String postalCode = "";

      final addressComponents = location['result']['address_components'];  

      for(var component in addressComponents){
        if(component['types'].contains('postal_code')){
          postalCode = component['long_name'];
          break;
        }
      }
      print('ADDRESSS: $address');
      print('POSTAL CODE: $postalCode');

      setState(() {
        _selectedPosition = LatLng(lat, lng);
        _searchController.text = address;
        _postalCode.text = postalCode;
        moveTOSelectedPosition();
        _placeList = [];
      });
    }
    
  }

  void moveTOSelectedPosition() {
    if(_selectedPosition != null && _mapController != null){
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
      appBar: AppBar(
        backgroundColor: kOffWhite,
        centerTitle: true,
        elevation: 0,
        title: CustomText(text: "Shipping Address",
        style: appStyle(14, kGray, FontWeight.w600),
        ),
        leading: Obx(() => Padding(
          padding: EdgeInsets.only(right: 0.w),
          child: locationController.tabIndex == 0
          ? IconButton(
              onPressed: (){
                Get.back();
              }, 
              icon: const Icon(AntDesign.closecircleo, color: kRed,)
            )
          : IconButton(
              onPressed: (){
                locationController.setTabIndex = 0;
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 500), 
                  curve: Curves.easeIn,
                );
              }, 
              icon: const Icon(AntDesign.leftcircleo, color: kDark,)
            ),
          ),
        ),
        actions: [
          Obx(() => locationController.tabIndex == 1
          ? const SizedBox.shrink()
          : Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: IconButton(
                onPressed: (){
                  locationController.setTabIndex = 1;
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 500), 
                    curve: Curves.easeIn,
                  );
                }, 
                icon: const Icon(AntDesign.rightcircleo, color: kDark,)
              ),
          ),
          ),
        ],
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          pageSnapping: false,
          onPageChanged: (index) {
            _pageController.jumpToPage(index);
          },
          children: [
            Stack(
              children: [
                GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target: _selectedPosition ?? const LatLng(18.6108217, 73.7480317),
                    zoom: 15,
                  ),
                  markers: _selectedPosition == null 
                  ? Set.of([
                      Marker(
                        markerId: const MarkerId('Your Location'),
                        position: const LatLng(18.6108217, 73.7480317),
                        draggable: true,
                        onDragEnd: (LatLng position) {
                          locationController.getUserAddress(position);
                          setState(() {
                            _selectedPosition = position;
                          });
                        },
                      ),
                  ])
                  : Set.of([
                      Marker(
                        markerId: const MarkerId('Your Location'),
                        position: _selectedPosition!,
                        draggable: true,
                        onDragEnd: (LatLng position) {
                          locationController.getUserAddress(position);
                          setState(() {
                            _selectedPosition = position;
                          });
                        },
                      )

                  ]),
                ),

                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.h),
                      color: kOffWhite,
                      child: TextField(
                        controller: _searchController,
                        onChanged: _onSearchChanged,
                        decoration: const InputDecoration(
                          hintText: 'Search for your address...'
                        ),
                      ),
                    ),

                    _placeList.isEmpty
                    ? const SizedBox.shrink()
                    : Expanded(
                      child: ListView(
                        children: List.generate(
                          _placeList.length, 
                          (index){
                            return Container(
                              color: kWhite,
                              child: ListTile(
                                visualDensity: VisualDensity.compact,
                                title: Text(
                                  _placeList[index]['description'],
                                  //style: appStyle(14, kGrayLight, FontWeight.w400),
                                ),
                                onTap: () {
                                  _getPlaceDetails(_placeList[index]['place_id']);
                                  _selectedPlace.add(_placeList[index]); 
                                },
                              ),
                            );
                          }
                        ),
                      )
                    ),
                  ],
                )
              ]
            ),

            BackGroundContainer(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: ListView(
                  children: [
                    SizedBox(height: 30.h,),

                    EmailTextField(
                      controller: _searchController,
                      hintText: "Address",
                      prefixIcon: const Icon(Ionicons.location_sharp, size: 22, color: kGrayLight,),
                      keyboardType: TextInputType.text,
                    ),

                    SizedBox(height: 15.h,),

                    EmailTextField(
                      controller: _postalCode,
                      hintText: "Postal Code",
                      prefixIcon: const Icon(Ionicons.location_sharp, size: 22, color: kGrayLight,),
                      keyboardType: TextInputType.number,
                    ),

                    SizedBox(height: 15.h,),

                    EmailTextField(
                      controller: _deliveryInstructions,
                      hintText: "Delivery Instructions",
                      prefixIcon: const Icon(AntDesign.menu_fold, size: 22, color: kGrayLight,),
                      keyboardType: TextInputType.text,
                    ),

                    SizedBox(height: 15.h,),

                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "Set address as default",
                            style: appStyle(12, kDark, FontWeight.w600),
                          ),

                          Obx(() => CupertinoSwitch(
                            thumbColor: kWhite,
                            activeColor: kPrimary,
                            value: locationController.isDefault, 
                            onChanged: (value) {
                              locationController.setIsDefault = value;
                              String data = jsonEncode(defaultAddress);
                              locationController.setAddress1 = data;
                            },
                          ))
                        ],
                      ),
                    ),

                    SizedBox(height: 35.h,), 

                    CustomButton(
                      height: 45.h,
                      backgroundColor: kPrimary,
                      borderColor: kPrimary,
                      textColor: kWhite,
                      text: isLoading ? 'Loading...' : 'S U B M I T',
                      onTap: (){
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
              )
            ),
          ],
        ),
      ),
    );
  }
  
  
}