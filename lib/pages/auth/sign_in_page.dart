import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_app/base/custom_loader.dart';
import 'package:food_app/base/show_custom_snackbar.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/pages/auth/sign_up.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_text_field.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../controllers/user_controller.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();

      if (phone.isEmpty) {
        showCustomSnackBar("Type in your email", title: "Email");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your password", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("password couldn\'t less than 6 digits",
            title: "Password");
      } else {
        authController.login(phone, password).then((status) {
          if (status.isSuccess) {
            Get.find<UserController>().getUserInfo();
            Get.toNamed(RouteHelper.getInitial());
           
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (authController) {
          return !authController.isLoading
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.screenHeight * 0.03,
                      ),
                      //App Logo
                      Container(
                        height: Dimensions.screenHeight * 0.25,
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: Dimensions.radius20 * 4,
                            backgroundImage:
                                AssetImage("assets/image/logo part 1.png"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      // Welcome section
                      Container(
                        margin: EdgeInsets.only(left: Dimensions.width20),
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello",
                              style: TextStyle(
                                fontSize: Dimensions.font20 * 3 +
                                    Dimensions.font20 / 2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height10 / 2,
                            ),
                            RichText(
                                text: TextSpan(
                                    text: "Sign into your account",
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: Dimensions.font20,
                                    )))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      //Email
                      AppTextField(
                          textEditingController: phoneController,
                          hintText: "phone",
                          icon: Icons.phone),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      //Password
                      AppTextField(
                        textEditingController: passwordController,
                        hintText: "Password",
                        icon: Icons.password_sharp,
                        isObsecure: true,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      //Name
                      Padding(
                        padding: EdgeInsets.only(right: Dimensions.width20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RichText(
                                text: TextSpan(
                                    text: "Sign into your account",
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: Dimensions.font20,
                                    ))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height20 * 2,
                      ),

                      GestureDetector(
                        onTap: () {
                          _login(authController);

                        },
                        child: Container(
                          width: Dimensions.screenWidth / 2.4,
                          height: Dimensions.screenHeight / 13,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30),
                              color: AppColors.mainColor),
                          child: Center(
                            child: BigText(
                              text: "Sign In",
                              size: Dimensions.font20 + Dimensions.font20 / 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: Dimensions.height15,
                      ),
                      RichText(
                          text: TextSpan(
                              text: "Don\'t have an account ? ",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: Dimensions.font17 / 1.07,
                              ),
                              children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.to(() => SignUpPage(),
                                      transition: Transition.fadeIn),
                                text: "Create ",
                                style: TextStyle(
                                    color: AppColors.mainBlackColor,
                                    fontSize: Dimensions.font20,
                                    fontWeight: FontWeight.bold))
                          ])),
                    ],
                  ),
                )
              : const Center(child: CustomLoader());
        }));
  }
}
