import 'package:food_app/pages/food/popular_food_detail.dart';
import 'package:food_app/pages/food/recommended_food_details.dart';
import 'package:food_app/pages/home/main_food_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = "/";
  static String getInitial() => '$initial';

  static const String popularFood = "/popular-food";
  static String getPopularFood(int pageId) => '$popularFood?pageId=$pageId';

  static const String recommendedFood = "/recommended-food";
  static String getrecommendedFood(int pageId) => '$recommendedFood?pageId=$pageId';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => MainFoodPage()),
    GetPage(
        transition: Transition.fadeIn,
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          return PopularFoodDetail(pageId:int.parse(pageId!));
        }),
    GetPage(
        transition: Transition.fadeIn,
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          return RecommendedFood(pageId:int.parse(pageId!));
        })
  ];
}
