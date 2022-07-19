import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/base/common_text_button.dart';
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
import 'package:food_app/pages/order/delivery_options.dart';
import 'package:food_app/pages/order/payment_option_button.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/utils/styles.dart';
import 'package:food_app/widgets/app_icons.dart';
import 'package:food_app/widgets/app_text_field.dart';
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
    TextEditingController _notController = TextEditingController();
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
                                                                .toString()),
                                                        //popularProduct.inCartItems.toString()),
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
            GetBuilder<OrderController>(builder: (orderController){
              _notController.text=orderController.foodnote;
              return GetBuilder<CartController>(builder: (cartController) {
                return Container(
                  height: Dimensions.height120 + Dimensions.height20 ,
                  padding: EdgeInsets.only(
                      top: Dimensions.height10 / 2,
                      bottom: Dimensions.height10 / 2,
                      left: Dimensions.width15,
                      right: Dimensions.width15),
                  decoration: BoxDecoration(
                      color: AppColors.buttonBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.height20 * 2),
                        topRight: Radius.circular(Dimensions.height20 * 2),
                      )),
                  child: cartController.getItems.length > 0
                      ? Column(
                    children: [
                      InkWell(
                        onTap: () => showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (_) {
                              return Column(
                                children: [
                                  Expanded(
                                      child: SingleChildScrollView(
                                        child: Container(
                                          height:
                                          MediaQuery.of(context).size.height *
                                              0.9,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                    Dimensions.radius20),
                                                topRight: Radius.circular(
                                                    Dimensions.radius20),
                                              )),
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: Dimensions.height20,
                                                    left: Dimensions.width20,
                                                    right: Dimensions.width20),
                                                height: 520,
                                                child: Column(
                                                  children: [
                                                    const PaymentOptionButton(
                                                      icon: Icons.money,
                                                      title: "Cash On Delivery",
                                                      subtitle:
                                                      "you pay after getting delivery",
                                                      index: 0,
                                                    ),
                                                    SizedBox(
                                                      height: Dimensions.height10,
                                                    ),
                                                    const PaymentOptionButton(
                                                      icon: Icons.paypal_outlined,
                                                      title: "Digital Payment",
                                                      subtitle:
                                                      "safer and faster way to pay",
                                                      index: 1,
                                                    ),
                                                    SizedBox(
                                                      height:
                                                      Dimensions.height10 / 2,
                                                    ),
                                                    Text(
                                                      "Delivery Options ",
                                                      style: robotoMedium,
                                                    ),
                                                    DeliveryOptions(
                                                        value: "delivery",
                                                        title: "home delivery",
                                                        amount: double.parse(
                                                            Get.find<
                                                                CartController>()
                                                                .totalAmount
                                                                .toString()),
                                                        isFree: false),
                                                    const DeliveryOptions(
                                                        value: "take away",
                                                        title: "take away",
                                                        amount: 10.0,
                                                        isFree: true),
                                                    SizedBox(
                                                      height: Dimensions.height20,
                                                    ),
                                                    Text(
                                                      "Additional notes ",
                                                      style: robotoMedium,
                                                    ),
                                                    AppTextField(
                                                      textEditingController:
                                                      _notController,
                                                      hintText: '',
                                                      icon: Icons.note,
                                                      maxLines: true,
                                                    )
                                                  ],
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                                ],
                              );
                            }).whenComplete(() => orderController.setFoodNote(_notController.text.trim())),
                        child: SizedBox(
                          width: double.maxFinite,
                          child: CommonTextButton(
                            text: "payment and delivery options",
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.height10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                top: Dimensions.height15,
                                bottom: Dimensions.height15,
                                left: Dimensions.width10 / 2,
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
                            width: Dimensions.width10 / 2,
                          ),

                          GestureDetector(
                            onTap: () async {


                              if (Get.find<AuthController>().userLoggedIn()) {
                                if (Get.find<LocationController>()
                                    .addressList
                                    .isEmpty) {
                                  // Get.toNamed(RouteHelper.getAddressPage());

                                  // var location = Get.find<LocationController>().getUserAddress();
                                  // if(paymentType=="cash"){
                                  //    isCash= await showCupertinoDialog(context: context, builder: createDialog);
                                  //  print("isCash is :"+isCash.toString());
                                  //
                                  //     // print("isCash is :"+isCash.toString());
                                  //      var cart = Get.find<CartController>().getItems;
                                  //      var user = Get.find<UserController>().userModel;
                                  //      PlaceOrderBody placeOrder = PlaceOrderBody(
                                  //          cart: cart,
                                  //          orderAmount: 100.0,
                                  //          orderNote: "Not about Food",
                                  //          address: "unknown address",//??location.address,
                                  //          latitude: "45.51563",//??location.latitude,
                                  //          longitude: "-122.677433",//??location.longitude,
                                  //          contactPersonName: user!.name,
                                  //          contactPersonNumber: user!.phone,
                                  //          scheduleAt: '',
                                  //          distance: 10.0
                                  //      );
                                  //     isCash? Get.find<OrderController>().placeOrder(placeOrder,_callBack):"something went wrong";
                                  //
                                  // }
                                  // var location = Get.find<LocationController>().getUserAddress();
                                  var cart =
                                      Get.find<CartController>().getItems;
                                  var user =
                                      Get.find<UserController>().userModel;
                                  PlaceOrderBody placeOrder = PlaceOrderBody(
                                      cart: cart,
                                      orderAmount: 100.0,
                                      orderNote: orderController.foodnote,
                                      address: "unknown address",
                                      //location.address,
                                      latitude: "45.51563",
                                      //location.latitude,
                                      longitude: "-122.677433",
                                      //location.longitude,
                                      contactPersonName: user!.name,
                                      contactPersonNumber: user!.phone,
                                      scheduleAt: '',
                                      distance: 10.0,
                                      orderType: orderController.orderType,
                                      paymentMethod: orderController.paymentIndex==0?'cash_in_delivery':'digital_payment');
                                  Get.find<OrderController>()
                                      .placeOrder(placeOrder, _callBack);
                                } else {
                                  // Get.offNamed(RouteHelper.getInitial());
                                  var location = Get.find<LocationController>()
                                      .getUserAddress();
                                  var cart =
                                      Get.find<CartController>().getItems;
                                  var user =
                                      Get.find<UserController>().userModel;
                                  PlaceOrderBody placeOrder = PlaceOrderBody(
                                      cart: cart,
                                      orderAmount: 100.0,
                                      orderNote: "Not about Food",
                                      address: location.address,
                                      latitude: location.latitude,
                                      longitude: location.longitude,
                                      contactPersonName: user!.name,
                                      contactPersonNumber: user!.phone,
                                      orderType: orderController.orderType,
                                      paymentMethod: orderController.paymentIndex==0?'cash_in_delivery':'digital_payment',
                                      scheduleAt: '',
                                      distance: 10.0);
                                  Get.find<OrderController>()
                                      .placeOrder(placeOrder, _callBack);
                                }
                                cartController.addToHistory();
                              } else {
                                Get.toNamed(RouteHelper.getSignInPage());
                              }
                            },
                            child: CommonTextButton(
                              text: "Check Out",
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                      : Container(),
                );
              });
            }));
  }

  Widget createDialog(BuildContext context) => CupertinoAlertDialog(
        title: Text(
          "Note",
          style: TextStyle(fontSize: Dimensions.font17),
        ),
        content: Text(
          "Transporting cash will be out total amount!!",
          style: TextStyle(fontSize: Dimensions.font20),
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text("OK"),
            onPressed: () => Navigator.pop(context, true),
          ),
          CupertinoDialogAction(
            child: const Text("CANCEL"),
            onPressed: () => Navigator.pop(context, false),
          ),
        ],
      );

  void _callBack(
      bool isSuccess, String message, String orderID) {
    if (isSuccess) {
      Get.find<CartController>().clear();
      Get.find<CartController>().removeCartSharedPreference();
      Get.find<CartController>().addToHistory();
      if(Get.find<OrderController>().paymentIndex==0){
        Get.offNamed(RouteHelper.getOrderSuccessPage(orderID, "success"));
      }else{
        Get.offNamed(RouteHelper.getPaymentPage(
          orderID,
          Get.find<UserController>().userModel!.id,
        ));
      }

    } else {
      showCustomSnackBar(message);
    }
  }
}
