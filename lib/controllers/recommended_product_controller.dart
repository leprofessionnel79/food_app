import 'package:food_app/data/repository/popular_product_repo.dart';
import 'package:food_app/data/repository/recommended_product_repo.dart';
import 'package:food_app/models/products_model.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});

  List<dynamic> _recommendedProductsList = [];
  List<dynamic> get recommendedProductsList => _recommendedProductsList;
  bool _isLoaded = false;
  bool get isLoaed => _isLoaded;
  Future<void> getRecommendedProductLis() async {
    Response response = await recommendedProductRepo.getRecomendedProductList();

    if (response.statusCode == 200) {
      print("Got recommended products");
      _recommendedProductsList = [];
      _recommendedProductsList.addAll(Product.fromJson(response.body).products);
      print(_recommendedProductsList);
      _isLoaded = true;
      update();
    } else {}
  }
}