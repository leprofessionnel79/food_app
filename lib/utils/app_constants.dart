class AppConstants {
  static const String APP_NAME = "FOOD_APP";
  static const int APP_VERSION = 1;
  /*
  http://10.0.2.2:80 this is IP for emulator
  //ahmad79.hopto.org or 192.168.1.33 which is the best bwt
  http://192.168.1.20 this is IP of laptop where api server located
   */
  static const String BASE_URL = "http://192.168.1.20:80/foodapp/public";

  static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URI = "/api/v1/products/recommended";

  static const String USER_ADDRESS = "user_address";
  static const String ADD_USER_ADDRESS ="/api/v1/customer/address/add";
  static const String ADDRESS_LIST_URI ="/api/v1/customer/address/list";

  static const String GEOCODE_URI = "/api/v1/config/geocode-api";
  static const String ZONE_URI = "/api/v1/config/get-zone-id";
  static const String SEARCH_LOCATION_URI = "/api/v1/config/place-api-autocomplete";
  static const String PLACE_DETAILS_URI = "/api/v1/config/place-api-details";

  // order

  static const String PLACE_ORDER_URI = "/api/v1/customer/order/place";

  // auth and user end points
  static const String REGISTRATION_URI = "/api/v1/auth/register";
  static const String LOGIN_URI = "/api/v1/auth/login";
  static const String USER_INFO_URI = "/api/v1/customer/info";
  // phone and password
  static const String PASSWORD = "";
  static const String PHONE = "";

  static const String TOKEN = "";
  static const String UPLOADS = "/uploads/";
  static const String CART_LIST = "Cart-list";
  static const String CART_HISTORY_LIST = "history-cart-list";
}
