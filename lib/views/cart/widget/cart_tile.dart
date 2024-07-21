import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/controller/cart_controller.dart';
import 'package:food_delivery_app/controller/foods_controller.dart';
import 'package:food_delivery_app/models/cart_request_model.dart';
import 'package:food_delivery_app/models/cart_response_model.dart';
import 'package:get/get.dart';


class CartTile extends StatelessWidget {
  const CartTile({super.key, required this.cartItem, this.color, this.refetch});

  final CartResponseModel cartItem;
  final Color? color;
  final Function()? refetch;

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    final FoodController foodController = Get.put(FoodController());

    return GestureDetector(
      onTap: () {
        //Get.to(()=> FoodPage(food: food));
      },
      child: Padding(
        padding: EdgeInsets.only(left: 8.h, right: 8.h),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 8.h,),
              height: 70.h,
              width: width,
              decoration: BoxDecoration(
                color: color ?? kOffWhite,
                borderRadius: BorderRadius.circular(9.r),
              ),
              child: Container(
                padding: EdgeInsets.all(4.r),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(9.r)),
                      child: SizedBox(
                        height: 70.h,
                        width: 70.w,
                        child: Image.network(
                          cartItem.productId.imageUrl[0], 
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  
                    SizedBox(width: 10.w,),
        
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: cartItem.productId.title, 
                          style: appStyle(11, kDark, FontWeight.w400)
                        ),

                        CustomText(
                          text: '₹ ${cartItem.totalPrice.toStringAsFixed(2)}', 
                          style: appStyle(12, kDark, FontWeight.w600)
                        ),
          
                        SizedBox(
                          width: width*0.7,
                          height: 15.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: cartItem.additives.length,
                            itemBuilder: (context, index) {
                              var additive = cartItem.additives[index];
                              return Container(
                                margin: EdgeInsets.only(right: 5.w),
                                decoration: BoxDecoration(
                                  color: kOffWhite,
                                  borderRadius: BorderRadius.all(Radius.circular(2.r))
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                    child: CustomText(
                                      text: additive, 
                                      style: appStyle(8, kGray, FontWeight.w400)
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        

                      ],
                    )
                  ],
                ),
              ),
            ),

            Positioned(
              right: 10.w,
              top: 6.h,
              child: Container(
                height: 30.h,
                width: 70.w,
                decoration: BoxDecoration(
                  color: kDark,
                  border: Border.all(color: kWhite, width: 0.6),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(6.0.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if(cartItem.quantity > 1){
                            return cartController.decrementProductQtyCart(cartItem.id, refetch!);
                          }else{
                            return cartController.removeFromCart(cartItem.id, refetch!);
                          }
                        },
                        child: const Icon(AntDesign.minus, color: kWhite, size: 18),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: CustomText(
                          text: cartItem.quantity.toString(),
                          style: appStyle(12, kWhite, FontWeight.w600)
                        ),
                      ),
                      GestureDetector(
                         onTap: () {
                          CartRequestModel data = CartRequestModel(
                            productId: cartItem.productId.id, 
                            quantity: cartItem.quantity,
                            additives: cartItem.additives,
                            totalPrice: cartItem.totalPrice, 
                          );
                
                          String cartItemJson = cartRequestModelToJson(data);
                
                          cartController.addToCart(cartItemJson); 

                        },
                        child: const Icon(AntDesign.plus, color: kWhite, size: 18),
                      ),
                    ],
                  ),
                ),
              )
            ),
          ]
        ),
      ),
    );
  }
}