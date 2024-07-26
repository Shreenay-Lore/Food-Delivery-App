import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import  'package:http/http.dart' as http;

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


// import 'package:flutter/material.dart';
// import 'package:food_delivery_app/constants/constants.dart';
// import 'package:food_delivery_app/controller/orders_controller.dart';
// import 'package:food_delivery_app/views/orders/widgets/payments/failed.dart';
// import 'package:food_delivery_app/views/orders/widgets/payments/successful.dart';
// import 'package:get/get.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_android/webview_flutter_android.dart';
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

// class PaymentWebView extends StatefulWidget {
//   const PaymentWebView({super.key});

//   @override
//   State<PaymentWebView> createState() => _PaymentWebViewState();
// }

// class _PaymentWebViewState extends State<PaymentWebView> {
//   late final WebViewController _controller;

//   @override
//   void initState() {
//     super.initState();
//     final OrdersController orderController = Get.put(OrdersController());
//     //#docregion platform_features
//     late final PlatformWebViewControllerCreationParams params;
//     if(WebViewPlatform.instance is WebViewPlatform) {
//       params = WebKitWebViewControllerCreationParams(
//         allowsInlineMediaPlayback: true,
//         mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
//       );
//     }else{
//       params = const PlatformWebViewControllerCreationParams();
//     }

//     final WebViewController controller = WebViewController.fromPlatformCreationParams(params);

//     //#enddocregion platform_features

//     controller
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor( const Color(0x00000000))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageStarted: (String  url) {
//             //debugPrint('Page started loading: ${paymentNotifier.paymentUrl}');
//           },
//           onPageFinished: (String  url) {
//             //debugPrint('Page finished loading: $url');
//           },

//           onNavigationRequest: (NavigationRequest request) {
//             return NavigationDecision.navigate;
//           },
//           onUrlChange: (UrlChange change) {
//             if (change.url!.contains("checkout-success")){
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentSuccessful(),));
//             }else if (change.url!.contains("cancel")){
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentFailed(),));
//             }
//           },
//         ),
//       )
//       ..addJavaScriptChannel(
//         'Toaster', 
//         onMessageReceived: (JavaScriptMessage message) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(message.message)),
//           );
//         },
//       )
//       ..loadRequest(Uri.parse(orderController.paymentUrl));
    
//     //#docregion platform_features
//     if (controller.platform is AndroidWebViewController){
//       AndroidWebViewController.enableDebugging(true);
//       (controller.platform as AndroidWebViewController).setMediaPlaybackRequiresUserGesture(false);
//     }

//     //#enddocregion platform_features
//     _controller = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kWhite,
//       appBar: AppBar(
//         backgroundColor: kWhite,
//         elevation: 0,
//         toolbarHeight: 20,
//       ),
//       body: WebViewWidget(controller: _controller),
//     );
//   }
// }