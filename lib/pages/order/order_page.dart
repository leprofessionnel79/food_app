import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/pages/auth/sign_in_page.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:get/get.dart';

import '../../controllers/order_controller.dart';
import '../../widgets/big_text.dart';
import 'order_view.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin{
  late TabController _tabController;
  late bool _isLoggedIn;

  @override
  void initState(){
    super.initState();
    _isLoggedIn=Get.find<AuthController>().userLoggedIn();
    if(_isLoggedIn){
      _tabController = TabController(length: 2, vsync: this);
      Get.find<OrderController>().getOrderList();
    }
    // else{
    //   Get.toNamed(RouteHelper.getSignInPage());
    // }
  }

  @override
  Widget build(BuildContext context) {

    return _isLoggedIn?Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("My Orders"),
        ),
        backgroundColor: AppColors.mainColor,
        //leading: const Icon(Icons.arrow_back),
      ),
      body: Column(
        children: [
          Container(
            width: Dimensions.screenWidth,
            child: TabBar(
              indicatorColor: Theme.of(context).primaryColor,
              indicatorWeight: 3,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: AppColors.yellowColor,
              controller: _tabController,
              tabs: const [
                Tab(text: "current",),
                Tab(text:"history")
            ],
            ),
          ),
          Expanded(
            child: TabBarView(
                controller: _tabController,
                children: const [
                  ViewOrder(isCurrent: true),
                  ViewOrder(isCurrent: false)
                ]),
          )
        ],
      ),
    ):Center(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Container(
            height: Dimensions.height10*9,
            width: double.maxFinite,
            color: AppColors.mainColor,
            //padding: EdgeInsets.only(top: Dimensions.height45),
            child:Center(
              child: Container(
                margin: EdgeInsets.only(top: Dimensions.height30),
                child: BigText(
                  text: "My Orders",
                  color: Colors.white,
                  size: Dimensions.font26,
                ),
              ),
            ),
          ),
          Container(
            width: double.maxFinite,
            height: Dimensions.height20 * 8,
            margin: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20,
            top: Dimensions.height120
            ),
            decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(Dimensions.radius20),
                image: const DecorationImage(
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
  }
}
