// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/models/restaurants_model.dart';
import 'package:food_delivery_app/pages/restaurant/widget/explore_foods_widget.dart';
import 'package:food_delivery_app/pages/restaurant/widget/restaurant_top_info_card.dart';
import 'package:food_delivery_app/pages/restaurant/widget/restaurant_menu_widget.dart';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({super.key, required this.restaurant});

  final RestaurantsModel? restaurant;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: kWhite,
        body: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            RestaurantTopInfoCard(widget: this,),

            tabBarButtons(),
          
            SizedBox(
              height: height,
              child: TabBarView(
                children: [
                  RestaurantMenuWidget(restaurantId: restaurant!.id,),
                  ExploreWidget(code: restaurant!.code,),
                ]
              ),
            ),
          ],
        )
      ),
    );
  }

  Widget tabBarButtons(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
      child: Container(
        decoration: BoxDecoration(
          color: kOffWhite,
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: SizedBox(
          height: 25.h,
          child: TabBar(
            indicator: BoxDecoration(
              color: kDark,
              borderRadius: BorderRadius.circular(25.r),
            ),
            labelPadding: EdgeInsets.zero,
            labelColor: kLightWhite,
            labelStyle:  appStyle(11, kLightWhite, FontWeight.normal),
            unselectedLabelColor: kGray,
            dividerColor: Colors.transparent,
            tabs: [
              Tab(
                child: SizedBox(
                  height: 25.h,
                  child: const Center(child: Text("Menu")),
                ),
              ),
              Tab(
                child: SizedBox(
                  height: 25.h,
                  child: const Center(child: Text("Explore")),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
