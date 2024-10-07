import 'package:get/get.dart';
import 'package:iut_eats/data/api/api_client.dart';
import 'package:iut_eats/utils/app_constants.dart';

class RecommendedProductRepo extends GetxService{
  final ApiClient apiClient;

  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async{
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}