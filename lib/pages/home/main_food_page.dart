import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iut_eats/base/search_container.dart';
import 'package:iut_eats/pages/home/food_search_result.dart';
import 'package:iut_eats/routes/route_helper.dart';
import 'package:iut_eats/utils/dimensions.dart';
import 'package:iut_eats/widgets/big_text.dart';
import 'package:iut_eats/widgets/small_text.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_controller.dart';
import '../../utils/colors.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void>_loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return RefreshIndicator(
        child: Column(
      children: [
        //showing the header
        Container(

          child: Container(
            margin: EdgeInsets.only(top: Dimensions.height45, bottom: Dimensions.height15),
            padding: EdgeInsets.only(left: Dimensions.width20, right:  Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(text: "Bangladesh", color: AppColors.mainColor,),  // A country name will be uploaded in future
                    Row(
                      children: [
                        SmallText(text: "Gazipur", color: Colors.black54,), // add a city
                        const Icon(Icons.arrow_drop_down_rounded)
                      ],
                    )
                  ],
                ),
                Center(
                  child: AppSearchContainer(onSearch: _performSearch, searchController: searchController)
                  ),
              ],
            ),
          ),
        ),
        //showing the body
        const Expanded(child: SingleChildScrollView(
          child: FoodPageBody(),
        )),
      ],
    ),
        onRefresh: _loadResource);
  }
}

void _performSearch(String searchTerm) {

  //option 1 : search from the already loaded arrays, save previous value in arrays and replace them with only matching items, if user goes back reload previously saved values in array

  //option 2 : get only matching items from database into arrays, if user goes back reload all items from database back into array
  print("yolo???");
  Get.toNamed(RouteHelper.getSearchResult());
}