import 'package:get/get.dart';
import 'package:iut_eats/base/success_page.dart';
import 'package:iut_eats/pages/cart/cart_page.dart';
import 'package:iut_eats/pages/food/popular_food_detail.dart';
import 'package:iut_eats/pages/food/recomended_food_detail.dart';
import 'package:iut_eats/pages/splash/splash_page.dart';

import '../pages/home/home_page.dart';

class RouteHelper{
  static const String splashPage= "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String successPage = "/success-page";

  static String getSplashPage()=>splashPage;
  static String getInitial() => initial;
  static String getPopularFood(int pageId, String page) => '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) => '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage()=>cartPage;
  static String getSuccessPage()=>successPage;
  static List<GetPage> routes = [
    GetPage(name:splashPage, page: ()=> const SplashScreen()),
    GetPage(name: initial, page:()=> const HomePage()),
    GetPage(
      name:popularFood ,
      page: (){
        var pageId=Get.parameters['pageId'];
        var page = Get.parameters["page"];
        return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.fadeIn
    ),
    GetPage(
        name:recommendedFood ,
        page: (){
          var pageId=Get.parameters['pageId'];
          var page = Get.parameters["page"];
          return RecommendedFoodDetail(pageId: int.parse(pageId!),page:page!);
        },
        transition: Transition.fadeIn
    ),
    GetPage(name: cartPage, page: (){
      return const Cartpage();
    },
    transition: Transition.fadeIn),
    GetPage(name: successPage, page: (){
      return const SuccessPage();
    })
  ];
}