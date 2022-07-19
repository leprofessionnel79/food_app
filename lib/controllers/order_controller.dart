import 'package:food_app/data/repository/order_repo.dart';
import 'package:food_app/models/order_model.dart';
import 'package:food_app/models/place_order_model.dart';
import 'package:get/get.dart';

class OrderController extends GetxController implements GetxService{
 OrderRepo orderRepo;
 OrderController({required this.orderRepo});

 bool _isLoading = false;
 bool get isLoading => _isLoading;
 int _paymentIndex = 0 ;
 int get paymentIndex => _paymentIndex;

 String _orderType="delivery";
 String get orderType=>_orderType;

 String _foodnote =" ";
 String get foodnote => _foodnote;

 late List<OrderModel> _currentOrderList;
 late List<OrderModel> _historyOrderList;
 List<OrderModel> get currentOrderList =>_currentOrderList;
 List<OrderModel> get historyOrderList =>_historyOrderList;


 Future<void> placeOrder(PlaceOrderBody placeOrder,Function callBack)async{
   _isLoading=true;
   Response response = await orderRepo.placeOrder(placeOrder);

   if(response.statusCode==200){
     _isLoading=false;
     String message = response.body['message'].toString();
     String orderID = response.body['order_id'].toString();

     callBack(true, message,orderID);
   }else{
     callBack(false, response.statusText!,'-1');
   }
 }

  Future<void> getOrderList() async{
     _isLoading=true;
    Response response = await orderRepo.getOrderList();
    if(response.statusCode==200){
      _currentOrderList=[];
      _historyOrderList=[];

      response.body.forEach((order){
        OrderModel orderModel = OrderModel.fromJson(order);
        if(orderModel.orderStatus=="pending"||
            orderModel.orderStatus=="accepted"||
            orderModel.orderStatus=="handover"||
            orderModel.orderStatus=="processing"||
            orderModel.orderStatus=="picked_up"
        )
        {
           _currentOrderList.add(orderModel);
        }else{
          _historyOrderList.add(orderModel);
        }
      }
      );

    }else{
     _historyOrderList=[];
     _currentOrderList=[];
    }
    _isLoading=false;
    update();
  }

  void setPaymentIndex(int index){
   _paymentIndex = index;
   update();
  }

  void setDeliveryType(String type){
   _orderType=type;
   update();
  }

  void setFoodNote(String note){
   _foodnote = note;
   update();
  }

}