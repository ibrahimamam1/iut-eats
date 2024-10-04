import 'package:get/get.dart';
import 'package:iut_eats/controllers/popular_product_controller.dart';
import 'package:iut_eats/data/api/api_client.dart';
import 'package:iut_eats/data/repository/popular_product_repo.dart';

Future<void>init() async{
  //api client
  Get.lazyPut( ()=> ApiClient(appBaseUrl: "https://www.dbestech.com"));

  //repositories
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));

  //rcontrollers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
}