import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/base/custom_button.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:get/get.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderID;
  final int status;
  const OrderSuccessPage({Key? key,required this.orderID,required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if(status==0){
      Future.delayed(Duration(seconds: 1),(){
      //  Get.dialog(PaymentFailedDialog(orderID:orderID),barrierDismissible: false);
      });
    }
    return Scaffold(
      body: Center(child: SizedBox(width: Dimensions.screenWidth,child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(status==1?Icons.check_circle_outline:Icons.warning_amber_outlined,
            size: 100,color: AppColors.mainColor,),
            SizedBox(height: Dimensions.height30,),
            Container(
              padding: EdgeInsets.all(13),
              margin: EdgeInsets.only(bottom: Dimensions.height10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                color: AppColors.yellowColor,
              ),
              child: Text(
                status==1?"You place the order successfully ":"Your order failed !!",
                style: TextStyle(fontSize: Dimensions.font20,
                  color: Colors.white,),
              ),
            ),
            SizedBox(height: Dimensions.height20,),
            Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.height20,
            vertical: Dimensions.height10),
            child: Text(
              status==1?"Successful Order " : "Failed Order",
              style: TextStyle(fontSize: Dimensions.font20,
              color:Theme.of(context).disabledColor,
              ),
              textAlign: TextAlign.center,
            ),
            ),
            SizedBox(height: Dimensions.height10,),
            Padding(padding: EdgeInsets.all(Dimensions.height10),
            child: CustomButton(buttonText: "Back to Home",onPressed:
            ()=> Get.offAllNamed(RouteHelper.getInitial())
              ,),
            )

          ],
        ),),),
    );
  }
}
