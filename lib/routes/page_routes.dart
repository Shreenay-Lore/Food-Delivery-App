import 'package:food_delivery_app/pages/address/address_list_page.dart';
import 'package:food_delivery_app/pages/home/all_nearby_restaurants_page.dart';
import 'package:food_delivery_app/pages/home/all_recommendations_page.dart';
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
      page: () =>  MainScreen(),
    ),


    ///Home Page Routes...
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

    GetPage(
      name: AppRoutes.onAllAddressesPage, 
      page: () => const AddressesPage(), 
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 900)
    ),


  ];






}
