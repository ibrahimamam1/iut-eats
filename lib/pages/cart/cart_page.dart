import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iut_eats/base/no_data_page.dart';
import 'package:iut_eats/controllers/auth_controller.dart';
import 'package:iut_eats/controllers/cart_controller.dart';
import 'package:iut_eats/controllers/popular_product_controller.dart';
import 'package:iut_eats/controllers/recommended_controller.dart';
import 'package:iut_eats/utils/app_constants.dart';
import 'package:iut_eats/widgets/app_icon.dart';
import 'package:iut_eats/widgets/big_text.dart';
import 'package:iut_eats/widgets/small_text.dart';

import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class Cartpage extends StatelessWidget{
  const Cartpage({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Stack(
          children: [
            //header
            Positioned(
                top: Dimensions.height20*3,
                left: Dimensions.width20,
                right: Dimensions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                    SizedBox(width: Dimensions.width20*5,),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: AppIcon(
                        icon: Icons.home_outlined,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimensions.iconSize24,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getCartHistoryPage());
                      },
                      child: AppIcon(
                        icon: Icons.history_outlined,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimensions.iconSize24,
                      ),
                    )
                  ],
                )
            ),
            //body
           GetBuilder<CartController>(builder: (cartController){
             return cartController.getItems.isNotEmpty? Positioned(
                 top: Dimensions.height20*5,
                 left:Dimensions.width20,
                 right: Dimensions.width20,
                 bottom: 0,
                 child: Container(
                   margin: EdgeInsets.only(top: Dimensions.height15),
                   child: MediaQuery.removePadding(
                     context: context,
                     removeTop: true,
                     child: GetBuilder<CartController>(builder: (cartController){
                       var cartList = cartController.getItems;
                       return ListView.builder(
                           itemCount: cartList.length,
                           itemBuilder: (_ , index){
                             return SizedBox(
                               width: double.maxFinite,
                               height : Dimensions.height20*5,
                               child: Row(
                                 children: [
                                   GestureDetector(
                                     onTap: (){
                                       var popularIndex =Get.find<PopularProductController>()
                                           .popularProductList
                                           .indexOf(cartList[index].product!);
                                       if(popularIndex>=0){
                                         Get.toNamed(RouteHelper.getPopularFood(popularIndex,"cartpage"));
                                       }else{
                                         var recommendedIndex = Get.find<RecommendedProductController>()
                                             .recommendedProductList
                                             .indexOf(cartList[index].product!);
                                         if(recommendedIndex < 0){
                                           Get.snackbar("Ooops!!", "Product Preview Not Available");
                                         } else{
                                           Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,"cartpage"));
                                         }
                                       }
                                     },
                                     child: Container(
                                       width: Dimensions.height20*5,
                                       height : Dimensions.height20*5,
                                       margin: EdgeInsets.only(bottom: Dimensions.height10),
                                       decoration: BoxDecoration(
                                           image: DecorationImage(
                                               fit: BoxFit.cover,
                                               image: NetworkImage(AppConstants.BASE_URL + AppConstants.UPLOAD_URL+cartController.getItems[index].img!)
                                           ),
                                           borderRadius : BorderRadius.circular(Dimensions.radius20),
                                           color: Colors.white),
                                     ),
                                   ),
                                   Expanded(child: SizedBox(
                                     height: Dimensions.height20*5,
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                       children: [
                                         BigText(text: cartController.getItems[index].name! , color: Colors.black54,),
                                         SmallText(text: "Spicy"),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             BigText(text: cartController.getItems[index].price.toString() , color: Colors.redAccent),
                                             Container(
                                               padding: EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height10, left: Dimensions.width10, right: Dimensions.width10),
                                               decoration: BoxDecoration(
                                                 borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                 color: Colors.white,
                                               ),
                                               child: Row(
                                                 children: [
                                                   GestureDetector(
                                                       onTap: () {
                                                         cartController.addItem(cartList[index].product!, -1);
                                                       },
                                                       child: const Icon(Icons.remove, color: AppColors.signColor,)),
                                                   SizedBox(width: Dimensions.width10/2,),
                                                   BigText(text: cartList[index].quantity.toString()), // popularProduct.inCartItems.toString()),
                                                   SizedBox(width: Dimensions.width10/2,),
                                                   GestureDetector(

                                                       onTap: () {
                                                         cartController.addItem(cartList[index].product!, 1);
                                                       },
                                                       child: const Icon(Icons.add, color: AppColors.signColor,))
                                                 ],
                                               ),
                                             ),

                                           ],
                                         )
                                       ],
                                     ),
                                   ))
                                 ],
                               ),
                             );
                           });}
                     ),
                   ),
                 )) : const NoDataPage(text: "No Items In Cart");
           })
          ],
        ), bottomNavigationBar: GetBuilder<CartController>(builder: (cartController){
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
          child: cartController.getItems.isNotEmpty? Row(
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

                    SizedBox(width: Dimensions.width10/2,),
                    BigText(text: cartController.totalAmount.toString()),
                    SizedBox(width: Dimensions.width10/2,),

                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  if(Get.find<AuthController>().userLoggedIn()){
                    cartController.addToHistory();
                    Get.snackbar("Order Success", "Your Order is being Processed");
                  }else{
                      Get.toNamed(RouteHelper.getSignInPage());
                  }

                },
                child: Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                  child: BigText(text: "Checkout", color: Colors.white,),
                ),
              ),
            ],
          ) : Container(),
        );
      }),
      );
  }
  
}