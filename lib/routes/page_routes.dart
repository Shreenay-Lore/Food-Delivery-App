import 'package:food_delivery_app/pages/address/add_address_page.dart';
import 'package:food_delivery_app/pages/address/address_list_page.dart';
import 'package:food_delivery_app/pages/address/bindings/user_location_binding.dart';
import 'package:food_delivery_app/pages/auth/bindings/email_verification_binding.dart';
import 'package:food_delivery_app/pages/auth/bindings/login_binding.dart';
import 'package:food_delivery_app/pages/auth/bindings/phone_verification_binding.dart';
import 'package:food_delivery_app/pages/auth/bindings/registration_binding.dart';
import 'package:food_delivery_app/pages/auth/email_verification_page.dart';
import 'package:food_delivery_app/pages/auth/login_page.dart';
import 'package:food_delivery_app/pages/auth/phone_verification_page.dart';
import 'package:food_delivery_app/pages/auth/registration_page.dart';
import 'package:food_delivery_app/pages/auth/start_page.dart';
import 'package:food_delivery_app/pages/home/all_nearby_restaurants_page.dart';
import 'package:food_delivery_app/pages/home/all_recommendations_page.dart';
import 'package:food_delivery_app/pages/main_screen/binding/main_screen_binding.dart';
import 'package:food_delivery_app/pages/main_screen/entry_point.dart';
import 'package:food_delivery_app/pages/orders/user_orders.dart';
import 'package:food_delivery_app/pages/search/binding/search_binding.dart';
import 'package:food_delivery_app/pages/search/search_page.dart';
import 'package:food_delivery_app/routes/names.dart';
import 'package:get/get.dart';


class AppPages {
  static const INITIAL = AppRoutes.INITIAL;


  static final List<GetPage> routes = [

    GetPage(
      name: AppRoutes.INITIAL,
      page: () =>  const StartPage(),
      transition: Transition.cupertino
    ),

    ///Auth Pages Routes....
    GetPage(
      name: AppRoutes.onLoginPage,
      page: () =>  const LoginPage(),
      binding: LoginBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 900),
    ),

    GetPage(
      name: AppRoutes.onRegistrationPage,
      page: () =>  const RegistrationPage(),
      binding: RegistrationBinding(),
      transition: Transition.rightToLeft
    ),

    GetPage(
      name: AppRoutes.onEmailVerificationPage,
      page: () =>  const EmailVerificationPage(),
      binding: EmailVerificationBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 900),
    ),

    GetPage(
      name: AppRoutes.onPhoneVerificationPage,
      page: () =>  const PhoneVerificationPage(),
      binding: PhoneVerificationBinding(),
    ),



    ///Home Page Routes...
    GetPage(
      name: AppRoutes.onMainNavBarPage,
      page: () =>  const MainScreen(),
      binding: MainScreenBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 900),
    ),

    GetPage(
      name: AppRoutes.onSearchPage,
      page: () =>  const SearchPage(),
      binding: SearchBinding(),
    ),
    
    GetPage(
      name: AppRoutes.onAllFoodRecommendationsPage, 
      page: () => const RecommendationsPage(), 
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 900)
    ),
  
    GetPage(
      name: AppRoutes.onAllNearByRestaurantsPage, 
      page: () => const AllNearbyRestaurantsPage(), 
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 900)
    ),

    GetPage(
      name: AppRoutes.onUserOrdersPage, 
      page: () => const UserOrders(), 
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 900)
    ),
    

    ///User Location Routes...
    GetPage(
      name: AppRoutes.onAddressListPage, 
      page: () => const AddressListPage(), 
      binding: UserLocationBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 900)
    ),

    GetPage(
      name: AppRoutes.onAddUserAddressPage, 
      page: () => const AddAddress(), 
      binding: UserLocationBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 900)
    ),


  ];


}
