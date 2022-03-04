import 'package:flutter/material.dart';
import 'package:food_app/base/no_data_page.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/controllers/recommended_product_controller.dart';
import 'package:food_app/pages/home/main_food_page.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_icons.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: Dimensions.height20 * 3,
                left: Dimensions.width20,
                right: Dimensions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconcolor: Colors.white,
                      size: Dimensions.iconsize16 * 2.5,
                      backgroundcolor: AppColors.mainColor,
                    ),
                    SizedBox(
                      width: Dimensions.width20 * 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: AppIcon(
                        icon: Icons.home_outlined,
                        iconcolor: Colors.white,
                        size: Dimensions.iconsize16 * 2.5,
                        backgroundcolor: AppColors.mainColor,
                      ),
                    ),
                    AppIcon(
                      icon: Icons.shopping_cart,
                      iconcolor: Colors.white,
                      size: Dimensions.iconsize16 * 2.5,
                      backgroundcolor: AppColors.mainColor,
                    ),
                  ],
                )),
            GetBuilder<CartController>(builder: (_cartController) {
              return _cartController.getItems.length > 0
                  ? Positioned(
                      top: Dimensions.height20 * 5,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: 0,
                      child: Container(
                        margin: EdgeInsets.only(top: Dimensions.height10),
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: GetBuilder<CartController>(
                              builder: (cartController) {
                            var _cartList = cartController.getItems;

                            return ListView.builder(
                                itemCount: _cartList.length,
                                itemBuilder: (_, index) {
                                  return Container(
                                    height: Dimensions.height20 * 5,
                                    width: double.maxFinite,
                                    //color: Colors.blue,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            print("tapped");
                                            var PopularIndex = Get.find<
                                                    PopularProductController>()
                                                .popularProductsList
                                                .indexOf(
                                                    _cartList[index].product);

                                            if (PopularIndex >= 0) {
                                              Get.toNamed(
                                                  RouteHelper.getPopularFood(
                                                      PopularIndex,
                                                      "cartPage"));
                                            } else {
                                              var RecommendedIndex = Get.find<
                                                      RecommendedProductController>()
                                                  .recommendedProductsList
                                                  .indexOf(
                                                      _cartList[index].product);

                                              if (RecommendedIndex < 0) {
                                                Get.snackbar("History Product",
                                                    "product review is not avilable for history product!!",
                                                    backgroundColor:
                                                        AppColors.mainColor,
                                                    colorText: Colors.black);
                                              } else {
                                                Get.toNamed(RouteHelper
                                                    .getrecommendedFood(
                                                        RecommendedIndex,
                                                        "cartPage"));
                                              }
                                            }
                                          },
                                          child: Container(
                                            width: Dimensions.height20 * 5,
                                            height: Dimensions.height20 * 5,
                                            margin: EdgeInsets.only(
                                                bottom: Dimensions.height10),
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        AppConstants.BASE_URL +
                                                            AppConstants
                                                                .UPLOADS +
                                                            cartController
                                                                .getItems[index]
                                                                .img!)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius20),
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          width: Dimensions.width10,
                                        ),
                                        Expanded(
                                            child: Container(
                                          height: Dimensions.height100,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BigText(
                                                text: cartController
                                                    .getItems[index].name!,
                                                color: Colors.black45,
                                              ),
                                              SmallText(text: "Spicy"),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  BigText(
                                                    text: "\$" +
                                                        cartController
                                                            .getItems[index]
                                                            .price!
                                                            .toString(),
                                                    color: Colors.redAccent,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top:
                                                            Dimensions.height10,
                                                        bottom:
                                                            Dimensions.height10,
                                                        left:
                                                            Dimensions.width10,
                                                        right:
                                                            Dimensions.width10),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimensions
                                                                    .radius20),
                                                        color: Colors.white),
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            cartController.addItem(
                                                                _cartList[index]
                                                                    .product!,
                                                                -1);
                                                          },
                                                          child: Icon(
                                                            Icons.remove,
                                                            color: AppColors
                                                                .signColor,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: Dimensions
                                                                  .width10 /
                                                              1.5,
                                                        ),
                                                        BigText(
                                                            text: _cartList[
                                                                    index]
                                                                .quantity!
                                                                .toString()), //popularProduct.inCartItems.toString()),
                                                        SizedBox(
                                                          width: Dimensions
                                                                  .width10 /
                                                              1.5,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            cartController.addItem(
                                                                _cartList[index]
                                                                    .product!,
                                                                1);
                                                          },
                                                          child: Icon(
                                                            Icons.add,
                                                            color: AppColors
                                                                .signColor,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )),
                                      ],
                                    ),
                                  );
                                });
                          }),
                        ),
                      ))
                  : NoDataPage(text: "Your Cart Is Empty !!");
            })
          ],
        ),
        bottomNavigationBar:
            GetBuilder<CartController>(builder: (cartController) {
          return Container(
            height: Dimensions.height100 / 1.12,
            padding: EdgeInsets.only(
                top: Dimensions.height10,
                bottom: Dimensions.height10,
                left: Dimensions.width15,
                right: Dimensions.width15),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.height20 * 2),
                  topRight: Radius.circular(Dimensions.height20 * 2),
                )),
            child: cartController.getItems.length > 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: Dimensions.height15,
                            bottom: Dimensions.height15,
                            left: Dimensions.width15,
                            right: Dimensions.width15),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white),
                        child: Row(
                          children: [
                            SizedBox(
                              width: Dimensions.width10 / 1.5,
                            ),
                            BigText(
                                text: "\$ " +
                                    cartController.totalAmount.toString()),
                            SizedBox(
                              width: Dimensions.width10 / 1.5,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          cartController.addToHistory();
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: Dimensions.height15,
                              bottom: Dimensions.height15,
                              left: Dimensions.width15,
                              right: Dimensions.width15),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              color: AppColors.mainColor),
                          child: BigText(
                            text: "Check Out",
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )
                : Container(),
          );
        }));
  }
}
