import 'package:flutter/material.dart';
import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/pages/home/main_food_page.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_column.dart';
import 'package:food_app/widgets/app_icons.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/expandable_text_widget.dart';
import 'package:food_app/widgets/icon_text_widget.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;

  PopularFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductsList[pageId];
    // print("product id is " + pageId.toString());
    // print("product name is " + product.name.toString());
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: Dimensions.height350 / 1.12,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOADS+product.img!))),
                )),
            Positioned(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.height45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.to(() => MainFoodPage());
                        },
                        child: AppIcon(icon: Icons.arrow_back_ios)),
                    AppIcon(icon: Icons.shopping_cart_outlined)
                  ],
                )),
            Positioned(
                left: 0,
                right: 0,
                top: (Dimensions.height350 / 1.12) - 20,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      top: Dimensions.height10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.radius20),
                          topRight: Radius.circular(Dimensions.radius20)),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppColumn(
                        text: product.name!,
                      ),
                      SizedBox(
                        height: Dimensions.height10 / 2,
                      ),
                      BigText(text: "Introduce"),
                      SizedBox(
                        height: Dimensions.height10 / 2,
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                              child: ExpandableText(
                                  text:
                                      product.description!)))
                    ],
                  ),
                ))
          ],
        ),
        bottomNavigationBar: Container(
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15,
                    bottom: Dimensions.height15,
                    left: Dimensions.width15,
                    right: Dimensions.width15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white),
                child: Row(
                  children: [
                    Icon(
                      Icons.remove,
                      color: AppColors.signColor,
                    ),
                    SizedBox(
                      width: Dimensions.width10 / 1.5,
                    ),
                    BigText(text: "0"),
                    SizedBox(
                      width: Dimensions.width10 / 1.5,
                    ),
                    Icon(
                      Icons.add,
                      color: AppColors.signColor,
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15,
                    bottom: Dimensions.height15,
                    left: Dimensions.width15,
                    right: Dimensions.width15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor),
                child: BigText(
                  text: "\$ ${product.price!}| ADD TO CART",
                  color: Colors.white,
                ),
              )
            ],
          ),
        ));
  }
}
