import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/custom_buttom.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/models/foods_model.dart';
import 'package:food_delivery_app/pages/food/food_page.dart';

class FoodTile extends StatelessWidget {
  const FoodTile({super.key, required this.food, this.color});

  final FoodsModel food;
  final Color? color;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => FoodPageBottomSheet(food: food),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 22.h, left: 10.w, right: 10.w),
        child: Material(
          elevation: 3, 
              borderRadius: BorderRadius.circular(9.r),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Container(
                height: 120.h,
                width: width,
                decoration: BoxDecoration(
                  color: color ?? kOffWhite,
                  borderRadius: BorderRadius.circular(9.r),
                ),
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(9.r)),
                          child: SizedBox(
                            height: 100.h,
                            width: 100.w,
                            child: Image.network(
                              food.imageUrl[0], 
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    
                      SizedBox(width: 10.w,),
          
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: food.title, 
                            style: appStyle(13, kDark, FontWeight.w600)
                          ),

                          SizedBox(
                            width: width*0.6,
                            height: 15.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: food.additives.length,
                              itemBuilder: (context, index) {
                                Additive additive = food.additives[index];
                                return Container(
                                  margin: EdgeInsets.only(right: 5.w),
                                  decoration: BoxDecoration(
                                    color: kWhite,
                                    borderRadius: BorderRadius.all(Radius.circular(4.h))
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                      child: CustomText(
                                        text: additive.title, 
                                        style: appStyle(8, kGray, FontWeight.w400)
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                //padding: EdgeInsets.only(left: 6.w, bottom: 2.h),
                                decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(5.r),
                                  border: Border.all(color: kSecondary, width: 0.4)
                                ),
                                alignment: Alignment.center,
                                height: 16.h,
                                width: 70.w,
                                child: RatingBarIndicator(
                                  rating: 5,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return const Icon(
                                      Icons.star,
                                      color: kSecondary,
                                    );
                                  },
                                  itemSize: 11.h,
                                ),
                              ),
                              SizedBox(width: 6.h,),
                              CustomText(
                                text: "${food.ratingCount} reviews", 
                                style: appStyle(10, kDark, FontWeight.w500)
                              ),
                            ],
                          ),

                          CustomText(
                            text: '₹ ${food.price.toStringAsFixed(2)}',
                            style: appStyle(11, kDark, FontWeight.bold)
                          ),
                          
                        ],
                      )
                    ],
                  ),
                ),
              ),
              
              Positioned(
                right: 16.w,
                bottom: 14.h,
                child: CustomButton(
                  // onTap: () {
                  //   ///Add to Cart Function...
                  //   CartRequestModel data = CartRequestModel(
                  //     productId: food.id,
                  //     quantity: 1,
                  //     additives: [],
                  //     totalPrice: food.price,
                  //   );
          
                  //   String cartItem = cartRequestModelToJson(data);
          
                  //   cartController.addToCart(cartItem);     
                  // },
                  text: "ADD",
                  fontSize: 12,
                  borderRadius: 6.r,
                  height: 30.h,
                  width: 59.w,
                )
              ),
           
            ]
          ),
        ),
      ),
    );
  }
}

