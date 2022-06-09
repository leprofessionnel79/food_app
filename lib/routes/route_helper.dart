import 'package:food_app/pages/address/add_address_page.dart';
import 'package:food_app/pages/address/pick_address_map.dart';
import 'package:food_app/pages/auth/sign_in_page.dart';
import 'package:food_app/pages/cart/cart_page.dart';
import 'package:food_app/pages/food/popular_food_detail.dart';
import 'package:food_app/pages/food/recommended_food_details.dart';
import 'package:food_app/pages/home/home_page.dart';
import 'package:food_app/pages/home/main_food_page.dart';
import 'package:food_app/pages/splash/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = "/";
  static String getInitial() => '$initial';

  static const String splashPage = "/splash-page";
  static String getSplashPage() => '$splashPage';

  static const String signInPage = "/signin-page";
  static String getSignInPage() => '$signInPage';

  static const String popularFood = "/popular-food";
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';

  static const String recommendedFood = "/recommended-food";
  static String getrecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';

  static const String cartPage = "/cart-page";
  static String getCartPage() => '$cartPage';

  static const String addAddress = "/add-address";
  static String getAddressPage() => '$addAddress';

  static const String pickAddressMap = "/pick-address";
  static String getPickAddressPage() => '$pickAddressMap';
  static List<GetPage> routes = [
    GetPage(name: pickAddressMap, page: (){
      PickAddressMap pickAddress = Get.arguments;
      return pickAddress;
    }),
    GetPage(name: splashPage, page: () => const SplashScreen()),
    GetPage(name: initial, page: () => const HomePage()),
    GetPage(
        transition: Transition.fadeIn,
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
        }),
    GetPage(
        transition: Transition.fadeIn,
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];

          var page = Get.parameters['page'];
          return RecommendedFood(pageId: int.parse(pageId!), page: page!);
        }),
    GetPage(
        transition: Transition.fadeIn,
        name: cartPage,
        page: () {
          return CartPage();
        }),
    GetPage(
        transition: Transition.fadeIn,
        name: signInPage,
        page: () {
          return SignInPage();
        }),
    GetPage(
        name: addAddress,
        page: () {
          return AddAddressPage();
        }),
  ];
}
