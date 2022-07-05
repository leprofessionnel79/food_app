import 'dart:async';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../base/custom_button.dart';
import '../../models/order_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import 'package:get/get.dart';

class PaymentPage extends StatefulWidget {
  final OrderModel orderModel;
  PaymentPage({required this.orderModel});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late String selectedUrl;
  double value = 0.0;
  bool _canRedirect = true;
  bool _isLoading = true;
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  late WebViewController controllerGlobal;

  @override
  void initState() {
    super.initState();
    selectedUrl = '${AppConstants.BASE_URL}/payment-mobile?customer_id=${widget.orderModel.userId}&order_id=${widget.orderModel.id}';
    //selectedUrl="https://mvs.bslmeiyu.com";
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Align(
              alignment: Alignment.center,
              child: Text("Payment")),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed:()=> _exitApp(context),
          ),
          backgroundColor: AppColors.mainColor,
        ),
        body: Center(  // in this section u can set the cash pay method
          child: Container(
            width: Dimensions.screenWidth,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle_outline,
                          size: 100,color: AppColors.mainColor,),
                        SizedBox(height: Dimensions.height30,),
                        Text(
                          "You place the order successfully ",
                          style: TextStyle(fontSize: Dimensions.font20),
                        ),
                        SizedBox(height: Dimensions.height20,),
                        Text(
                          "Its Cash ON Delivery ",
                          style: TextStyle(fontSize: Dimensions.font20),
                        ),
                        SizedBox(height: Dimensions.height20,),

                     SizedBox(
                        width: Dimensions.screenWidth/2,
                       child: Padding(padding: EdgeInsets.only(
                        top:Dimensions.height10,
                        right: Dimensions.height20,
                      //left: Dimensions.height20
                      ),
                          child: CustomButton(buttonText: "Back to Home",onPressed:
                          ()=> Get.offAllNamed(RouteHelper.getInitial())
                        ,),
                    ),
              ),

                      ],
                    ),


               //-------------------- PAYPAL METHOD ----------------------------

                // if you want paypal method payment uncomment WebView section and comment
                // which above
                // WebView(
                //   javascriptMode: JavascriptMode.unrestricted,
                //   initialUrl: selectedUrl,
                //   gestureNavigationEnabled: true,
                //
                //   userAgent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 9_3 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E233 Safari/601.1',
                //   onWebViewCreated: (WebViewController webViewController) {
                //     _controller.future.then((value) => controllerGlobal = value);
                //     _controller.complete(webViewController);
                //     //_controller.future.catchError(onError)
                //   },
                //   onProgress: (int progress) {
                //     print("WebView is loading (progress : $progress%)");
                //   },
                //   onPageStarted: (String url) {
                //     print('Page started loading: $url');
                //     setState(() {
                //       _isLoading = true;
                //     });
                //     print("printing urls "+url.toString());
                //     _redirect(url);
                //
                //   },
                //   onPageFinished: (String url) {
                //     print('Page finished loading: $url');
                //     setState(() {
                //       _isLoading = false;
                //     });
                //     _redirect(url);
                //
                //   },
                // ),
                // for paypal method you have remove "!" from _isLoading in next line
                !_isLoading ? Center(
                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
                ) : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _redirect(String url) {
    print("redirect");
    if(_canRedirect) {
      bool _isSuccess = url.contains('success');//&& url.contains(AppConstants.BASE_URL);
      print("success is "+_isSuccess.toString());
      print("url is  "+url);
      bool _isFailed = url.contains('fail') && url.contains(AppConstants.BASE_URL);
      bool _isCancel = url.contains('cancel') && url.contains(AppConstants.BASE_URL);
      if (_isSuccess || _isFailed || _isCancel) {
        _canRedirect = false;
      }
      if (_isSuccess) {

        Get.offNamed(RouteHelper.getOrderSuccessPage(widget.orderModel.id.toString(), 'success'));
      } else if (_isFailed || _isCancel) {
        Get.offNamed(RouteHelper.getOrderSuccessPage(widget.orderModel.id.toString(), 'fail'));
      }else{
        print("Encountered problem");
      }
    }
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (await controllerGlobal.canGoBack()) {
      controllerGlobal.goBack();
      return Future.value(false);
    } else {
      print("app exited");
      return true;
      // return Get.dialog(PaymentFailedDialog(orderID: widget.orderModel.id.toString()));
    }
  }

}