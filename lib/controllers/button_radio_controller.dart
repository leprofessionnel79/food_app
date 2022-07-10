import 'package:get/get.dart';

class ButtonRadioController extends GetxController{
  String _paymentType = "paypal";
  String get paymentType => _paymentType;

  void setPaymentType(String type){
    _paymentType=type;
    print(_paymentType);
    update();
  }
}