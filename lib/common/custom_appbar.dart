import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/controller/user_location_controller.dart';
import 'package:food_delivery_app/views/profile/profile_page.dart';
import 'package:food_delivery_app/views/profile/shipping_address.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomAppBar extends StatefulHookWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final UserLocationController controller = Get.put(UserLocationController());

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    // final box = GetStorage();
    // String? accessToken = box.read('token');

    // if (accessToken != null){
    //   useFetchDefaultAddress(context);
    // }
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      width: width,
      height: 100.h,
      color: kWhite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8.5.h,),
                  child: Icon(Ionicons.md_location, size: 28.h),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 4.h, left: 6.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(()=> const ShippingAddress());
                        },
                        child: CustomText(
                          text: "Deliver to",
                          style: appStyle(14, kDark, FontWeight.w700),
                        ),
                      ),
                      Obx(
                        () => SizedBox(
                          width: width * 0.65,
                          child: Text(
                            controller.address1 == ""
                            ? controller.address == ""
                              ? "Select Location" //Please enable location services to get your address"
                              : controller.address
                            : controller.address1,
                            style: appStyle(11, kGray, FontWeight.normal,),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            
              ],
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 4.h,),
              child: GestureDetector(
                onTap: () {
                  Get.to(()=> const ProfilePage());
                },
                child: CircleAvatar(
                  radius: 18.r,
                  backgroundColor: kSecondary,
                  backgroundImage: const NetworkImage("https://as2.ftcdn.net/v2/jpg/03/49/49/79/1000_F_349497933_Ly4im8BDmHLaLzgyKg2f2yZOvJjBtlw5.jpg"),
                ),
              ),
            ),
            
            // Text(
            //   getTimeOfDay(),
            //   style: const TextStyle(fontSize: 32),
            // ),
          ],
        ),

    );
  }

  // String getTimeOfDay(){
  //   DateTime now = DateTime.now();
  //   int hour = now.hour;

  //   if(hour>=0 && hour<12){
  //     return " ☀️ ";
  //   }else if(hour>=12 && hour<16){
  //     return " ⛅ ";
  //   }else{
  //     return " 🌙 ";
  //   } 
  // }
  
  ///Get Current Location Function...
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the 
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale 
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately. 
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 

    _getCurrentLocation();
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    LatLng currentLocation = LatLng(position.latitude, position.longitude);
    
    print(currentLocation);
    controller.setPosition(currentLocation);

    controller.getUserAddress(currentLocation);
    //_getAddressFromLatLng(currentLocation);
  } 

  // Future<void> _getAddressFromLatLng(LatLng position) async {
  //   try {
  //     List<Placemark> placemarks =
  //         await placemarkFromCoordinates(position.latitude, position.longitude);
  //     Placemark place = placemarks[0];
  //     String address = "${place.name}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.administrativeArea}, ${place.country}";
      
  //     controller.updateAddress(address);
  //   } catch (e) {
  //       debugPrint(e.toString());
  //   }
  // }
}