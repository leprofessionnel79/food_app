import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/controllers/location_controller.dart';
import 'package:food_app/controllers/user_controller.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_text_field.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(45.51563, -122.677433), zoom: 17);

  late LatLng _initialPosition = LatLng(45.51563, -122.677433);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }

    if (Get.find<LocationConroller>().addressList.isNotEmpty) {
      _cameraPosition = CameraPosition(
          target: LatLng(
              double.parse(
                  Get.find<LocationConroller>().getAddress["latitude"]),
              double.parse(
                  Get.find<LocationConroller>().getAddress["longitude"])));

      _initialPosition = LatLng(
          double.parse(Get.find<LocationConroller>().getAddress["latitude"]),
          double.parse(Get.find<LocationConroller>().getAddress["longitude"]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
            alignment: Alignment.center,
            child: Text("Address Page")),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(builder: (userController){
        if(userController.userModel!=null&& _contactPersonName.text.isEmpty){
          _contactPersonName.text = '${userController.userModel?.name}';
          _contactPersonNumber.text =  '${userController.userModel?.phone}';

          if(Get.find<LocationConroller>().addressList.isNotEmpty){
             _addressController.text = Get.find<LocationConroller>().getUserAddress().address;
          }
        }
        return GetBuilder<LocationConroller>(builder: (locationcontroller) {
          _addressController.text = '${locationcontroller.placemark.name??''}'
              '${locationcontroller.placemark.locality??''}'
              '${locationcontroller.placemark.postalCode??''}'
              '${locationcontroller.placemark.country??''}';
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20 / 4),
                      border: Border.all(width: 2, color: AppColors.mainColor)),
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition:
                        CameraPosition(target: _initialPosition, zoom: 17),
                        zoomControlsEnabled: false,
                        mapToolbarEnabled: false,
                        compassEnabled: false,
                        indoorViewEnabled: true,
                        onCameraIdle: () {
                          locationcontroller.updatePosition(_cameraPosition, true);
                        },
                        onCameraMove: ((position) => _cameraPosition = position),
                        onMapCreated: (GoogleMapController controller) {
                          locationcontroller.setMapController(controller);
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: Dimensions.width20,top: Dimensions.height10),
                  child: SizedBox(height: Dimensions.width20*2,child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: locationcontroller.addressTypeList.length,
                      itemBuilder:(context,index){
                    return InkWell(
                      onTap: (){
                        locationcontroller.setAddressTypeIndex(index);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width20,
                        vertical: Dimensions.height10),
                        margin: EdgeInsets.only(right: Dimensions.width20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                          color: Theme.of(context).cardColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[200]!,
                              spreadRadius: 1,
                              blurRadius: 5,
                            )
                          ]
                        ),
                        child:Icon(
                          index==0?Icons.home_filled:index==1?Icons.work:Icons.location_on,
                          color: locationcontroller.addressTypeIndex==index?AppColors.mainColor:Theme.of(context).disabledColor,
                        ),
                      ),
                    );
                  })),
                ),
                SizedBox(height: Dimensions.height10,),
                Padding(
                    padding: EdgeInsets.only(left: Dimensions.width20),
                    child: BigText(text: "Delivery Address")),
                SizedBox(height: Dimensions.height10,),
                AppTextField(textEditingController: _addressController, hintText: "Your Address", icon: Icons.map),
                SizedBox(height: Dimensions.height20,),
                Padding(
                    padding: EdgeInsets.only(left: Dimensions.width20),
                    child: BigText(text: "Contact Name")),
                SizedBox(height: Dimensions.height10,),
                AppTextField(textEditingController: _contactPersonName, hintText: "Your Name", icon: Icons.person),
                SizedBox(height: Dimensions.height20,),
                Padding(
                    padding: EdgeInsets.only(left: Dimensions.width20),
                    child: BigText(text: "Contact Number")),
                SizedBox(height: Dimensions.height10,),
                AppTextField(textEditingController: _contactPersonNumber, hintText: "Your Phone", icon: Icons.phone),
              ],
            ),
          );
        });
      }),

    );
  }
}
