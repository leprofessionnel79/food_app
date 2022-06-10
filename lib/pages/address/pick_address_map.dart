import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/base/custom_button.dart';
import 'package:food_app/controllers/location_controller.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

class PickAddressMap extends StatefulWidget {

  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;
  const PickAddressMap({Key? key, required this.fromSignup, required this.fromAddress,
  this.googleMapController}) : super(key: key);

  @override
  _PickAddressMapState createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(Get.find<LocationConroller>().addressList.isEmpty){
      _initialPosition=LatLng(45.521563, -122.677433);
      _cameraPosition=CameraPosition(target: _initialPosition,zoom: 17);
    }else{
      if(Get.find<LocationConroller>().addressList.isNotEmpty){
        _initialPosition=LatLng(double.parse(Get.find<LocationConroller>().getAddress["latitude"]),
            double.parse(Get.find<LocationConroller>().getAddress["longitude"]));
        _cameraPosition=CameraPosition(target: _initialPosition,zoom: 17);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationConroller>(builder: (locationController){
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: [
                  GoogleMap(initialCameraPosition: CameraPosition(
                      target:_initialPosition,zoom: 17
                  ),
                    zoomControlsEnabled: false,
                    onCameraMove: (CameraPosition cameraPosition){
                      _cameraPosition= cameraPosition;
                    },
                    onCameraIdle: (){
                      Get.find<LocationConroller>().updatePosition(_cameraPosition, false);
                    },
                  ),
                  Center(
                   child:!locationController.loading?Image.asset("assets/image/pick_marker.png",
                     height: 50,width: 50,):CircularProgressIndicator(color: AppColors.mainColor,)

                  ),
                  Positioned(
                    top: Dimensions.height45,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius20/2),

                      ),
                      child: Row(
                        children: [
                          Icon(Icons.location_on , size: 25,color: AppColors.yellowColor,),
                          Expanded(child: Text(
                            '${locationController.pickPlacemark.name??""}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimensions.font17,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ))
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 80,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      child: locationController.isLoading?Center(child: CircularProgressIndicator(color: AppColors.mainColor,),):
                      CustomButton(
                        buttonText: locationController.inZone?widget.fromAddress?'Pick Address':'Pick Location':'Service is not available in your area',
                        onPressed: (locationController.buttonDisabled||locationController.loading)?null:(){
                          if(locationController.pickPosition.latitude!=0&&
                              locationController.pickPlacemark.name!=null){
                            if(widget.fromAddress){
                              if(widget.googleMapController!=null){
                                print("you clicked me !!");
                                widget.googleMapController!.moveCamera(CameraUpdate.
                                newCameraPosition(CameraPosition(target: LatLng(
                                    double.parse(locationController.pickPosition.latitude.toString()),
                                    double.parse(locationController.pickPosition.longitude.toString())
                                ))));
                                locationController.setAddAddressData();
                              }
                              Get.toNamed(RouteHelper.getAddressPage());
                            }
                          }

                        },
                      )

                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
