import 'package:get/get.dart';
import 'package:iut_eats/base/success_page.dart';
import 'package:iut_eats/pages/cart/cart_history.dart';
import 'package:iut_eats/pages/cart/cart_page.dart';
import 'package:iut_eats/pages/checkout/checkout_page.dart';
import 'package:iut_eats/pages/food/popular_food_detail.dart';
import 'package:iut_eats/pages/food/recomended_food_detail.dart';
import 'package:iut_eats/pages/home/food_search_result.dart';
import 'package:iut_eats/pages/payment/bkash_payment.dart';
import 'package:iut_eats/pages/splash/splash_page.dart';

import '../pages/address/add_address_page.dart';
import '../pages/address/pick_address_map.dart';
import '../pages/auth/sign_in_page.dart';
import '../pages/home/home_page.dart';

class RouteHelper{
  static const String splashPage= "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String searchResult = "/search-result";
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";
  static const String cartHisotryPage = "/cart-history";
  static const String checkoutPage = "/checkout";
  static const String successPage = "/success-page";
  static const String addAddress="/add-address";
  static const String pickAddressMap="/pick-address";
  static const String bkashPaymentPage="/bkash";

  static String getSplashPage()=>splashPage;
  static String getInitial() => initial;
  static String getPopularFood(int pageId, String page) => '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) => '$recommendedFood?pageId=$pageId&page=$page';
  static String getSearchResult() => searchResult;
  static String getCartPage()=>cartPage;
  static String getSignInPage() => '$signIn';
  static String getCartHistoryPage()=>cartHisotryPage;
  static String getCheckoutPage()=>checkoutPage;
  static String getSuccessPage()=>successPage;
  static String getAddressPage()=>'$addAddress';
  static String getPickAddressPage()=>'$pickAddressMap';
  static String getBkashPaymentPage()=>'$bkashPaymentPage';
  static List<GetPage> routes = [
    GetPage(name: pickAddressMap, page: () {
      var args = Get.arguments as PickAddressMap?;
      return args ?? const PickAddressMap(fromSignup: false, fromAddress: false, fromCheckout: false,);
    }),


    GetPage(name:splashPage, page: ()=> const SplashScreen()),
    GetPage(name: initial, page:()=> const HomePage(),transition: Transition.fade),
    GetPage(name: signIn, page:()=> const SignInPage(), transition: Transition.fade),
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
    GetPage(name: searchResult, page: (){
      return const FoodSearchResultPage();
    }),
    GetPage(name: cartPage, page: (){
      return const Cartpage();
    },
    transition: Transition.fadeIn
    ),
    GetPage(name: cartHisotryPage, page: (){
      return const CartHistory();
    },
        transition: Transition.fadeIn
    ),
    GetPage(name: checkoutPage, page: (){
      return CheckoutPage();
    },
        transition: Transition.fadeIn
    ),
    GetPage(name: successPage, page: (){
      return const SuccessPage();
    }),
    GetPage(name: bkashPaymentPage, page: (){
      return const BkashPaymentPage();
    }),
    GetPage(name: addAddress, page:(){
      return const AddAddressPage();
    })

  ];
}