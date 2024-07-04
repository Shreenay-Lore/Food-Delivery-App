import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/common/custom_buttom.dart';
import 'package:food_delivery_app/common/custom_container.dart';
import 'package:food_delivery_app/controller/login_controller.dart';
import 'package:food_delivery_app/models/login_response.dart';
import 'package:food_delivery_app/views/auth/login_redirect.dart';
import 'package:food_delivery_app/views/auth/verification_page.dart';
import 'package:food_delivery_app/views/profile/addresses_page.dart';
import 'package:food_delivery_app/views/profile/widget/profile_appbar.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/views/profile/widget/profile_tile_widget.dart';
import 'package:food_delivery_app/views/profile/widget/user_info_widget.dart';
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

    // print("Email Verification is ${user!.verification}");
    // print("Phone Verification is ${user.phoneVerification}");

    if(user != null &&  user.verification == false){
      return const VerificationPage();
    }
    
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.h),
        child: const ProfileAppBar(),
      ),
      body: SafeArea(
        child: CustomContainer(
          containerContent: Column(
            children: [
              UserInfoWidget(user: user,),
              SizedBox(height: 10.h,),
              Container(
                height: 175.h,
                color: kWhite,
                child: ListView(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ProfileTileWidget(
                      onTap: (){
                        Get.to(()=> const LoginRedirectPage());
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
              ),
              
              SizedBox(height: 10.h,),
              
              Container(
                height: 175.h,
                color: kWhite,
                child: ListView(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ProfileTileWidget(
                      onTap: (){
                        Get.to(()=> const AddressesPage(),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 900),);
                      },
                      title: "Shipping Address",
                      icon: SimpleLineIcons.location_pin,
                    ),
                    ProfileTileWidget(
                      onTap: (){},
                      title: "Service Center",
                      icon: AntDesign.customerservice, 
                    ),
                    ProfileTileWidget(
                      onTap: (){},
                      title: "App Feedback",
                      icon: MaterialIcons.rss_feed,
                    ),
                    ProfileTileWidget(
                      onTap: (){},
                      title: "Settings",
                      icon: AntDesign.setting,
                    ),
                  ]
                ),
              ),

              SizedBox(height: 60.h,),
              
              CustomButton(
                onTap: (){
                  controller.logout();
                },
                borderRadius: 4.r,
                text: "L O G O U T",
                backgroundColor: kRed,
                borderColor: kRed,
                textColor: kWhite,
              ),

            ],
          ),
        ),
      ),
    );
  }
}