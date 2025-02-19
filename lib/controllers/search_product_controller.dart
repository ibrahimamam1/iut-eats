import 'package:get/get.dart';
import 'package:iut_eats/controllers/popular_product_controller.dart';
import 'package:iut_eats/controllers/recommended_controller.dart';
import 'package:iut_eats/models/product_model.dart';

import '../data/repository/recommended_product_repo.dart';

class SearchProductController extends GetxController {

  SearchProductController();
  List<dynamic> _recommendedProductList= Get.find<RecommendedProductController>().recommendedProductList;
  List<dynamic> _popularProductList= Get.find<PopularProductController>().popularProductList;
  List<dynamic> searchProductList=[];

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  void getSearchProductList(String target){

    for(int i=0; i<_recommendedProductList.length; i++){
      print(_recommendedProductList[i]);
    }

    for(int i=0; i<_popularProductList.length; i++){

    }

    //TODO : Set value of search Container

    //Todo : Pass it to Searcg Result Screen
  }
}
