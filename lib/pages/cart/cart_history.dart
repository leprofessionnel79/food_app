import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/base/no_data_page.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/models/cart_model.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_icons.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItmesPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItmesPerOrder.containsKey(getCartHistoryList[i].time!)) {
        cartItmesPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItmesPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItmesPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeTolist() {
      return cartItmesPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();
    var listCounter = 0;

    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("dd/MM/yyyy hh:mm a");
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(text: outputDate);
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimensions.height100,
            width: double.maxFinite,
            color: AppColors.mainColor,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: "CartHistory",
                  color: Colors.white,
                ),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconcolor: AppColors.mainColor,
                  backgroundcolor: AppColors.yellowColor,
                )
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getCartHistoryList().length > 0
                ? Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                      ),
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView(
                          children: [
                            for (int i = 0; i < itemsPerOrder.length; i++)
                              Container(
                                height: Dimensions.height120,
                                margin: EdgeInsets.only(
                                    bottom: Dimensions.height20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    timeWidget(listCounter),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Wrap(
                                            direction: Axis.horizontal,
                                            children: List.generate(
                                                itemsPerOrder[i], (index) {
                                              if (listCounter <
                                                  getCartHistoryList.length) {
                                                listCounter++;
                                              }
                                              return index <= 2
                                                  ? Container(
                                                      width:
                                                          Dimensions.height20 *
                                                              4,
                                                      height:
                                                          Dimensions.width20 *
                                                              4,
                                                      margin: EdgeInsets.only(
                                                          right: Dimensions
                                                                  .width10 /
                                                              2),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(Dimensions
                                                                      .radius15 /
                                                                  2),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(AppConstants
                                                                      .BASE_URL +
                                                                  AppConstants
                                                                      .UPLOADS +
                                                                  getCartHistoryList[
                                                                          listCounter -
                                                                              1]
                                                                      .img!))),
                                                    )
                                                  : Container();
                                            })),
                                        Expanded(
                                          child: Container(
                                            height: Dimensions.height20 * 4,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                SmallText(
                                                  text: "Total",
                                                  color:
                                                      AppColors.mainBlackColor,
                                                ),
                                                BigText(
                                                  text: itemsPerOrder[i]
                                                          .toString() +
                                                      " Items",
                                                  color: AppColors.titleColor,
                                                  size: Dimensions.font26 / 2.2,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    var orderTime =
                                                        cartOrderTimeTolist();
                                                    Map<int, CartModel>
                                                        moreOrder = {};
                                                    for (int j = 0;
                                                        j <
                                                            getCartHistoryList
                                                                .length;
                                                        j++) {
                                                      if (getCartHistoryList[j]
                                                              .time ==
                                                          orderTime[i]) {
                                                        moreOrder.putIfAbsent(
                                                            getCartHistoryList[j]
                                                                .id!,
                                                            () => CartModel.fromJson(
                                                                jsonDecode(jsonEncode(
                                                                    getCartHistoryList[
                                                                        j]))));
                                                      }
                                                    }
                                                    Get.find<CartController>()
                                                        .setItem = moreOrder;
                                                    Get.toNamed(RouteHelper
                                                        .getCartPage());
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                Dimensions
                                                                    .width10,
                                                            vertical: Dimensions
                                                                    .height10 /
                                                                2),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(Dimensions
                                                                    .radius15 /
                                                                3),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: AppColors
                                                                .mainColor)),
                                                    child: SmallText(
                                                      text: "one more",
                                                      color:
                                                          AppColors.mainColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: const Center(
                      child: NoDataPage(
                        text: "You didnt buy anything so far !!",
                        imagPath: "assets/image/empty_box.png",
                      ),
                    ),
                  );
          })
        ],
      ),
    );
  }
}
