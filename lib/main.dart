import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iut_eats/controllers/recommended_controller.dart';
import 'package:iut_eats/pages/cart/cart_page.dart';
import 'package:iut_eats/pages/food/popular_food_detail.dart';
import 'package:iut_eats/pages/food/recomended_food_detail.dart';
import 'package:iut_eats/pages/home/food_page_body.dart';
import 'package:iut_eats/pages/home/main_food_page.dart';
import 'package:iut_eats/pages/splash/splash_page.dart';
import 'package:iut_eats/routes/route_helper.dart';
import 'controllers/popular_product_controller.dart';
import 'helper/dependencies.dart' as dep;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


  return GetBuilder<PopularProductController>(builder: (_){
    return GetBuilder<RecommendedProductController>(builder: (_){
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'IUT Eats',
        //home: MainFoodPage(),
        //home: SplashScreen(),
        initialRoute: RouteHelper.getSplashPage(),
        getPages: RouteHelper.routes,
      );

    });
  });
  }
}



