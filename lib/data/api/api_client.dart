import 'package:get/get.dart';
import 'package:iut_eats/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetConnect implements GetxService{

  late String token /*= AppConstants.TOKEN */;
  final String appBaseUrl;
  late SharedPreferences sharedPreferences;
  late Map<String , String> _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = sharedPreferences.getString(AppConstants.TOKEN)??"";
    _mainHeaders = {
      'Content-type' : 'application/json; charset=UTF-8',
      'Authorization' : 'Bearer $token',
    };
  }

  void updateHeader(String token){
    _mainHeaders = {
      'Content-type' : 'application/json; charset=UTF-8',
      'Authorization' : 'Bearer $token',
    };
  }

  Future<Response> getData(String url, {Map<String, String>? headers}) async{
    try{


      Response response = await get(url, headers: headers??_mainHeaders);
      print('Response status: ${response.statusCode}');
      return response;
    }catch(e){
      print("Could not get response dude");
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    print(body.toString());
    try{
      Response response = await post(uri, body, headers: _mainHeaders);
      return response;
    }catch(e){
      print(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}