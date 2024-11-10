// ignore_for_file: prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/data/apis/app_url.dart';
import 'package:food_delivery_app/models/addresses_response_model.dart';
import 'package:food_delivery_app/models/api_error.dart';
import 'package:food_delivery_app/models/cart_response_model.dart';
import 'package:food_delivery_app/models/order_request_model.dart';
import 'package:food_delivery_app/models/order_response_model.dart';
import 'package:food_delivery_app/pages/orders/widgets/payments/successful.dart';
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

    Uri url = Uri.parse('${AppUrl.baseUrl}/api/orders');

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

      }else{
        var error = apiErrorFromJson(response.body);
        Get.snackbar( 
          "Order Failed ", error.message!,
          colorText: kWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.error)
        );

      }

    }catch(e){
      debugPrint(e.toString());
    }
  }

  Future<void> initPaymentSheet(
        double totalPrice, List<CartResponseModel> cartItems, AddressResponseModel? address) async {
    try {
      int amountInPaise = (totalPrice * 100).round();

      final data = await createPaymentIntent(
        amount: amountInPaise.toString(),
        currency: "INR",
        name: "User Name",
        address: address!.addressLine1!,
        pin: address.postalCode!,
        city: address.addressLine1!,
        state: address.addressLine1!,
        country: "India",
      );

      if (data == null) {
        throw Exception("Payment Intent creation failed");
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          customFlow: false,
          merchantDisplayName: 'Test Merchant',
          paymentIntentClientSecret: data['client_secret'],
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

  Future<void> displayPaymentSheet(double totalPrice, List<CartResponseModel> cartItems, AddressResponseModel? address) async {
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
        userId: address!.userId!,
        orderItems: orderItems,
        orderTotal: totalPrice - 85.40,
        deliveryFee: 50,
        grandTotal: totalPrice,
        deliveryAddress: address.id!,
        restaurantAddress: "670 Post St, San Francisco, CA 94109, United States",
        restaurantId: "665dff25a1e02e570bf7fac9",
        restaurantCoords: [
          37.78792117665919,
          -122.41325651079953,
        ],
        recipientCoords: [address.latitude!, address.longitude!],
      );

      String orderData = orderRequestModelToJson(order);
      createOrder(orderData, order);

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
  
  Future createPaymentIntent({required String name,
    required String address,
    required String pin,
    required String city,
    required String state,
    required String country,
    required String currency,
    required String amount}) async{

    final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
    final secretKey=dotenv.env["STRIPE_SECRET_KEY"]!;
    final body={
      'amount': amount,
      'currency': currency.toLowerCase(),
      'automatic_payment_methods[enabled]': 'true',
      'description': "Test Donation",
      'shipping[name]': name,
      'shipping[address][line1]': address,
      'shipping[address][postal_code]': pin,
      'shipping[address][city]': city,
      'shipping[address][state]': state,
      'shipping[address][country]': country
    };

    final response= await http.post(url,
    headers: {
      "Authorization": "Bearer $secretKey",
      'Content-Type': 'application/x-www-form-urlencoded'
    },
      body: body
    );

    print('Request Body: $body');
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if(response.statusCode==200){
      var json = jsonDecode(response.body);
      print('Payment Intent Created: $json');
      return json;
    }
    else{
      var errorJson = jsonDecode(response.body);
      print('Error Creating Payment Intent: $errorJson');
      throw Exception("Payment Intent creation failed: ${errorJson['error']['message']}");
    }
  }


}