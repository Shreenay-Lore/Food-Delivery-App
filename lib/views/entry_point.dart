import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/controller/cart_controller.dart';
import 'package:food_delivery_app/controller/tab_index_controller.dart';
import 'package:food_delivery_app/hooks/fetch_default_address.dart';
import 'package:food_delivery_app/views/cart/cart_page.dart';
import 'package:food_delivery_app/views/home/home_page.dart';
import 'package:food_delivery_app/views/profile/profile_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// ignore: must_be_immutable
class MainScreen extends HookWidget {
  MainScreen({super.key});

  List<Widget> pageList = const [
    HomePage(),
    Placeholder(),
    ProfilePage(),
  ];
 
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    String? accessToken = box.read('token');

    if (accessToken != null){
      useFetchDefaultAddress(context);
    }
    
    final controller = Get.put(TabIndexController());

    // final hookResult = useFetchCartItemsCount();
    // CartCountResponseModel cartItemsCount = hookResult.data;
    // String currentCount = jsonEncode(cartItemsCount.count);
    final CartController cartController = Get.put(CartController());

    
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
                            () => cartController.count == ''
                                ? controller.tabIndex == 1
                                    ? const Icon(Ionicons.cart, size: 29)
                                    : const Icon(Ionicons.cart_outline, size: 29)
                                : Badge(
                                    label: Text(cartController.count),
                                    child: controller.tabIndex == 1
                                        ? const Icon(Ionicons.cart, size: 29)
                                        : const Icon(Ionicons.cart_outline, size: 29),
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