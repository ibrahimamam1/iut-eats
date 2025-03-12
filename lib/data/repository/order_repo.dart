import 'package:get/get.dart';
import 'package:iut_eats/data/api/api_client.dart';
import 'package:iut_eats/utils/app_constants.dart';

class OrderRepo extends GetxService{
  final ApiClient apiClient;

  OrderRepo({required this.apiClient});

  Future<Response> placeOrder(dynamic data) async {
    return await apiClient.postData(AppConstants.ORDER_URI, data);
  }
}