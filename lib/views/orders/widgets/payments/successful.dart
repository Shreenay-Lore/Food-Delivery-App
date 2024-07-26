import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/controller/orders_controller.dart';
import 'package:food_delivery_app/views/entry_point.dart';
import 'package:get/get.dart';

class PaymentSuccessful extends StatelessWidget {
  const PaymentSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    final OrdersController orderController = Get.put(OrdersController());
    Timer(const Duration(seconds: 3), () { 
      orderController.setIcon = true;
    });
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
            child: GestureDetector(
              onTap: () {
                orderController.setPaymentUrl = '';
                Get.offAll(()=> MainScreen());
              },
              child: const Icon(
                AntDesign.closecircleo,
                color: kGrayLight,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/restaurant_bk.png"),
              fit: BoxFit.cover
          ),
        ),
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: height * 0.3.h,
                width: width - 40,
                decoration: BoxDecoration(
                  color: kOffWhite,
                  borderRadius: BorderRadius.all(Radius.circular(20.r)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.h,),
                      CustomText(text: "Payment Successful", style: appStyle(13, kGray, FontWeight.normal)),
                      const Divider(
                        thickness: 0.2,
                        color: kGray,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Table(
                          children: [
                            TableRow(
                              children: [
                                CustomText(text: "Order ID", style: appStyle(11, kGray, FontWeight.normal)),
                                CustomText(text: "#${orderController.orderId}", style: appStyle(11, kGray, FontWeight.normal)),
                              ]
                            ),
                            TableRow(
                              children: [
                                CustomText(text: "Payment ID", style: appStyle(11, kGray, FontWeight.normal)),
                                CustomText(text: "#998113543", style: appStyle(11, kGray, FontWeight.normal)),
                              ]
                            ),
                            TableRow(
                              children: [
                                CustomText(text: "Payment Method", style: appStyle(11, kGray, FontWeight.normal)),
                                CustomText(text: "Stripe", style: appStyle(11, kGray, FontWeight.normal)),
                              ]
                            ),
                            TableRow(
                              children: [
                                CustomText(text: "Amount", style: appStyle(11, kGray, FontWeight.normal)),
                                CustomText(
                                  text: "₹ ${orderController.order!.grandTotal.toStringAsFixed(2)}", 
                                  style: appStyle(11, kGray, FontWeight.normal)
                                ),
                              ]
                            ),
                            TableRow(
                              children: [
                                CustomText(text: "Order Status", style: appStyle(11, kGray, FontWeight.normal)),
                                CustomText(
                                  text: orderController.order!.orderStatus, 
                                  style: appStyle(11, kGray, FontWeight.normal)
                                ),
                              ]
                            ),
                            TableRow(
                              children: [
                                CustomText(text: "Order Date", style: appStyle(11, kGray, FontWeight.normal)),
                                CustomText(
                                  text: DateTime.now().toString().substring(0, 10), 
                                  style: appStyle(11, kGray, FontWeight.normal)
                                ),
                              ]
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),

              const Positioned(
                top: -20,
                left: 0,
                right: 0,
                child: Icon(
                  size: 35,
                  AntDesign.checkcircle,
                  color: kPrimary,
                ),
              ),

              Positioned(
                top: 52,
                left: 0,
                child: Container(
                  height: 10.h,
                  width: 10.w,
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r)
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 52,
                right: 0,
                child: Container(
                  height: 10.h,
                  width: 10.w,
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      bottomLeft: Radius.circular(20.r)
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );

  }
}