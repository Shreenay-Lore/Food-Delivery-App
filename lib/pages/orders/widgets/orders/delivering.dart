import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:food_delivery_app/common/shimmers/foodlist_shimmer.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/hooks/fetch_orders.dart';
import 'package:food_delivery_app/models/client_orders.dart';
import 'package:food_delivery_app/pages/orders/widgets/client_order_tile.dart';

class DeliveringOrders extends HookWidget {
  const DeliveringOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchOrders("Out_for_Delivery","Completed");
    List<ClientOrdersModel> orders = hookResult.data;
    final isLoading = hookResult.isLoading;

    if(isLoading){
      return const FoodsListShimmer();
    }
    
    return SizedBox(
      height: height,
      child: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return ClientOrderTile(food: orders[index].orderItems[0],);
        },
      ),
    );
  }
}