// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/models/restaurants_model.dart';
import 'package:food_delivery_app/views/restaurant/widget/explore_foods_widget.dart';
import 'package:food_delivery_app/views/restaurant/widget/restaurant_top_info_card.dart';
import 'package:food_delivery_app/views/restaurant/widget/restaurant_menu_widget.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key, required this.restaurant});

  final RestaurantsModel? restaurant;

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> with TickerProviderStateMixin{
  
  late TabController _tabController = TabController(
    length: 2, 
    vsync: this
  );

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
            RestaurantTopInfoCard(widget: widget,),

            ///Tab Bar Buttons...
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
              child: Container(
                decoration: BoxDecoration(
                  color: kOffWhite,
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: SizedBox(
                  height: 25.h,
                  width: width,
                  child: TabBar(
                    controller: _tabController,
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
                          width: width/2,
                          child: const Center(child: Text("Menu")),
                        ),
                      ),
                      Tab(
                        child: SizedBox(
                          height: 25.h,
                          width: width/2,
                          child: const Center(child: Text("Explore")),
                        ),
                      ),
                    ]
                  ),
                ),
              ),
            ),
          
            SizedBox(
              height: height,
              child: TabBarView(
                controller: _tabController,
                children: [
                  RestaurantMenuWidget(restaurantId: widget.restaurant!.id,),
            
                  ExploreWidget(code: widget.restaurant!.code,),
            
                ]
              ),
            ),
          
          ],
        )
      ),
    );
  }


}
