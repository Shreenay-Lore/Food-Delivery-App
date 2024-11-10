import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/global.dart';
import 'package:food_delivery_app/routes/names.dart';
import 'package:food_delivery_app/routes/page_routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    String? token = box.read("token");
    return ScreenUtilInit(
      designSize: const Size(375, 825),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Food Delivery App',
          theme: ThemeData(
            scaffoldBackgroundColor: kOffWhite,
            iconTheme: const IconThemeData(color: kDark),
            primarySwatch: Colors.grey,
          ),
          initialRoute: token == null ? AppRoutes.INITIAL : AppRoutes.onMainNavBarPage,
          getPages: AppPages.routes,
        );
      },
    );
  }
}
