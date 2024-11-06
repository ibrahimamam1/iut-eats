import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:iut_eats/models/cart_model.dart';
import 'package:iut_eats/routes/route_helper.dart';
import 'package:iut_eats/utils/app_constants.dart';
import 'package:iut_eats/utils/dimensions.dart';
import 'package:iut_eats/widgets/app_icon.dart';
import 'package:iut_eats/widgets/big_text.dart';
import 'package:iut_eats/widgets/small_text.dart';

import '../../controllers/cart_controller.dart';
import '../../utils/colors.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();

    for(int i=0; i<getCartHistoryList.length; i++){
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      }
      else{
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, ()=>1);
      }
    }
    print(cartItemsPerOrder[0]);
    List<int>cartItemPerOrderToList(){
      return cartItemsPerOrder.entries.map( (e)=>e.value ).toList();
    }
    List<String>cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map( (e)=>e.key ).toList();
    }

    List<int> itemsPerOrder = cartItemPerOrderToList();
    List<String> orderTimes = cartOrderTimeToList();
    print(orderTimes);
    var listCounter = 0;
    return Scaffold(

      body:Column(
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.maxFinite,
            height: Dimensions.height10*10,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "cart History" , color: Colors.white),
                AppIcon(icon: Icons.shopping_cart_outlined,
                    iconColor:AppColors.mainColor),
              ],
            ),
          ),
          Expanded(
              child: Container(
                margin: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20
                ),
                child: MediaQuery.removePadding(
                  removeTop: true,
                    context: context,
                    child: ListView(
                      children: [
                        for(int i=0; i<cartItemsPerOrder.length; i++)
                          Container(
                            height: Dimensions.height30*4,
                            margin: EdgeInsets.only( bottom: Dimensions.height20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ((){
                                 DateTime parsedDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
                                 //var inputDate = DateTime.parse(parsedDate.toString());
                                 var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
                                  var date = outputFormat.format(parsedDate);
                                  return BigText(text: date);
                                }()),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(
                                      direction: Axis.horizontal,
                                      children:
                                      List.generate(itemsPerOrder[i], (index){
                                        if(listCounter<getCartHistoryList.length)listCounter++;
                                        return index <=2? Container(
                                          height: Dimensions.height20*4,
                                          width: Dimensions.height20*4,
                                          margin: EdgeInsets.only(right: Dimensions.width10/2),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      AppConstants.BASE_URL+AppConstants.UPLOAD_URL+getCartHistoryList[listCounter-1].img!
                                                  )
                                              )
                                          ),
                                        ) : Container();
                                      }),

                                    ),
                                    Container(
                                        height: Dimensions.height20*4,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SmallText(text: "Total" , color: AppColors.titleColor,),
                                          BigText(text: itemsPerOrder[i].toString()+"Items" , color: AppColors.titleColor,),
                                          GestureDetector(
                                            onTap: (){
                                                Map<int, CartModel>moreItems ={};
                                                for(int j=0; j<getCartHistoryList.length; j++){
                                                  if(getCartHistoryList[j].time == orderTimes[i]){
                                                    moreItems.putIfAbsent(getCartHistoryList[j].id!,
                                                            () => CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                                    );
                                                  }
                                                }
                                                Get.find<CartController>().setItems = moreItems;
                                                Get.find<CartController>().addToCartList();
                                                Get.toNamed(RouteHelper.getCartPage());

                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.width10/2),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                                                  border: Border.all(width: 1, color: AppColors.mainColor)
                                              ),
                                              child: SmallText(text: "One More", color: AppColors.mainColor,),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                          )

                      ],
                    ),
                )
              )
          )
        ],
      )
    );
  }
}
