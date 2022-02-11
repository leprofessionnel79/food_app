import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/data/api/api_client.dart';
import 'package:food_app/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';

Future<void> init() async {
  //apiclient
  Get.lazyPut(() => ApiClient(appBaseUrl: "https://www.myapi.com"));

  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));

  //conrollers 
  Get.lazyPut(() => PopularProductController(popularProductRepo:Get.find()));

}
