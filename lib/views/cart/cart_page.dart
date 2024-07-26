import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/common/app_style.dart';
import 'package:food_delivery_app/common/cart_count_container.dart';
import 'package:food_delivery_app/common/custom_text.dart';
import 'package:food_delivery_app/common/shimmers/foodlist_shimmer.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/controller/login_controller.dart';
import 'package:food_delivery_app/controller/orders_controller.dart';
import 'package:food_delivery_app/hooks/fetch_cart_items.dart';
import 'package:food_delivery_app/hooks/fetch_default_address.dart';
import 'package:food_delivery_app/models/addresses_response_model.dart';
import 'package:food_delivery_app/models/cart_response_model.dart';
import 'package:food_delivery_app/models/login_response.dart';
import 'package:food_delivery_app/models/order_request_model.dart';
import 'package:food_delivery_app/views/auth/login_redirect.dart';
import 'package:food_delivery_app/views/auth/verification_page.dart';
import 'package:food_delivery_app/views/cart/widget/cart_bottom_nav_bar.dart';
import 'package:food_delivery_app/views/cart/widget/cart_tile.dart';
import 'package:food_delivery_app/views/orders/payment.dart';
import 'package:food_delivery_app/views/restaurant/widget/row_text.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartPage extends HookWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final hookResult = useFetchCartItems();
    List<CartResponseModel> cartItems = hookResult.data ?? [];
    final isLoading = hookResult.isLoading;
    final refetch = hookResult.refetch;
    
    final data = useFetchDefaultAddress(context);
    AddressResponseModel? address = data.data;

    LoginResponse? user;

    final LoginController controller = Get.put(LoginController());

    String? token = box.read("token");

    if(token != null){
      user = controller.getUserInfo();
    }

    if(token == null){
      return const LoginRedirectPage();
    }

    if(user != null &&  user.verification == false){
      return const VerificationPage();
    }

    // Calculate total price of all items in the list
    double itemTotalPrice = cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
    double deliveryFee = 50;
    double taxes = 35.40;
    double grandTotalPrice = itemTotalPrice + deliveryFee + taxes;


    return Scaffold(
      backgroundColor: kOffWhite,
      appBar: AppBar(
        surfaceTintColor: kOffWhite,
        backgroundColor: kOffWhite,
        centerTitle: true,
        title: CustomText(text: "CART", style: appStyle(14, kDark, FontWeight.w600)),
        actions: const [
          CartCountContainer()
        ],
      ),
      bottomNavigationBar: cartItems.isEmpty
        ? const SizedBox()
        : CartBottomNavBar(
            grandTotalPrice: grandTotalPrice,
            cartItems: cartItems,
            address: address,
            initPaymentSheet: initPaymentSheet,
          ),
        body: SafeArea(
          child: isLoading
            ? const FoodsListShimmer()         
            : ListView(
              children: [
                SizedBox(height: 20.h), 

                ...cartItems.map((cartItem) {
                  return CartTile(
                    color: kWhite,
                    cartItem: cartItem,
                    refetch: refetch,
                  );
                }).toList(),

                SizedBox(height: 20.h), 
                cartItems.isEmpty
                ? const SizedBox()
                : Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Bill Summary", 
                        style: appStyle(16, kDark, FontWeight.bold)
                      ),
                      SizedBox(height: 10.h,),
                      RowText(
                        firstText: "Item Total", 
                        secondText:'₹ ${itemTotalPrice.toStringAsFixed(2)}'
                      ),
                      SizedBox(height: 5.h,),
                      const RowText(
                        firstText: "Govt. taxes and restaurant charges", 
                        secondText: '₹ 35.40'
                      ),
                      SizedBox(height: 5.h,),
                      const RowText(
                        firstText: "Delivery Fee", 
                        secondText: '₹ 50'
                      ),
                      SizedBox(height: 14.h,),                     
                      RowText(
                        firstText: "Grand Total", 
                        firstFontSize: 12,
                        firstFontWeight: FontWeight.w600,
                        firstTextColor: kDark,
                        secondText: '₹ ${grandTotalPrice.toStringAsFixed(2)}',
                        secondFontSize: 12,
                        secondFontWeight: FontWeight.w600,
                        secondTextColor: kDark,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 50.h),
              ],
            ),
        ),
    );
  }

  Future<void> initPaymentSheet(double totalPrice, List<CartResponseModel> cartItems, AddressResponseModel? address) async {
    try {
      int amountInPaise = (totalPrice * 100).round();
      
      // 1. create payment intent on the client side by calling stripe api
      final data = await createPaymentIntent(
        amount: amountInPaise.toString(),
        currency: "INR",
        name: "User Name",
        address: address!.addressLine1,
        pin: address.postalCode,
        city: address.addressLine1,
        state: address.addressLine1, 
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
          style: ThemeMode.dark,
        ),
      );
      
      displayPaymentSheet(totalPrice, cartItems, address);

    } catch (e, s) {
      print('Payment exception:$e$s');
      Get.snackbar(
        "Payment Exception Error", e.toString()
      );
      rethrow;
    }
  }

  displayPaymentSheet(double totalPrice, List<CartResponseModel> cartItems, AddressResponseModel? address) async {
    try {
      await Stripe.instance.presentPaymentSheet();
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

      // Call the createOrder method after successful payment
      final OrdersController ordersController = Get.put(OrdersController());
      List<OrderItem> orderItems = cartItems.map((cartItem) {
        return OrderItem(
          foodId: cartItem.productId.id,
          quantity: cartItem.quantity,
          price: cartItem.totalPrice,
          additives: cartItem.additives,
          instructions: "",
        );
      }).toList();

      OrderRequestModel order = OrderRequestModel(
        orderStatus: 'Out_for_Delivery',
        paymentMethod: 'Stripe',
        paymentStatus: 'Completed',
        userId: address!.userId,
        orderItems: orderItems,
        orderTotal: totalPrice - 85.40,
        deliveryFee: 50,
        grandTotal: totalPrice,
        deliveryAddress: address.id,
        restaurantAddress: "670 Post St, San Francisco, CA 94109, United States",
        restaurantId: "665dff25a1e02e570bf7fac9",
        restaurantCoords: [
          37.78792117665919,
          -122.41325651079953,
        ],
        recipientCoords: [address.latitude, address.longitude],
      );

      String orderData = orderRequestModelToJson(order);
      ordersController.createOrder(orderData, order);

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
