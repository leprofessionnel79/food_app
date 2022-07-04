import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/pages/auth/sign_in_page.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:get/get.dart';

import '../../controllers/order_controller.dart';
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
        title: Padding(
          padding:  EdgeInsets.only(left: Dimensions.width45*2),
          child: Text("My Orders"),
        ),
        backgroundColor: AppColors.mainColor,
        leading: const Icon(Icons.arrow_back),
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
    ):Center(child: Container(child: Text("Please Signe In First"),));
  }
}
