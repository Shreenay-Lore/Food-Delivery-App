import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/pages/cart/controller/cart_controller.dart';
import 'package:food_delivery_app/pages/main_screen/controller/main_screen_controller.dart';
import 'package:food_delivery_app/pages/cart/cart_page.dart';
import 'package:food_delivery_app/pages/home/home_page.dart';
import 'package:food_delivery_app/pages/profile/profile_page.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MainScreen extends GetView<MainScreenController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());

    List<Widget> pageList = const [
      HomePage(),
      Placeholder(),
      ProfilePage(),
    ];
    
    return Obx(() {
      return Scaffold(
        body: Stack(
          children: [
            pageList[controller.tabIndex],
            Padding(
              padding: EdgeInsets.all(11.h),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Theme(
                    data: Theme.of(context).copyWith(canvasColor: kDark.withOpacity(0.95)),
                    child: BottomNavigationBar(
                      elevation: 20,
                      type: BottomNavigationBarType.fixed,
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      selectedIconTheme: const IconThemeData(color: kWhite),
                      unselectedIconTheme: const IconThemeData(color: kGray),
                      onTap: (value) {
                        if (value == 1) {
                          Get.to(() => const CartPage());
                        } else {
                          controller.setTabIndex = value;
                        }
                      },
                      currentIndex: controller.tabIndex,
                      items: [
                        BottomNavigationBarItem(
                          icon: controller.tabIndex ==0 
                          ? const Icon(Ionicons.fast_food)
                          : const Icon(Ionicons.fast_food_outline),
                          label : "Home"
                        ),

                        BottomNavigationBarItem(
                          icon: Obx(
                            () => Badge(
                                label: cartController.count == ''  
                                  ? Text(controller.cartCurrentCount.toString())
                                  : Text(cartController.count),
                                child: const Icon(Ionicons.cart_outline, size: 29),
                              ),
                          ),
                          label: "Cart",
                        ),
                                
                        const BottomNavigationBarItem(
                          icon: Icon(AntDesign.user), 
                          label : "Profile"
                        ),
                      ]
                    )
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  
    },);
  }
}