import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData icon;
  bool maxLines;
  bool isObsecure;
   AppTextField(
      {Key? key,
      required this.textEditingController,
      required this.hintText,
      required this.icon,
      this.isObsecure=false,
        this.maxLines=false
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

        margin: EdgeInsets.only(
            left: Dimensions.width20, right: Dimensions.width20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                spreadRadius: 1,
                offset: Offset(1, 1),
                color: Colors.grey.withOpacity(0.2),
              )
            ]),
        child: TextField(
          maxLines: maxLines?3:1,
          obscureText: isObsecure?true:false,
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(
              icon,
              color: AppColors.yellowColor,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              borderSide: const BorderSide(color: Colors.white, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              borderSide: const BorderSide(color: Colors.white, width: 1.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
            ),
          ),
        ));
  }
}
