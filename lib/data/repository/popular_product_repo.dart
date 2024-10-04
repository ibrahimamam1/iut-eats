import 'package:get/get.dart';
import 'package:iut_eats/data/api/api_client.dart';

class PopularProductRepo extends GetxService{
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async{
      return await apiClient.getData("/api/v1/products/popular");
  }
}