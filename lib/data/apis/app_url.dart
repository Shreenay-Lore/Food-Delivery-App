class AppUrl {

  static const String baseUrl = 'http://192.168.1.4:6090';

  ///Address APIs..
  static const String addAddressApi = '/api/address';

  static const String addressListApi = '/api/address/all';

  static const String setDefaultAddressApi = '/api/address/default/';

  static const String fetchDefaultAddressApi = '/api/address/default';


  ///Category APIs..
  static const String fetchAllCategoriesApi = '/api/category';


  ///Foods APIs..
  static const String fetchAllRecommendedFoodApi = '/api/foods/byCode/';
  static const String fetchRestaurantMenuFoodsApi = '/api/foods/restaurant-foods/';


  ///Restaurant APIs..
  static const String fetchAllRestaurantsApi = '/api/restaurant/all/';

  



}