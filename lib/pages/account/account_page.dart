import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/account_widget.dart';
import 'package:food_app/widgets/app_icons.dart';
import 'package:food_app/widgets/big_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: Center(
              child: BigText(
                  text: "Profile",
                  size: Dimensions.font26,
                  color: Colors.white))),
      body: Container(
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
                          text: "Ahmad",
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
                          text: "0535482243",
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
                          text: "admin@gmail.com",
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
                          text: "Ahmad",
                        )),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
