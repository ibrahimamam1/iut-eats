import 'package:get/get.dart';
import 'package:iut_eats/controllers/auth_controller.dart';
import 'package:iut_eats/controllers/cart_controller.dart';
import 'package:iut_eats/controllers/location_controller.dart';
import 'package:iut_eats/controllers/popular_product_controller.dart';
import 'package:iut_eats/data/api/api_client.dart';
import 'package:iut_eats/data/repository/auth_repo.dart';
import 'package:iut_eats/data/repository/cart_repo.dart';
import 'package:iut_eats/data/repository/location_repo.dart';
import 'package:iut_eats/data/repository/popular_product_repo.dart';
import 'package:iut_eats/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/order_controller.dart';
import '../controllers/recommended_controller.dart';
import '../controllers/search_product_controller.dart';
import '../controllers/user_controller.dart';
import '../data/repository/order_repo.dart';
import '../data/repository/recommended_product_repo.dart';
import '../data/repository/search_product_repo.dart';
import '../data/repository/user_repo.dart';

Future<void>init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut( () => sharedPreferences);

  //api client
  Get.lazyPut( ()=> ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));

  //repositories
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => SearchProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(()=>LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  //controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => SearchProductController(searchProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo:Get.find()));
}