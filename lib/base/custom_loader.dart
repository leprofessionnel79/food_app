import 'package:flutter/material.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:get/get.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height100,
      width: Dimensions.height100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.height100 / 2),
        color: AppColors.mainColor,
      ),
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}
