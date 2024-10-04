import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iut_eats/pages/food/popular_food_detail.dart';
import 'package:iut_eats/pages/food/recomended_food_detail.dart';
import 'package:iut_eats/pages/home/food_page_body.dart';
import 'package:iut_eats/pages/home/main_food_page.dart';
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
    Get.find<PopularProductController>().getPopularProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IUT Eats',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainFoodPage(),
    );
  }
}



