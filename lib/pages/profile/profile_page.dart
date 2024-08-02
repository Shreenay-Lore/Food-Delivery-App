import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/pages/auth/controller/login_controller.dart';
import 'package:food_delivery_app/models/login_response.dart';
import 'package:food_delivery_app/pages/auth/login_redirect.dart';
import 'package:food_delivery_app/pages/auth/verification_page.dart';
import 'package:food_delivery_app/common/common_appbar.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/pages/profile/widget/profile_tile_widget.dart';
import 'package:food_delivery_app/pages/profile/widget/user_info_widget.dart';
import 'package:food_delivery_app/routes/names.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginResponse? user;

    final LoginController controller = Get.put(LoginController());

    final box = GetStorage();

    String? token = box.read("token");

    if(token != null){
      user = controller.getUserInfo();
    }

    if(token == null){
      return const LoginRedirectPage();
    }

    if(user != null &&  user.verification == false){
      return const VerificationPage();
    }
    
    return Scaffold(
      backgroundColor: kOffWhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: const CommonAppBar(
          title: "Profile",
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              UserInfoWidget(user: user,),
              listTileContainer(
                children: [
                  ProfileTileWidget(
                    onTap: (){
                      Get.toNamed(AppRoutes.onUserOrdersPage);
                    },
                    title: "My Orders",
                    icon: Ionicons.fast_food_outline,
                  ),
                  ProfileTileWidget(
                    onTap: (){},
                    title: "My Favorite Places",
                    icon: Ionicons.heart_outline,
                  ),
                  ProfileTileWidget(
                    onTap: (){},
                    title: "Reviews",
                    icon: Ionicons.chatbubble_outline,
                  ),
                  ProfileTileWidget(
                    onTap: (){},
                    title: "Coupens",
                    icon: MaterialCommunityIcons.tag_outline,
                  ),
                ]
              ),
                            
              listTileContainer(
                children: [
                  ProfileTileWidget(
                    onTap: (){
                      Get.toNamed(AppRoutes.onAllAddressesPage);
                    },
                    title: "Addresses",
                    icon: SimpleLineIcons.location_pin,
                  ),
                  ProfileTileWidget(
                    onTap: (){},
                    title: "Service Center",
                    icon: AntDesign.customerservice, 
                  ),
                  ProfileTileWidget(
                    onTap: (){
                      printStorageValues();
                    },
                    title: "App Feedback",
                    icon: MaterialIcons.rss_feed,
                  ),
                  ProfileTileWidget(
                    onTap: (){
                      controller.logout();
                    },
                    title: "Log out",
                    icon: MaterialIcons.logout,
                  ),
                ]
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget listTileContainer({required List<Widget> children}){
    return Container(
      height: 175.h,
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(12.r), 
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        children: children
      ),
    );
  }

  void printStorageValues() {
    final box = GetStorage();
    final keys = box.getKeys();

    if (keys.isEmpty) {
      print("Storage is empty.");
    } else {
      for (var key in keys) {
        print('Key: $key, Value: ${box.read(key)}');
      }
    }
  }

}