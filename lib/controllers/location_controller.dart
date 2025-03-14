import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iut_eats/data/api/api_checker.dart';
import 'package:iut_eats/data/repository/location_repo.dart';

import '../models/address_model.dart';
import '../models/prediction_model.dart';
import '../models/response_model.dart';
import 'package:google_maps_webservice/src/places.dart';

class LocationController extends GetxController implements GetxService{
   LocationRepo locationRepo;
   LocationController({required this.locationRepo});
   bool  _loading = false;
   late Position _position;
   late Position _pickPosition;
   Placemark _placemark = Placemark();
   Placemark _pickPlacemark = Placemark();
   Placemark get placemark=> _placemark;
   Placemark get pickPlacemark => _pickPlacemark;
   List<AddressModel> _addressList=[];
   List<AddressModel> get addressList=>_addressList;
   late List<AddressModel>_allAddressList;
   List<AddressModel>get allAddressList=>_allAddressList;

   final List<String>_addressTypeList=["home","office","others"];
   List<String> get addressTypeList=>_addressTypeList;
   int _addressTypeIndex=0;
   int get addressTypeIndex => _addressTypeIndex;

   late GoogleMapController _mapController;
   GoogleMapController get mapController=>_mapController;
   bool _updateAddressData=true;
   bool _changeAddress=true;

   bool get loading => _loading;
   Position get position => _position;
   Position get pickPosition => _pickPosition;
/*for service zone*/
   bool _isLoading = false;
   bool get isLoading => _isLoading;
   bool _inZone = true; // check if in service zone
   bool get inZone => _inZone;
   bool _buttonDisabled = false;
   bool get buttonDisabled => _buttonDisabled;
   void setMapController(GoogleMapController mapController){
      _mapController=mapController;
   }

   void updatePosition(CameraPosition position, bool fromAddress) async {
      if (_updateAddressData) {
         _loading = true;
         update();
         try {
            if (fromAddress) {
               _position = Position(
                  latitude: position.target.latitude,
                  longitude: position.target.longitude,
                  timestamp: DateTime.now(),
                  heading: 1,
                  accuracy: 1,
                  altitude: 1,
                  speedAccuracy: 1,
                  speed: 1, altitudeAccuracy: 1, headingAccuracy: 1
               );
            } else {
               _pickPosition = Position(
                  latitude: position.target.latitude,
                  longitude: position.target.longitude,
                  timestamp: DateTime.now(),
                  heading: 1,
                  accuracy: 1,
                  altitude: 1,
                  speedAccuracy: 1,
                  speed: 1,
                   altitudeAccuracy: 1, headingAccuracy: 1
               );
            }
            ResponseModel _responseModel=
                await getZone(position.target.latitude.toString(), position.target.longitude.toString(), false);
            /*if button value is false we in service zone*/
            _buttonDisabled=!_responseModel.isSuccess;
            if(_changeAddress){
               String _address = await getAddressfromGeocode(
                 LatLng(
                    position.target.latitude,
                    position.target.longitude
                 )
               );
               fromAddress?_placemark=Placemark(name:_address):
                   _pickPlacemark=Placemark(name:_address);

            }else{
               _changeAddress = true;
            }
         } catch (e) {
            print(e);
         }
         _loading=false;
         update();
      }
   }
   Future<String> getAddressfromGeocode(LatLng latlng) async {
      String _address ="Unknown Location Found";
      Response response = await locationRepo.getAddressfromGeocode(latlng);
      if(response.body["status"]=='OK'){
         _address = response.body["results"][0]['formatted_address'].toString();
         print("printing address "+_address);
      }else{
         print("Error getting the google api");
         print(response.body);

      }
      update();
      return _address;
   }
   late Map<String, dynamic> _getAddress;
   Map get getAddress=>_getAddress;

   AddressModel getUserAddress(){
      late AddressModel _addressModel;
      /*converting to map using jsonDecode */
      _getAddress = jsonDecode(locationRepo.getUserAddress());
      try{
         _addressModel = AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
      }catch(e){
         print(e);
      }
      return _addressModel;
   }
   void setAddressTypeIndex(int index){
      _addressTypeIndex=index;
      update();
   }

   Future<ResponseModel> addAddress(AddressModel addressModel)async{
      _loading = true;
      update();
      Response response = await locationRepo.addAddress(addressModel);
      ResponseModel responseModel;
      if(response.statusCode==200){
       await  getAddressList();
         String message = response.body["message"];
         responseModel = ResponseModel(true, message);
      await   saveUserAddress(addressModel);

      //if after successful add we want to go to cart page
        Get.offNamed('/home');

      }else{
         print("couldn't save the address");
         responseModel = ResponseModel(false, response.statusText!);
      }
      update();
      return responseModel;
   }

