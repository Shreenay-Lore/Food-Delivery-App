import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/bottom_sheets/address_bottom_sheet.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/common/bottom_sheets/phone_verification_bottom_sheet.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/pages/auth/controller/login_controller.dart';
import 'package:food_delivery_app/models/addresses_response_model.dart';
import 'package:food_delivery_app/models/cart_response_model.dart';
import 'package:food_delivery_app/models/login_response.dart';
import 'package:food_delivery_app/pages/auth/login_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartBottomNavBar extends StatelessWidget {
  final double grandTotalPrice;
  final List<CartResponseModel> cartItems;
  final AddressResponseModel? address;
  final Future<void> Function(double, List<CartResponseModel>, AddressResponseModel?) initPaymentSheet;

  const CartBottomNavBar({
    super.key,
    required this.grandTotalPrice,
    required this.cartItems,
    required this.address,
    required this.initPaymentSheet,
  });

  @override
  Widget build(BuildContext context) {
    final box = GetStorage(); 
    final LoginController loginController = Get.put(LoginController());
    var addressTrigger = box.read("defaultAddress");
    LoginResponse? user;
    user = loginController.getUserInfo();

    return BottomAppBar(
      padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 10.h),
      color: kWhite,
      surfaceTintColor: kWhite,
      elevation: 6,
      child: GestureDetector(
        onTap: () async {
          if(user == null){
            Get.to(()=> const LoginPage());
          }
          else if(user.phoneVerification == false){
            showVerificationSheet(context);
          }
          else if(addressTrigger == false){
            showAddressSheet(context);
          }else{
            await initPaymentSheet(grandTotalPrice, cartItems, address);
          }
          
        },
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "To Pay",
                  style: appStyle(11, kDark, FontWeight.w500),
                ),
                CustomText(
                  text: '₹ ${grandTotalPrice.toStringAsFixed(2)}',
                  style: appStyle(16, kDark, FontWeight.w700),
                ),
              ],
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Container(
                height: 45.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 10, 10, 10),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "Place Order",
                        style: appStyle(15, kWhite, FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
