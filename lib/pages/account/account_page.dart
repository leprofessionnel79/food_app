import 'package:flutter/material.dart';
import 'package:food_app/base/custom_loader.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/controllers/user_controller.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/account_widget.dart';
import 'package:food_app/widgets/app_icons.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();

    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      print("logged in");
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.mainColor,
        title: Center(
            child: BigText(
                text: "Profile", size: Dimensions.font26, color: Colors.white)),
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        return _userLoggedIn
            ? (userController.isLoading
                ? Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(top: Dimensions.height20),
                    child: Column(
                      children: [
                        // profile icon
                        AppIcon(
                          icon: Icons.person,
                          backgroundcolor: AppColors.mainColor,
                          size: Dimensions.height15 * 10,
                          iconSize: Dimensions.height45 + Dimensions.height30,
                          iconcolor: Colors.white,
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        // person name
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.person,
                                      backgroundcolor: AppColors.mainColor,
                                      size: Dimensions.height10 * 5,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      iconcolor: Colors.white,
                                    ),
                                    bigText: BigText(
                                      text: userController.userModel.name,
                                    )),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                // phone
                                AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.phone,
                                      backgroundcolor: AppColors.yellowColor,
                                      size: Dimensions.height10 * 5,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      iconcolor: Colors.white,
                                    ),
                                    bigText: BigText(
                                      text: userController.userModel.phone,
                                    )),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                // email
                                AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.email,
                                      backgroundcolor: AppColors.yellowColor,
                                      size: Dimensions.height10 * 5,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      iconcolor: Colors.white,
                                    ),
                                    bigText: BigText(
                                      text: userController.userModel.email,
                                    )),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                // address
                                AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.location_on,
                                      backgroundcolor: AppColors.yellowColor,
                                      size: Dimensions.height10 * 5,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      iconcolor: Colors.white,
                                    ),
                                    bigText: BigText(
                                      text: "Fill in your address",
                                    )),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                // messages
                                AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.message_outlined,
                                      backgroundcolor: Colors.redAccent,
                                      size: Dimensions.height10 * 5,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      iconcolor: Colors.white,
                                    ),
                                    bigText: BigText(
                                      text: "Messeges",
                                    )),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (Get.find<AuthController>()
                                        .userLoggedIn()) {
                                      Get.find<AuthController>()
                                          .clearSharedData();
                                      Get.find<CartController>().clear();
                                      Get.find<CartController>()
                                          .clearCartHistory();

                                      Get.offNamed(RouteHelper.getSignInPage());
                                    } else {
                                      print("logged out");
                                    }
                                  },
                                  child: AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.logout_outlined,
                                        backgroundcolor: Colors.redAccent,
                                        size: Dimensions.height10 * 5,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        iconcolor: Colors.white,
                                      ),
                                      bigText: BigText(
                                        text: "Logout",
                                      )),
                                ),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : const CustomLoader())
            : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: Dimensions.height20 * 8,
                    margin: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                "assets/image/signintocontinue.png"))),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getSignInPage());
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: Dimensions.height20 * 5,
                      margin: EdgeInsets.only(
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor),
                      child: Center(
                          child: BigText(
                        text: "Sign In",
                        color: Colors.white,
                        size: Dimensions.font26,
                      )),
                    ),
                  )
                ],
              ),
            );
      }),
    );
  }
}
