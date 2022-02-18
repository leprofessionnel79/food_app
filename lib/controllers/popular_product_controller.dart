import 'package:food_app/data/repository/popular_product_repo.dart';
import 'package:food_app/models/products_model.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularProductsList = [];
  List<dynamic> get popularProductsList => _popularProductsList;
  bool _isLoaded = false;
  bool get isLoaed => _isLoaded;
  Future<void> getPopularProductLis() async {
    Response response = await popularProductRepo.getPopularProductList();

    if (response.statusCode == 200) {
      print("Got products");
      _popularProductsList = [];
      _popularProductsList.addAll(Product.fromJson(response.body).products);
      print(_popularProductsList);
      _isLoaded = true;
      update();
    } else {}
  }
}
