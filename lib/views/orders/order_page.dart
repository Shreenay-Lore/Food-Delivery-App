import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/back_ground_container.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/models/foods_model.dart';
import 'package:food_delivery_app/models/order_request_model.dart';
import 'package:food_delivery_app/models/restaurants_model.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key, this.restaurant, required this.food, required this.item});

  final RestaurantsModel? restaurant;
  final FoodsModel food;
  final OrderItem item;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOffWhite,
      appBar: AppBar(
        backgroundColor: kOffWhite,
        centerTitle: true,
        title: CustomText(text: "Complete Ording", style: appStyle(14, kGray, FontWeight.w600)),
      ),
      body: BackGroundContainer(
        child: Container()
      ),
    );
  }
}