import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
String googleApiKey = 'ApiKey';



const kPrimary = Color(0xFF30b9b2);
const kPrimaryLight = Color(0xFF40F3EA);
const kSecondary = Color(0xffffa44f);
const kSecondaryLight = Color(0xFFffe5db);
const kTertiary = Color(0xff0078a6);
const kGray = Color(0xff83829A);
const kGrayLight = Color(0xffC1C0C8);
const kLightWhite = Color(0xffFAFAFC);
const kWhite = Color(0xfffFFFFF);
const kDark = Color(0xff000000);
const kRed = Color(0xffe81e4d);
const kOffWhite = Color(0xffF3F4F8);

double height = 825.h;
double width = 375.w;


const String appBaseUrl = "http://192.168.1.4:6013";

final List<String> verificationReasons =[
  'Real-time Updates: Get instant notifications about your order status.',
  'Direct Communication: A verified number ensures seamless communication.',
  'Enhanced Security: Protect your account and confirm orders securely.',
  'Effortless Rescheduling: Easily address issues with a quick call.',
  'Exclusive Offers: Stay in the loop for special deals and promotions.',
];

List<String> orderList = [
  "Pending",
  "Preparing",
  "Delivering",
  "Delivered",
  "Cancelled",
];

List<String> reasonsForAddingAddress = [
  "Ensures accurate delivery location",
  "Speeds up the checkout process",
  "Facilitates multiple delivery addresses",
  "Enables tracking of delivery status",
  "Improves customer support response",
];

  ///Dashboard Advertisement Image List....
  final List<String> advertisementImgList = [ 
    "https://cdn.grabon.in/gograbon/images/merchant/1536747990676.png",
    "https://d4t7t8y8xqo0t.cloudfront.net/app/resized/1080X/pages/989/image20191105102133.jpg",
    "https://cdn4.singleinterface.com/files/enterprise/coverphoto/34404/KFC-BAnner-20-02-24-05-04-08.jpg",
    "https://d4t7t8y8xqo0t.cloudfront.net/app/resized/1080X/pages/770/image20191022055205.jpg",
  ];

