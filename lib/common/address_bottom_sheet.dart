import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_buttom.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/views/profile/shipping_address.dart';
import 'package:get/get.dart';

Future<dynamic> showAddressSheet(BuildContext context){
    return showModalBottomSheet(
      context: context,
      showDragHandle: true, 
      //backgroundColor: Colors.transparent,
      builder: (context) {
        return SizedBox(
          height: 500.h,
          width: width,
          child: Padding(
            padding: EdgeInsets.all(8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10.h,),
                CustomText(
                  text: "Add Address", 
                  style: appStyle(18, kPrimary, FontWeight.w600)
                ),
                SizedBox(height: 10.h,),
                SizedBox(
                  height: 250.h,
                  child: Column(
                    children: List.generate(
                      reasonsForAddingAddress.length, 
                      (index) => ListTile(
                        leading: const Icon(Icons.check, color: kPrimary,),
                        title: Text(
                          reasonsForAddingAddress[index],
                          textAlign: TextAlign.justify,
                          style: appStyle(11, kGrayLight, FontWeight.normal)
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: CustomButton(  
                    height: 40.h,
                    width: width,
                    backgroundColor: kPrimary,
                    borderColor: kPrimary,
                    textColor: kWhite,
                    text: 'Go to add address',
                    onTap: () {
                      Get.to(()=> const ShippingAddress());
                    },
                  ),
                ),
                SizedBox(height: 5.h,),
              ],
            ),
          ),
        );
      },
    );
  }
