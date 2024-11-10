import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/pages/address/controllers/user_location_controller.dart';
import 'package:food_delivery_app/pages/profile/profile_page.dart';
import 'package:food_delivery_app/routes/names.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final UserLocationController controller = Get.put(UserLocationController());

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
                          Get.toNamed(AppRoutes.onAddressListPage);
                        },
                        child: CustomText(
                          text: controller.address == ""
                            ? "Deliver to"
                            : controller.saveAddressAsController.text,
                          style: appStyle(14, kDark, FontWeight.w700),
                        ),
                      ),
                      Obx(
                        () => SizedBox(
                          width: width * 0.65,
                          child: Text(
                            controller.address == ""
                            ? "Select Location"
                            : controller.address,
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
                  backgroundColor: kGrayLight,
                  backgroundImage: const NetworkImage("https://as2.ftcdn.net/v2/jpg/03/49/49/79/1000_F_349497933_Ly4im8BDmHLaLzgyKg2f2yZOvJjBtlw5.jpg"),
                ),
              ),
            ),
            
          ],
        ),

    );
  }

}