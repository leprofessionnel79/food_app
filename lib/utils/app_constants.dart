class AppConstants {
  static const String APP_NAME = "FOOD_APP";
  static const int APP_VERSION = 1;
  /*
  http://10.0.2.2:80 this is IP for emulator
   */
  static const String BASE_URL = "http://10.0.2.2:80/foodapp/public";
  /*
  http://192.168.1.20 this is IP of laptop where api server located 
   */
  //static const String BASE_URL = "http://192.168.1.20/foodapp/public";

  static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URI = "/api/v1/products/recommended";
  // auth end points
  static const String REGISTRATION_URI = "/api/v1/auth/register";

  static const String TOKEN = "DBtoken";
  static const String UPLOADS = "/uploads/";
  static const String CART_LIST = "Cart-list";
  static const String CART_LIST_HISTORY = "history-cart-list";
}
