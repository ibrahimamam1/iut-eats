import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iut_eats/controllers/cart_controller.dart';
import 'package:iut_eats/controllers/popular_product_controller.dart';
import 'package:iut_eats/utils/app_constants.dart';
import 'package:iut_eats/utils/dimensions.dart';
import 'package:iut_eats/widgets/app_icon.dart';

import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/app_column.dart';
import '../../widgets/big_text.dart';
import '../../widgets/expandable_text_widget.dart';

class PopularFoodDetail extends StatelessWidget {
  final  int pageId;
  final String page;
  const PopularFoodDetail ({super.key , required this.pageId, required this.page});

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
                       if(page=="cartpage"){
                         Get.toNamed(RouteHelper.getCartPage());
                       }else{
                         Get.toNamed(RouteHelper.getInitial());
                       }
                      },
                      child: const AppIcon(icon: Icons.arrow_back_ios)
                  ),

                  GetBuilder<PopularProductController>(builder: (controller) {
                    return GestureDetector(
                      onTap: (){

                        Get.toNamed(RouteHelper.getCartPage());
                      },
                      child: Stack(
                        children: [
                          const AppIcon(icon: Icons.shopping_cart_outlined,),
                          controller.totalItems>0?
                          const Positioned(
                            right: 0,
                            top: 0,
                              child: AppIcon(
                                icon: Icons.circle,
                                size: 20,
                                iconColor: Colors.transparent,
                                backgroundColor: AppColors.mainColor,
                              ),

                          ):


                          //background blue container


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
                      ),
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
                        child: const Icon(Icons.remove, color: AppColors.signColor,)),
                    SizedBox(width: Dimensions.width10/2,),
                    BigText(text: popularProduct.inCartItems.toString()),
                    SizedBox(width: Dimensions.width10/2,),
                    GestureDetector(
                        onTap: () => popularProduct.setQuantity(true),
                        child: const Icon(Icons.add, color: AppColors.signColor,))
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                popularProduct.addItem(product);
                  },
                child: Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                  child: BigText(text: "\$ ${product.price!} | Add to Cart", color: Colors.white,),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
