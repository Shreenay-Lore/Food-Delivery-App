import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/back_ground_container.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/views/orders/widgets/orders/cancelled.dart';
import 'package:food_delivery_app/views/orders/widgets/orders/delivered.dart';
import 'package:food_delivery_app/views/orders/widgets/orders/delivering.dart';
import 'package:food_delivery_app/views/orders/widgets/orders/pending.dart';
import 'package:food_delivery_app/views/orders/widgets/orders/preparing.dart';
import 'package:food_delivery_app/views/orders/widgets/orders_tabs.dart';

class UserOrders extends StatefulWidget {
  const UserOrders({super.key});

  @override
  State<UserOrders> createState() => _UserOrdersState();
}

class _UserOrdersState extends State<UserOrders> with TickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: orderList.length, 
    vsync: this,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOffWhite,
      appBar: AppBar(
        backgroundColor: kOffWhite,
        centerTitle: true,
        title: CustomText(
          text: "My Orders", 
          style: appStyle(14, kPrimary, FontWeight.w600),
        ),
      ),
      body: BackGroundContainer(
        child: Column(
          children: [
            SizedBox(height: 10.h,),
            OrdersTabs(tabController: _tabController),
            SizedBox(height: 10.h,),
            SizedBox(
              height: height * 0.7,
              width: width,
              child: TabBarView(
                controller: _tabController,
                children: const [
                  PendingOrders(),
                  PreparingOrders(),
                  DeliveringOrders(),
                  DeliveredOrders(),
                  CancelledOrders(),
                ]
              ),
            )
          ],
        )
      ),
    );
  }
}


