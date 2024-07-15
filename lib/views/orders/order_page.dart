import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/back_ground_container.dart';
import 'package:food_delivery_app/common/custom_buttom.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/controller/orders_controller.dart';
import 'package:food_delivery_app/models/addresses_response_model.dart';
import 'package:food_delivery_app/models/distance_time_model.dart';
import 'package:food_delivery_app/models/foods_model.dart';
import 'package:food_delivery_app/models/order_request_model.dart';
import 'package:food_delivery_app/models/restaurants_model.dart';
import 'package:food_delivery_app/services/distance.dart';
import 'package:food_delivery_app/views/orders/payment.dart';
import 'package:food_delivery_app/views/orders/widgets/order_tile.dart';
import 'package:food_delivery_app/views/restaurant/widget/row_text.dart';
import 'package:get/get.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({
    super.key, 
    this.restaurant, 
    required this.food, 
    required this.item, 
    this.address
  });

  final RestaurantsModel? restaurant;
  final FoodsModel food;
  final OrderItem item;
  final AddressResponseModel? address;

  @override
  Widget build(BuildContext context) {
    // final OrdersController controller = Get.put(OrdersController());
    DistanceTime data = Distance().calculateDistanceTimePrice(
      restaurant!.coords.latitude, 
      restaurant!.coords.longitude, 
      address!.latitude,    
      address!.longitude,   
      10, 
      2,
    );

    double totalPrice = item.price + data.price;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kOffWhite,
      appBar: AppBar(
        backgroundColor: kOffWhite,
        centerTitle: true,
        title: CustomText(text: "Complete Ording", style: appStyle(14, kGray, FontWeight.w600)),
      ),
      body: BackGroundContainer(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            children: [
              SizedBox(height: 10.h,),
          
              OrderTile(food: food),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                width: width,
                height: height/3.6,
                decoration: BoxDecoration(
                  color: kOffWhite,
                  borderRadius: BorderRadius.circular(12.r)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: restaurant!.title, 
                          style: appStyle(20, kGray, FontWeight.bold)
                        ),

                        CircleAvatar(
                          radius: 18.r,
                          backgroundColor: kWhite,
                          backgroundImage: NetworkImage(
                            restaurant!.logoUrl,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    RowText(
                      firstText: "Bussiness Hours", 
                      secondText: restaurant!.time
                    ),
                    SizedBox(height: 5.h,),
                    RowText(
                      firstText: "Distance from Restaurant", 
                      secondText: '${data.distance.toStringAsFixed(2)} Km'
                    ),
                    SizedBox(height: 5.h,),
                    RowText(
                      firstText: "Price from Restaurant", 
                      secondText: '₹ ${data.price.toStringAsFixed(2)}'
                    ),
                    SizedBox(height: 10.h,),
                    RowText(
                      firstText: "Order Total", 
                      secondText: '₹ ${item.price.toString()}'
                    ),
                    SizedBox(height: 5.h,),
                    RowText(
                      firstText: "Grand Total", 
                      secondText: '₹ ${totalPrice.toStringAsFixed(2)}'
                    ),
                    SizedBox(height: 10.h,),

                    CustomText(
                      text: "Additives", 
                      style: appStyle(20, kGray, FontWeight.bold)
                    ),
                    SizedBox(height: 5.h,),
                    SizedBox(
                      width: width,
                      height: 15.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: item.additives.length,
                        itemBuilder: (context, index) {
                          var additive =  item.additives[index];
                          return Container(
                            margin: EdgeInsets.only(right: 5.w),
                            decoration: BoxDecoration(
                              color: kSecondaryLight,
                              borderRadius: BorderRadius.all(Radius.circular(9.h))
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
                ),
              ),

              SizedBox(height: 20.h,),

              CustomButton(
                text: "Proceed to Payment",
                height: 45.h,
                width: width,
                textColor: kWhite,
                borderColor: kPrimary,
                backgroundColor: kPrimary,
                onTap: () async {
                  await initPaymentSheet(totalPrice);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> initPaymentSheet(double totalPrice) async {
    try {
      int amountInPaise = (totalPrice * 100).round();
      
      // 1. create payment intent on the client side by calling stripe api
      final data = await createPaymentIntent(
        //amount: (int.parse("2000")*100).toString(),
        amount: amountInPaise.toString(),
        currency: "INR",
        name: "User Name",
        address: address!.addressLine1,
        pin: address!.postalCode,
        city: address!.addressLine1,
        state: address!.addressLine1, 
        country: "India",
      );

      if (data == null) {
        throw Exception("Payment Intent creation failed");
      }
      // Log the data received from createPaymentIntent
      print("Payment Intent Data: $data");


      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Set to true for custom flow
          customFlow: false,
          // Main params
          merchantDisplayName: 'Test Merchant',
          paymentIntentClientSecret: data['client_secret'],
          // Customer keys
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['id'],   
          //Extra Options
          // googlePay: const PaymentSheetGooglePay(
          //   merchantCountryCode: 'IN',
          //   testEnv: true,
          //   currencyCode: 'INR'
          // ),

          style: ThemeMode.dark,
        ),
      );
      
      displayPaymentSheet(totalPrice);

    } catch (e, s) {
      print('Payment exception:$e$s');
      Get.snackbar(
        "Payment Exception Error", e.toString()
      );
      rethrow;
    }
  }

  displayPaymentSheet(double totalPrice) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      // print('payment intent' + paymentIntentData!['id'].toString());
      // print('payment intent' + paymentIntentData!['client_secret'].toString());
      // print('payment intent' + paymentIntentData!['amount'].toString());
      // print('payment intent' + paymentIntentData.toString());
      print('Payment Successfully');
      Get.snackbar(
        "Payment Successfully", "Your payment for order completed",
        colorText: kWhite,
        backgroundColor: const Color.fromARGB(255, 47, 136, 50),
        icon: Icon(
          Icons.check_circle_outline,
          color: kWhite,
          size: 26.h,
        )
      );
      //paymentIntentData = null;

      // Call the createOrder method after successful payment
      final OrdersController controller = Get.put(OrdersController());
      OrderRequestModel order = OrderRequestModel(
        orderStatus: 'Out_for_Delivery',
        paymentMethod: 'Stripe',
        paymentStatus: 'Completed',
        userId: address!.userId,
        orderItems: [item],
        orderTotal: item.price,
        deliveryFee: 20,
        grandTotal: totalPrice,
        deliveryAddress: address!.id,
        restaurantAddress: restaurant!.coords.address,
        restaurantId: restaurant!.id,
        restaurantCoords: [
          restaurant!.coords.latitude,
          restaurant!.coords.longitude,
        ],
        recipientCoords: [address!.latitude, address!.longitude],
      );

      String orderData = orderRequestModelToJson(order);

      controller.createOrder(orderData, order);

    } catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      Get.snackbar(
        "Payment Failed", "Your payment for order was not completed",
        colorText: kWhite,
        backgroundColor: kRed,
        icon: Icon(
          Ionicons.alert_circle_outline,
          color: kWhite,
          size: 26.h,
        )
      );
    }
  }
}