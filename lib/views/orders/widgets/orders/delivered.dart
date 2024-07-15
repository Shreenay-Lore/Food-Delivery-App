import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:food_delivery_app/common/shimmers/foodlist_shimmer.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/hooks/fetch_orders.dart';
import 'package:food_delivery_app/models/client_orders.dart';
import 'package:food_delivery_app/views/orders/widgets/client_order_tile.dart';

class DeliveredOrders extends HookWidget {
  const DeliveredOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchOrders("Delivered","Completed");
    List<ClientOrdersModel>? orders = hookResult.data;
    final isLoading = hookResult.isLoading;
    
    return isLoading
      ? const FoodsListShimmer()         
      : SizedBox(
        height: height * 0.8,
        child: ListView.builder(
          itemCount: orders!.length,
          itemBuilder: (context, index) {
            return ClientOrderTile(food: orders[index].orderItems[0],);
          },
        ),
      );
  }
}