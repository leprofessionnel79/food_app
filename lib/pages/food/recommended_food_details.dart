import 'package:flutter/material.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_icons.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

class RecommendedFood extends StatelessWidget {
  const RecommendedFood({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(icon: Icons.clear)),
                AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            bottom: PreferredSize(
                child: Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height10 / 2,
                        bottom: Dimensions.height10 / 2),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.radius20),
                          topRight: Radius.circular(Dimensions.radius20),
                        )),
                    child: Center(
                        child: BigText(
                      text: "Chiness Side",
                      size: Dimensions.font26,
                    ))),
                preferredSize: Size.fromHeight(Dimensions.height20)),
            expandedHeight: Dimensions.height320,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/image/food0.png",
                fit: BoxFit.cover,
                width: double.maxFinite,
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
            children: [
              Container(
                child: ExpandableText(
                    text:
                        "Ahlates tr meat to diffAccording to Pratibha Karan, who wrote the book Biryani, biryani is of South Indian origin, derived from pilaf varieties brought to the Indian subcontinent by Arab traders. She speculates that the pulao was an army dish in medieval India. Armies would prepare a one-pot dish of rice with whichever meat was available. Over time, the dish became biryani due to different methods of cooking, According to Pratibha Karan, who wrote the book Biryani, biryani is of South Indian origin, derived from pilaf varieties brought to the Indian subcontinent by Arab traders. She speculates that the pulao was an army dish in medieval India. Armies would prepare a one-pot dish of rice with whichever meat was available. Over time, the dish became biryani due to different methods of cooking, with the distinction between pulao and biryani being arbitrarywith the distinction between pulao and biryani being arbitraryAhlates tr meat to diffAccording to Pratibha Karan, who wrote the book Biryani, biryani is of South Indian origin, derived from pilaf varieties brought to the Indian subcontinent by Arab traders. She speculates that the pulao was an army dish in medieval India. Armies would prepare a one-pot dish of rice with whichever meat was available. Over time, the dish became biryani due to different methods of cooking, According to Pratibha Karan, who wrote the book Biryani, biryani is of South Indian origin, derived from pilaf varieties brought to the Indian subcontinent by Arab traders. She speculates that the pulao was an army dish in medieval India. Armies would prepare a one-pot dish of rice with whichever meat was available. Over time, the dish became biryani due to different methods of cooking, with the distinction between pulao and biryani being arbitrarywith the distinction between pulao and biryani being arbitraryAhlates tr meat to diffAccording to Pratibha Karan, who wrote the book Biryani, biryani is of South Indian origin, derived from pilaf varieties brought to the Indian subcontinent by Arab traders. She speculates that the pulao was an army dish in medieval India. Armies would prepare a one-pot dish of rice with whichever meat was available. Over time, the dish became biryani due to different methods of cooking, According to Pratibha Karan, who wrote the book Biryani, biryani is of South Indian origin, derived from pilaf varieties brought to the Indian subcontinent by Arab traders. She speculates that the pulao was an army dish in medieval India. Armies would prepare a one-pot dish of rice with whichever meat was available. Over time, the dish became biryani due to different methods of cooking, with the distinction between pulao and biryani being arbitrarywith the distinction between pulao and biryani being arbitraryAhlates tr meat to diffAccording to Pratibha Karan, who wrote the book Biryani, biryani is of South Indian origin, derived from pilaf varieties brought to the Indian subcontinent by Arab traders. She speculates that the pulao was an army dish in medieval India. Armies would prepare a one-pot dish of rice with whichever meat was available. Over time, the dish became biryani due to different methods of cooking, According to Pratibha Karan, who wrote the book Biryani, biryani is of South Indian origin, derived from pilaf varieties brought to the Indian subcontinent by Arab traders. She speculates that the pulao was an army dish in medieval India. Armies would prepare a one-pot dish of rice with whichever meat was available. Over time, the dish became biryani due to different methods of cooking, with the distinction between pulao and biryani being arbitrarywith the distinction between pulao and biryani being arbitrary"),
                margin: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
              )
            ],
          ))
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: Dimensions.width20 * 2.5,
              right: Dimensions.width20 * 2.5,
              top: Dimensions.height10,
              bottom: Dimensions.height10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.remove,
                  backgroundcolor: AppColors.mainColor,
                  iconcolor: Colors.white,
                ),
                BigText(
                  text: "\$10.88 " + " X" + " O",
                  color: AppColors.mainBlackColor,
                  size: Dimensions.font26,
                ),
                AppIcon(
                  icon: Icons.add,
                  backgroundcolor: AppColors.mainColor,
                  iconcolor: Colors.white,
                ),
              ],
            ),
          ),
          Container(
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
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white),
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                    )),
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
                    text: "\$10 | ADD TO CART",
                    color: Colors.white,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
