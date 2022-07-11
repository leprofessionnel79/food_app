import 'package:flutter/material.dart';
import 'package:food_app/base/no_data_page.dart';
import 'package:food_app/base/show_custom_snackbar.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/controllers/location_controller.dart';
import 'package:food_app/controllers/order_controller.dart';
import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/controllers/recommended_product_controller.dart';
import 'package:food_app/controllers/user_controller.dart';
import 'package:food_app/models/place_order_model.dart';
import 'package:food_app/pages/home/main_food_page.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_icons.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:food_app/controllers/location_controller.dart';

import '../../controllers/button_radio_controller.dart';
import '../../widgets/button_radio.dart';

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
                                                                  .width30 /
                                                              1.5,
                                                        ),
                                                        BigText(
                                                            text: _cartList[
                                                                    index]
                                                                .quantity!
                                                                .toString()), //popularProduct.inCartItems.toString()),
                                                        SizedBox(
                                                          width: Dimensions
                                                                  .width30 /
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
            height: Dimensions.height100 ,
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
                            left: Dimensions.width10/2,
                            right: Dimensions.width15),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white),
                        child: Row(
                          children: [
                            // SizedBox(
                            //   width: Dimensions.width10 / 2,
                            // ),
                            BigText(
                                text: "\$ " +
                                    cartController.totalAmount.toString()),
                            SizedBox(
                              width: Dimensions.width10 / 1.5,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.width10 /2,
                      ),
                       Container(
                            margin: EdgeInsets.only(right: Dimensions.width10/2),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ButtonRadio(
                                    value: 'paypal',
                                    title: 'PayPal'
                                  ),
                                  ButtonRadio(
                                      value: 'cash',
                                      title: 'Cash'
                                  ),
                                ],
                              ),

                          ),


                      GestureDetector(
                        onTap: () {

                          if (Get.find<AuthController>().userLoggedIn()) {

                            if (Get.find<LocationController>()
                                .addressList
                                .isEmpty) {

                             // Get.toNamed(RouteHelper.getAddressPage());
                              // from line 311 to line 326 just for testing it shouldn't be in this block

                              // var location = Get.find<LocationController>().getUserAddress();
                              var cart = Get.find<CartController>().getItems;
                              var user = Get.find<UserController>().userModel;
                              PlaceOrderBody placeOrder = PlaceOrderBody(
                                  cart: cart,
                                  orderAmount: 100.0,
                                  orderNote: "Not about Food",
                                  address: "unknown address",//??location.address,
                                  latitude: "45.51563",//??location.latitude,
                                  longitude: "-122.677433",//??location.longitude,
                                  contactPersonName: user!.name,
                                  contactPersonNumber: user!.phone,
                                  scheduleAt: '',
                                  distance: 10.0
                              );
                              Get.find<OrderController>().placeOrder(placeOrder,_callBack);
                            }
                            else{
                             // Get.offNamed(RouteHelper.getInitial());
                              var location = Get.find<LocationController>().getUserAddress();
                              var cart = Get.find<CartController>().getItems;
                              var user = Get.find<UserController>().userModel;
                              PlaceOrderBody placeOrder = PlaceOrderBody(
                                cart: cart,
                                orderAmount: 100.0,
                                orderNote: "Not about Food",
                                address: location.address??"unknowen address",
                                latitude: location.latitude??"45.51563",
                                longitude: location.longitude??"-122.677433",
                                contactPersonName: user!.name,
                                contactPersonNumber: user!.phone,
                                scheduleAt: '',
                                distance: 10.0
                              );
                              Get.find<OrderController>().placeOrder(placeOrder,_callBack);
                            }
                            cartController.addToHistory();
                          } else {
                            Get.toNamed(RouteHelper.getSignInPage());
                          }
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

  void _callBack(bool isSuccess, String message , String orderID,String paymentType){
    if(isSuccess){
      Get.find<CartController>().clear();
      Get.find<CartController>().removeCartSharedPreference();
      Get.find<CartController>().addToHistory();
      Get.offNamed(RouteHelper.getPaymentPage(orderID, Get.find<UserController>().userModel!.id,Get.find<ButtonRadioController>().paymentType));
    }else{
      showCustomSnackBar(message);
    }
  }
}
