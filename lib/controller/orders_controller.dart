// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/hooks/fetch_cart_items.dart';
import 'package:food_delivery_app/hooks/fetch_default_address.dart';
import 'package:food_delivery_app/models/addresses_response_model.dart';
import 'package:food_delivery_app/models/api_error.dart';
import 'package:food_delivery_app/models/cart_response_model.dart';
import 'package:food_delivery_app/models/order_request_model.dart';
import 'package:food_delivery_app/models/order_response_model.dart';
import 'package:food_delivery_app/views/orders/payment.dart';
import 'package:food_delivery_app/views/orders/widgets/payments/successful.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class OrdersController extends GetxController{ 
  final box = GetStorage(); 
  RxBool _isLoading  = false.obs;

  bool get isLoading => _isLoading.value;

  set setLoading(bool value){
    _isLoading.value = value;
  }

  RxString _paymentUrl  = ''.obs;

  String get paymentUrl => _paymentUrl.value;

  set setPaymentUrl(String value){
    _paymentUrl.value = value;
  }

  String orderId  = '';

  String get getOrderId => orderId;

  set setOrderId(String value){
    orderId = value;
  }

  OrderRequestModel? order;

  RxBool _iconChanger  = false.obs;

  bool get iconChanger => _iconChanger.value;

  set setIcon(bool value){
    _iconChanger.value = value;
  }


  void createOrder(String data, OrderRequestModel item) async {
    order = item;
    final box = GetStorage();
    String accessToken = box.read('token');

    Uri url = Uri.parse('$appBaseUrl/api/orders');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization' : 'Bearer $accessToken',
    };

    try{  
      print('Making request to: $url');

      var response = await http.post(
        url,
        headers: headers,
        body: data,
      );
      
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      if(response.statusCode == 200){
        
        OrderResponseModel data = orderResponseModelFromJson(response.body);
        setOrderId = data.orderId;

        Get.to(() => const PaymentSuccessful());

        // ///Cart Items..
        // PaymentRequestModel payment = PaymentRequestModel(
        //   userId: item.userId,
        //   cartItems: [
        //     CartItem(
        //       name: item.orderItems[0].foodId, 
        //       id: orderId, 
        //       price: item.grandTotal.toStringAsFixed(2), 
        //       quantity: 1, 
        //       restaurantId: item.restaurantId)
        //   ]
        // );

        // ///Payment Function..
        // String paymentData = paymentRequestModelToJson(payment);
        // paymentFunction(paymentData);

      }else{
        var error = apiErrorFromJson(response.body);
        Get.snackbar( 
          "Order Failed ", error.message,
          colorText: kWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.error)
        );

      }

    }catch(e){
      debugPrint(e.toString());
    }
  }

  // void paymentFunction(String payment) async {
  //   ///String payment is the data that we are send to payment server..
  //   setLoading = true;
  //   Uri url = Uri.parse('payment_server_url');
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //   }
  //   try{  
  //     print('Making request to: $url');
  //     var response = await http.post(
  //       url,
  //       headers: headers,
  //       body: payment,
  //     );  
  //     print('Response status: ${response.statusCode}');
  //     print('Response body: ${response.body}');    
  //     if(response.statusCode == 200){
  //       var urlData = jsonDecode(response.body);
  //       setPaymentUrl = urlData['url'];
  //       setLoading = false;
  //     }
  //   }catch(e){
  //     setLoading = false;
  //     debugPrint(e.toString());
  //   }finally{
  //     setLoading = false;
  //   }
  // } 


  // // Fetch cart items
  // Future<List<CartResponseModel>> fetchCartItems() async {
  //   final result = await useFetchCartItems();
  //   return result.data ?? [];
  // }

  // // Fetch default address
  // Future<AddressResponseModel?> fetchDefaultAddress(BuildContext context) async {
  //   final result = await useFetchDefaultAddress(context);
  //   return result.data;
  // }

  // // Initialize payment sheet
  // Future<void> initPaymentSheet(
  //     double totalPrice, List<CartResponseModel> cartItems, AddressResponseModel? address) async {

  //   setLoading = true;
  //   try {
  //     int amountInPaise = (totalPrice * 100).round();

  //     // 1. create payment intent on the client side by calling stripe api
  //     final data = await createPaymentIntent(
  //       amount: amountInPaise.toString(),
  //       currency: "INR",
  //       name: "User Name",
  //       address: address!.addressLine1,
  //       pin: address.postalCode,
  //       city: address.addressLine1,
  //       state: address.addressLine1,
  //       country: "India",
  //     );

  //     if (data == null) {
  //       throw Exception("Payment Intent creation failed");
  //     }

  //     // 2. initialize the payment sheet
  //     await Stripe.instance.initPaymentSheet(
  //       paymentSheetParameters: SetupPaymentSheetParameters(
  //         // Set to true for custom flow
  //         customFlow: false,
  //         // Main params
  //         merchantDisplayName: 'Test Merchant',
  //         paymentIntentClientSecret: data['client_secret'],
  //         // Customer keys
  //         customerEphemeralKeySecret: data['ephemeralKey'],
  //         customerId: data['id'],
  //         style: ThemeMode.dark,
  //       ),
  //     );

  //     // Display payment sheet
  //     await displayPaymentSheet(totalPrice, cartItems, address);
  //   } catch (e, s) {
  //     print('Payment exception:$e$s');
  //     Get.snackbar("Payment Exception Error", e.toString());
  //     setLoading = false;
  //     rethrow;
  //   }
  // }

  // // Display payment sheet
  // Future<void> displayPaymentSheet(
  //     double totalPrice, List<CartResponseModel> cartItems, AddressResponseModel? address) async {
  //   try {
  //     await Stripe.instance.presentPaymentSheet();
  //     print('Payment Successfully');
  //     Get.snackbar(
  //       "Payment Successfully",
  //       "Your payment for order completed",
  //       colorText: Colors.white,
  //       backgroundColor: const Color.fromARGB(255, 47, 136, 50),
  //       icon: Icon(
  //         Icons.check_circle_outline,
  //         color: Colors.white,
  //         size: 26,
  //       ),
  //     );

  //     // Call the createOrder method after successful payment
  //     List<OrderItem> orderItems = cartItems.map((cartItem) {
  //       return OrderItem(
  //         foodId: cartItem.productId.id,
  //         quantity: cartItem.quantity,
  //         price: cartItem.totalPrice,
  //         additives: cartItem.additives,
  //         instructions: "",
  //       );
  //     }).toList();

  //     OrderRequestModel order = OrderRequestModel(
  //       orderStatus: 'Out_for_Delivery',
  //       paymentMethod: 'Stripe',
  //       paymentStatus: 'Completed',
  //       userId: address!.userId,
  //       orderItems: orderItems,
  //       orderTotal: totalPrice - 85.40,
  //       deliveryFee: 50,
  //       grandTotal: totalPrice,
  //       deliveryAddress: address.id,
  //       restaurantAddress: "670 Post St, San Francisco, CA 94109, United States",
  //       restaurantId: "665dff25a1e02e570bf7fac9",
  //       restaurantCoords: [37.78792117665919, -122.41325651079953],
  //       recipientCoords: [address.latitude, address.longitude],
  //     );

  //     String orderData = orderRequestModelToJson(order);
  //     createOrder(orderData, order);
  //   } catch (e) {
  //     print('Exception/DISPLAYPAYMENTSHEET==> $e');
  //     Get.snackbar(
  //       "Payment Failed",
  //       "Your payment for order was not completed",
  //       colorText: Colors.white,
  //       backgroundColor: Colors.red,
  //       icon: Icon(
  //         Ionicons.alert_circle_outline,
  //         color: Colors.white,
  //         size: 26.h,
  //       ),
  //     );
  //   } finally {
  //     setLoading = false;
  //   }
  // }
  
  

}