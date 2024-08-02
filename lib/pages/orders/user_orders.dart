import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/common_appbar.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/pages/orders/widgets/orders/cancelled.dart';
import 'package:food_delivery_app/pages/orders/widgets/orders/delivered.dart';
import 'package:food_delivery_app/pages/orders/widgets/orders/delivering.dart';
import 'package:food_delivery_app/pages/orders/widgets/orders/pending.dart';
import 'package:food_delivery_app/pages/orders/widgets/orders/preparing.dart';
import 'package:food_delivery_app/pages/orders/widgets/orders_tabs.dart';

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: const CommonAppBar(
          title: "My Orders",
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 15.h,),
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
      ),
    );
  }
}


