import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/pages/orders/controller/orders_controller.dart';
import 'package:food_delivery_app/routes/names.dart';
import 'package:get/get.dart';

class PaymentFailed extends StatelessWidget {
  const PaymentFailed({super.key});

  @override
  Widget build(BuildContext context) {
    final OrdersController orderController = Get.put(OrdersController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            orderController.setPaymentUrl = '';
            Get.offAllNamed(AppRoutes.onMainNavBarPage);
          },
          child: const Icon(
            AntDesign.closecircleo,
            color: kDark,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/No.png',
            color: kRed,
          ),
          CustomText(text: "Payment Failed", style: appStyle(28, kDark, FontWeight.bold)),
        ],
      ),
    );

  }
}