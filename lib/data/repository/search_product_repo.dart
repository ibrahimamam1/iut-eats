import 'package:get/get.dart';
import 'package:iut_eats/data/api/api_client.dart';
import 'package:iut_eats/utils/app_constants.dart';

class SearchProductRepo extends GetxService{
  final ApiClient apiClient;

  SearchProductRepo({required this.apiClient});

  Future<Response> getSearchProductList(String target) async{
    return await apiClient.getData(AppConstants.SEARCH_PRODUCT_URI + target);
  }
}