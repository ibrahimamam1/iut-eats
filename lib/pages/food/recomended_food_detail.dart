import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iut_eats/controllers/cart_controller.dart';
import 'package:iut_eats/controllers/popular_product_controller.dart';
import 'package:iut_eats/controllers/recommended_controller.dart';
import 'package:iut_eats/routes/route_helper.dart';
import 'package:iut_eats/utils/app_constants.dart';
import 'package:iut_eats/widgets/app_icon.dart';
import 'package:iut_eats/widgets/expandable_text_widget.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
   const RecommendedFoodDetail({super.key , required this.pageId, required this.page});
 
   @override
   Widget build(BuildContext context) {
     var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
     Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());
     return Scaffold(
       backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: (){
                        if(page=="cartpage"){
                          Get.toNamed(RouteHelper.getCartPage());
                        }else{
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: const AppIcon(icon: Icons.clear)),
                  //AppIcon(icon: Icons.shopping_cart_outlined),
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return Stack(
                      children: [
                        GestureDetector(
                            onTap: (){
                              Get.toNamed(RouteHelper.getCartPage());
                            },
                            child: const AppIcon(icon: Icons.shopping_cart_outlined)),

                        //background blue container
                        Get.find<PopularProductController>().totalItems>0?
                        const Positioned(
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
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(20),
                child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(top: 5 , bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft:  Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20)
                    )
                  ),
                  child: Center(
                    child : BigText(size : Dimensions.font26, text : product.name!)
                  ),
                ),
              ),
              pinned: true,
              backgroundColor: AppColors.yellowColor,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.width20 , right: Dimensions.width20),
                    child: ExpandableTextWidget(text : product.description!),
                    ),
                ],
              ),
            )
          ],
        ),
       bottomNavigationBar: GetBuilder<PopularProductController>(
         builder: (controller){
         return  Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             Container(
               padding: EdgeInsets.only(
                 left: Dimensions.width20*2.5,
                 right: Dimensions.width20*2.5,
                 top: Dimensions.height10,
                 bottom: Dimensions.height10,
               ),
              child : Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 GestureDetector(
                   onTap: (){
                     controller.setQuantity(false);
                   },
                   child: AppIcon(
                     iconColor: Colors.white ,
                     backgroundColor: AppColors.mainColor ,
                     icon: Icons.remove,
                     iconSize : Dimensions.iconSize24,
                   ),
                 ),
                 
                 BigText(text: "\$ ${product.price!} X ${controller.inCartItems}"  , color: AppColors.mainBlackColor, size: Dimensions.font26,),
                 
                 GestureDetector(
                   onTap: (){
                     controller.setQuantity(true);
                   },
                   child: AppIcon(
                     iconColor: Colors.white ,
                     backgroundColor: AppColors.mainColor ,
                     icon: Icons.add,
                     iconSize : Dimensions.iconSize24,
                   ),
                 ),
               ],
             )
             ),
             Container(
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
                     child: const Icon(Icons.favorite , color: AppColors.mainColor)
                   ),
                   GestureDetector(
                     onTap: (){
                       controller.addItem(product);
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
             ),
           ],
         );}
       ),
     );
   }
 }
 