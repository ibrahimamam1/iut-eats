import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iut_eats/controllers/cart_controller.dart';
import 'package:iut_eats/controllers/popular_product_controller.dart';
import 'package:iut_eats/pages/cart/cart_page.dart';
import 'package:iut_eats/pages/home/main_food_page.dart';
import 'package:iut_eats/utils/app_constants.dart';
import 'package:iut_eats/utils/dimensions.dart';
import 'package:iut_eats/widgets/app_icon.dart';

import '../../utils/colors.dart';
import '../../widgets/app_column.dart';
import '../../widgets/big_text.dart';
import '../../widgets/expandable_text_widget.dart';
import '../../widgets/icon_and_test_widget.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  PopularFoodDetail ({Key? key , required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    final cartController = Get.find<CartController>();
    Get.find<PopularProductController>().initProduct(product , cartController);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // cover photo
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!
                    ),
                  ),
                ),
              ),
          ),
          //Icons ex: back_arrow & shopping
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios)
                  ),

                  GetBuilder<PopularProductController>(builder: (controller) {
                    return Stack(
                      children: [
                        GestureDetector(
                            onTap: (){
                              Get.to(()=>Cartpage());
                            },
                            child: AppIcon(icon: Icons.shopping_cart_outlined)),

                        //background blue container
                        Get.find<PopularProductController>().totalItems>0?
                        Positioned(
                            right:0,
                            top:0,
                            child: AppIcon(icon: Icons.circle , size:20 , iconColor:Colors.transparent , backgroundColor:AppColors.mainColor)):
                        Container(),
                        Get.find<PopularProductController>().totalItems>0?
                            //number of items in cart
                        Positioned(
                            right:3,
                            top:3,
                            child: BigText(
                              text: Get.find<PopularProductController>().totalItems.toString(),
                              size: 12,
                            color: Colors.white,
                            )
                        ) :
                        Container()
                      ],
                    );
                  })

                ],
              ),
          ),
          //introduction of food
          Positioned(
            left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodImgSize-20,
              child: Container(

                padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20)
                  ),
                  color: Colors.white,
                ),
                child: Container(
                  padding: EdgeInsets.only(top: Dimensions.height15, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppColumn(text: product.name!),
                      SizedBox(height: Dimensions.height20),
                      BigText(text: "Introduce"),
                      SizedBox(height: Dimensions.height20,),
                      Expanded(child: SingleChildScrollView(child: ExpandableTextWidget(text: product.description!))),
                    ],
                  ),
                ),
          )
          ),
          // expandable text widget

        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){
        return Container(
          height: Dimensions.bottomHeightBar,
          padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
          decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20*2),
              topRight: Radius.circular(Dimensions.radius20*2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                            popularProduct.setQuantity(false);
                        },
                        child: Icon(Icons.remove, color: AppColors.signColor,)),
                    SizedBox(width: Dimensions.width10/2,),
                    BigText(text: popularProduct.inCartItems.toString()),
                    SizedBox(width: Dimensions.width10/2,),
                    GestureDetector(
                        onTap: () => popularProduct.setQuantity(true),
                        child: Icon(Icons.add, color: AppColors.signColor,))
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                popularProduct.addItem(product);
                  },
                child: Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                  child: BigText(text: "\$ ${product.price!} | Add to Cart", color: Colors.white,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
