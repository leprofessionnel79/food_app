import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/data/repository/popular_product_repo.dart';
import 'package:food_app/models/cart_model.dart';
import 'package:food_app/models/products_model.dart';
import 'package:food_app/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularProductsList = [];
  List<dynamic> get popularProductsList => _popularProductsList;

  late CartController _cart;
  bool _isLoaded = false;
  bool get isLoaed => _isLoaded;
  int _quantity = 0;
  int get quntitiy => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductLis() async {
    Response response = await popularProductRepo.getPopularProductList();

    if (response.statusCode == 200) {
      _popularProductsList = [];
      _popularProductsList.addAll(Product.fromJson(response.body).products);

      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantitiy(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar("Item Count", "You cant reduce more !!",
          backgroundColor: AppColors.mainColor, colorText: Colors.black);

      if (_inCartItems > 0) {
        _quantity = -_inCartItems;

        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar("Item Count", "You cant add more !!",
          backgroundColor: AppColors.mainColor, colorText: Colors.black);
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existIncart(product);
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
      // print("quantity in cart is " + _inCartItems.toString());
    }
    // print("exist or not " + exist.toString());
  }

  void addItem(ProductModel product) {
    // if (quntitiy > 0) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);

    _cart.items.forEach((key, value) {
      // print("item id is " +
      //     value.id!.toString() +
      //     " quantity is " +
      //     value.quantity!.toString());
    });

    update();
  }

  int get totalItem {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
