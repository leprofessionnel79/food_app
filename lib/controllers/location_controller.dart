import 'dart:convert';

import 'package:food_app/data/repository/location_repo.dart';
import 'package:food_app/models/address_model.dart';
import 'package:food_app/models/response_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationConroller extends GetxController implements GetxService {
  LocationRepo locationRepo;

  LocationConroller({required this.locationRepo});

  bool _loading = false;
  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;

  late Position _position;
  late Position _pickPosition;

  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();
  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddressList;
  List<AddressModel> get allAddressList=>_allAddressList;
  List<String> _addressTypeList = ["home", "office", "others"];
  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;

  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;

  Placemark get placemark => _placemark;
  Placemark get pickPlacemark => _pickPlacemark;

  late GoogleMapController _mapController;
  GoogleMapController get mapController=>_mapController;
  bool _updateAddressData = true;
  bool _changeAddress = true;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  Future<void> updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      update();

      try {
        if (fromAddress) {
          _position = Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        } else {
          _pickPosition = Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        }

        if (_changeAddress) {
          String _address = await getAddressFromGeocode(
              LatLng(position.target.latitude, position.target.longitude));

          fromAddress?_placemark=Placemark(name: _address)
          :_pickPlacemark=Placemark(name: _address);

        }

      } catch (e) {
        print(e);
      }
      _loading=false;
      update();
    }
  }

  Future<String> getAddressFromGeocode(LatLng latLng) async {
    String _address = "Unknown Location Found";

    Response response = await locationRepo.getAddressFromGeocode(latLng);

    if (response.body["status"] == 'OK') {
      _address = response.body["results"][0]['formatted_address'].toString();

      print("printing address inf " + _address);
    } else {
      print("error getting google api");
    }
    update();
    return _address;
  }

  AddressModel getUserAddress(){
   late AddressModel _addressModel;
   _getAddress = jsonDecode(locationRepo.getUserAddress());

   try{
     _addressModel=AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));

   }catch(e){
     print(e);
   }
   return _addressModel;
  }

  void setAddressTypeIndex(int index){
    _addressTypeIndex=index;
    update();
  }

 Future<ResponseModel> addAddress(AddressModel addressModel)async {
    _loading=true;
    update();

    Response response= await locationRepo.addAddress(addressModel);
    ResponseModel responseModel ;
    if(response.statusCode==200){
     await getAddressList();
      String message = response.body["message"];
      responseModel = ResponseModel(message,true);
     await saveUserAddress(addressModel);
    }else{
      print("Couldn't save the address");
      responseModel = ResponseModel(response.statusText!,false);
    }
    update();
    return responseModel;
  }

  Future<void>getAddressList() async{
    Response response= await locationRepo.getAllAddress();
    if(response.statusCode==200){
        _addressList=[];
        _allAddressList=[];

        response.body.forEach((address){
          _addressList.add(AddressModel.fromJson(address));
          _allAddressList.add(AddressModel.fromJson(address));
        });

    }else{
      _addressList=[];
      _allAddressList=[];
    }
    update();
  }

  Future<bool> saveUserAddress(AddressModel addressModel)async {
    String userAddress = jsonEncode(addressModel.toJson());
   return await  locationRepo.saveUserAddress(userAddress);
  }

  void clearAddressList(){
    _addressList=[];
    _allAddressList=[];
    update();
  }

  String getUserAddressFromLocalStorage(){
    return locationRepo.getUserAddress();
  }
}
