import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/common/heading.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/models/restaurants_model.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key, required this.restaurant});

  final RestaurantsModel? restaurant;

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: kOffWhite,
        elevation: 0,
        centerTitle: true,
        title: CustomText(text: "Restaurant",
        style: appStyle(12, kGray, FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Heading(text: widget.restaurant!.title, more: false,),
          
        ]
      ),
    );
  }
}