   Future<void> getAddressList()async{
      Response response = await locationRepo.getAllAddress();
      if(response.statusCode==200){
         _addressList=[];
         _allAddressList=[];
         response.body.forEach((address){
            _addressList.add(AddressModel.fromJson(address));
            _allAddressList.add(AddressModel.fromJson(address));
         });
         print(".......added......."+_addressList.toString());
      }else{
         _addressList=[];
         _allAddressList=[];
      }
      update();

   }
   Future<bool>saveUserAddress(AddressModel addressModel)async{
      String userAddress = jsonEncode(addressModel.toJson());
      return await locationRepo.saveUserAddress(userAddress);
   }
   void clearAddressList(){
      _addressList=[];
      _allAddressList=[];
      update();
   }
   String getUserAddressFromLocalStorage(){
      return locationRepo.getUserAddress();
   }
  void setAddressData(){
      _position=_pickPosition;
      _placemark=_pickPlacemark;
      _updateAddressData=false;
      print("location controller: set address data: new address: " + _placemark.name!);
      update();
   }
   Future<ResponseModel>getZone(String lat, String lng, bool markerLoad)async{
      late ResponseModel _responseModel;
      if(markerLoad){
         _loading = true;
      }else{
         _isLoading=true;
       }
      update();
      // update();
      // await Future.delayed(const Duration(seconds: 2),(){
      //    _responseModel = ResponseModel(true, "success");
      //    if(markerLoad){
      //       _loading=false;
      //
      //    }else{
      //       _isLoading=false;
      //    }
      //     _inZone = true;
      // });

      Response response = await locationRepo.getZone(lat, lng);
      if(response.statusCode==200){
         _inZone=true;
         _responseModel = ResponseModel(true, response.body["zone_id"].toString());
      }else{
         _inZone = true;
         _responseModel = ResponseModel(true, response.statusText!);
      }
      if(markerLoad){
         _loading = false;
      }else{
         _isLoading=false;
      }

      //debug purpose
      print(response.statusCode); //200 , 404, 500, 403
      update();
      return _responseModel;
   }

   List<NewPrediction> _predictionList = [];

   Future<List<NewPrediction>> searchLocation(BuildContext context, String text) async {
      if (text.isNotEmpty) {
         Response response = await locationRepo.searchLocation(text);
         print(response.body.toString());
         if (response.statusCode == 200) {
            _predictionList = [];
            final suggestions = response.body['suggestions'] as List<dynamic>;
            suggestions.forEach((suggestion) {
               _predictionList.add(NewPrediction.fromJson(suggestion));
            });
         } else {
            ApiChecker.checkApi(response);
         }
      }
      return _predictionList;
   }

   setLocation(String placeID, String address, GoogleMapController mapController) async {
      // Set loading state to true and update UI
      _loading = true;
      update();

      print("setting location for: " + address);

      // Fetch place details from the repository
      Response response = await locationRepo.setLocation(placeID);
      print('got details response');
      print(response.body.toString());

      // Since response.body is a Map<String, dynamic> with GetX, access location fields
      Map<String, dynamic> placeDetails = response.body;

      // Check if location data exists to avoid errors
      if (placeDetails.containsKey('location')) {
         double latitude = placeDetails['location']['latitude'];
         double longitude = placeDetails['location']['longitude'];

         // Update the position with the new coordinates
         _pickPosition = Position(
            latitude: latitude,
            longitude: longitude,
            timestamp: DateTime.now(),
            accuracy: 1,
            altitude: 1,
            heading: 1,
            speed: 1,
            speedAccuracy: 1,
            altitudeAccuracy: 1,
            headingAccuracy: 1,
         );

         // Set the placemark using the provided address (from autocomplete)
         _pickPlacemark = Placemark(name: address);

         // Reset address change flag
         _changeAddress = false;

         // Move the map camera to the new location if controller is available
         if (!mapController.isNull) {
            mapController.animateCamera(CameraUpdate.newCameraPosition(
               CameraPosition(target: LatLng(latitude, longitude), zoom: 17),
            ));
         }
      } else {
         print('Location data not found in response');
         // Optionally, add error handling (e.g., show a snackbar to the user)
      }

      // Reset loading state and update UI
      _loading = false;
      update();
   }
}