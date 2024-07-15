// ignore_for_file: prefer_final_fields
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/models/api_error.dart';
import 'package:food_delivery_app/models/order_request_model.dart';
import 'package:food_delivery_app/models/order_response_model.dart';
import 'package:food_delivery_app/models/payment_request_model.dart';
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
  
  

}