import 'package:get/get.dart';
import 'package:iut_eats/models/product_model.dart';

import '../data/repository/recommended_product_repo.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList=[];
  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  Future<void> getRecommendedProductList() async {
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode == 200) {
      print("got products");
      _recommendedProductList=[];
      _recommendedProductList.addAll(Product.fromJson(response.body).products );
      //print(_popularProductList);
      _isLoaded = true;
      update();
    } else {
    }
  }
}
