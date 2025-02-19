import 'package:get/get.dart';
import 'package:iut_eats/controllers/popular_product_controller.dart';
import 'package:iut_eats/controllers/recommended_controller.dart';
import 'package:iut_eats/models/product_model.dart';

import '../data/repository/recommended_product_repo.dart';
import '../data/repository/search_product_repo.dart';

class SearchProductController extends GetxController {

  final SearchProductRepo searchProductRepo;

  SearchProductController({required this.searchProductRepo});
  List<dynamic> _searchProductList=[];
  List<dynamic> get searchProductList => _searchProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  Future<void> getSearchProductList (String target) async {

    Response response = await searchProductRepo.getSearchProductList(target);
    if(response.statusCode == 200) {
      print("got products");
      _searchProductList=[];
      _searchProductList.addAll(Product.fromJson(response.body).products );
      print(_searchProductList);
      _isLoaded = true;
      update();
    } else {

    }
}
}
