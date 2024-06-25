// ignore_for_file: prefer_final_fields

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/models/restaurants_model.dart';
import 'package:food_delivery_app/views/restaurant/directions_page.dart';
import 'package:food_delivery_app/views/restaurant/widget/explore_foods_widget.dart';
import 'package:food_delivery_app/views/restaurant/widget/restaurant_bottom_bar.dart';
import 'package:food_delivery_app/views/restaurant/widget/restaurant_menu_widget.dart';
import 'package:food_delivery_app/views/restaurant/widget/row_text.dart';
import 'package:get/get.dart';

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
          padding: EdgeInsets.zero,
          children: [

            Stack(
              children: [
                SizedBox(
                  width: width,
                  height: 230.h,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: widget.restaurant!.imageUrl,
                  ),
                ),
                
                ///Ratings Bar....
                Positioned(
                  bottom: 0.h,
                  child: RestaurantBottomBar(widget: widget),
                ),
                        
                ///Top Bar....
                Positioned(
                  top: 40.h,
                  left: 12.w,
                  right: 12.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///Back Button....
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Ionicons.chevron_back_circle,
                          color: kWhite,
                          size: 30,
                        ),
                      ),
            
                      ///Restaurant Title...
                      CustomText(
                        text: widget.restaurant!.title,
                        style: appStyle(14, kDark, FontWeight.w600),
                      ),
            
                      ///Map Button...
                      GestureDetector(
                        onTap: () {
                          Get.to(()=> const DirectionsPage());
                        },
                        child: const Icon(
                          Ionicons.location,
                          color: kWhite,
                          size: 30,
                        ),
                      ),
            
                    ],
                  ),
                ),      
              ],
            ),

            ///Delivery Details...
            Padding(
              padding: EdgeInsets.only(top: 10.h, left: 8.w, right: 8.w),
              child: Column(
                children: [
                  const RowText(firstText: "Distance to Restaurant", secondText: "2.7 km"),
                  SizedBox(height: 4.h,),
                  const RowText(firstText: "Delivery Price From Current Location", secondText: "\$2.7"),
                  SizedBox(height: 4.h,),
                  const RowText(firstText: "Estimated Delivery Time to Current Location", secondText: "30 min"),
                  SizedBox(height: 6.h,),
                  const Divider(thickness: 0.4,),
                  SizedBox(height: 6.h,),
                ],
              ),
            ),
          
            ///Tab Bar Buttons...
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
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
                      color: kPrimary,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    labelPadding: EdgeInsets.zero,
                    labelColor: kLightWhite,
                    labelStyle:  appStyle(11, kLightWhite, FontWeight.normal),
                    unselectedLabelColor: kGray,
                    dividerColor: kWhite,
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
            SizedBox(height: 20.h,),
          
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: SizedBox(
                height: height,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    RestaurantMenuWidget(restaurantId: widget.restaurant!.id,),

                    ExploreWidget(code: widget.restaurant!.code,),
              
                  ]
                ),
              ),
            ),
          
          ],
        )
      ),
    );
  }


}
