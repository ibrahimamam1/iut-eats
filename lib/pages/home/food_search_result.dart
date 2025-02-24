import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iut_eats/base/search_container.dart';
import 'package:iut_eats/utils/dimensions.dart';
import 'package:iut_eats/widgets/big_text.dart';
import 'package:iut_eats/widgets/small_text.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_controller.dart';
import '../../controllers/search_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../widgets/icon_and_test_widget.dart';
import 'food_page_body.dart';

class FoodSearchResultPage extends StatefulWidget {
  const FoodSearchResultPage({super.key});

  @override
  State<FoodSearchResultPage> createState() => _FoodSearchResultPageState();
}

class _FoodSearchResultPageState extends State<FoodSearchResultPage> {

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  ],
                ),
              ),
            ),
            Expanded(
                child:GetBuilder<SearchProductController>(builder: (searchProduct) {
                  return searchProduct.isLoaded ?
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchProduct.searchProductList.length,
                      itemBuilder: (context, index){
                        return GestureDetector(
                          onTap: (){
                            Get.toNamed(RouteHelper.getRecommendedFood(index, "home"));
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20,bottom: Dimensions.height10),
                            child: Row(
                              children: [
                                // image section
                                Container(
                                  width: Dimensions.listViewImgSize,
                                  height: Dimensions.listViewImgSize,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                                    color: Colors.white38,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:NetworkImage(
                                            AppConstants.BASE_URL+AppConstants.UPLOAD_URL+searchProduct.searchProductList[index].img!
                                        )
                                    ),
                                  ),
                                ),


                                //text container
                                Expanded(
                                  child: Container(
                                    height: Dimensions.listViewTextContSize,

                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(Dimensions.radius20),
                                          bottomRight: Radius.circular(Dimensions.radius20),
                                        ),
                                        color: Colors.white
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          BigText(text:searchProduct.searchProductList[index].name!),
                                          SizedBox(height: Dimensions.height10),
                                          SmallText(text: "Nutritious meal, enough for one time's full meal"),
                                          SizedBox(height: Dimensions.height10),
                                          const Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconAndTestWidget(icon: Icons.circle_sharp,
                                                  text: "Normal",
                                                  iconColor: AppColors.iconColor1),
                                              IconAndTestWidget(icon: Icons.location_on,
                                                  text: "1.7km",
                                                  iconColor: AppColors.mainColor),
                                              IconAndTestWidget(icon: Icons.access_time_rounded,
                                                  text: "32 min",
                                                  iconColor: AppColors.iconColor2)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        );
                      }) : const CircularProgressIndicator(color: AppColors.mainColor);
                })
            )
          ]);

  }
}
