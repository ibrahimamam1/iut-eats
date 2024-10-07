import 'package:get/get.dart';
import 'package:iut_eats/controllers/popular_product_controller.dart';
import 'package:iut_eats/data/api/api_client.dart';
import 'package:iut_eats/data/repository/popular_product_repo.dart';
import 'package:iut_eats/utils/app_constants.dart';

import '../controllers/recommended_controller.dart';
import '../data/repository/recommended_product_repo.dart';

Future<void>init() async {
  //api client
  Get.lazyPut( ()=> ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repositories
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));

  //rcontrollers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
}