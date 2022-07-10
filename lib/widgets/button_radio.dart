
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:get/get.dart';

import '../controllers/button_radio_controller.dart';

class ButtonRadio extends StatelessWidget {
   String title;
   String value;
   ButtonRadio({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ButtonRadioController>(builder: (buttonController){
        return InkWell(
          onTap: ()=>buttonController.setPaymentType(value),
          child: Row(
            children: [
              Radio(
                activeColor: Theme.of(context).primaryColor,
                value: value,
                onChanged: (String? value) {
                  //
                },
                groupValue: buttonController.paymentType,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              SizedBox(width: Dimensions.width10,),
              Text(title)
            ],
          ),
        );
    });
  }
}
