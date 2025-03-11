import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iut_eats/data/api/api_client.dart';
import 'package:iut_eats/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../../models/address_model.dart';
class LocationRepo{

  final ApiClient apiClient;

  final SharedPreferences sharedPreferences;

  LocationRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getAddressfromGeocode(LatLng latlng) async {
    return await apiClient.getData('${AppConstants.GEOCODE_URI}'
       '?lat=${latlng.latitude}&lng=${latlng.longitude}'
    );
  }

  String getUserAddress(){
    return sharedPreferences.getString(AppConstants.User_ADDRESS)??"";
  }
  Future<Response>addAddress(AddressModel addressModel)async{
    return await apiClient.postData(AppConstants.ADD_USER_ADDRESS, addressModel.toJson());
  }
  Future<Response>getAllAddress()async{
    return await apiClient.getData(AppConstants.ADDRESS_LIST_URI);
  }
  Future <bool> saveUserAddress(String address)async{
    apiClient.updateHeader(sharedPreferences.getString(AppConstants.TOKEN)!);
    return await sharedPreferences.setString(AppConstants.User_ADDRESS,address);
  }
  Future<Response>getZone(String lat, String lng)async{
    return await apiClient.getData('${AppConstants.ZONE_URI}?lat=$lat&lng=$lng');
  }

  Future<Response> searchLocation(String text) async {
    return await apiClient.getData('${AppConstants.SEARCH_LOCATION_URI}?search_text=$text');
  }
}