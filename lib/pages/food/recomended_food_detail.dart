 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iut_eats/widgets/app_icon.dart';
import 'package:iut_eats/widgets/expandable_text_widget.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';

class RecommendedFoodDetail extends StatelessWidget {
   const RecommendedFoodDetail({super.key});
 
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 70,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(icon: Icons.clear),
                  AppIcon(icon: Icons.shopping_cart_outlined),
                ],
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                  child: Center(
                    child : BigText(size : Dimensions.font26, text : "Sliver App bar")
                  ),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 5 , bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft:  Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20)
                    )
                  ),
                ),
              ),
              pinned: true,
              backgroundColor: AppColors.yellowColor,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  "assets/image/chinese food.jpeg",
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    child: ExpandableTextWidget(
                      text : "Chinese prawn fry is a quick and flavorful dish, featuring succulent prawns stir-fried with aromatic ingredients like garlic, ginger, and scallions. The prawns are typically marinated in a mixture of soy sauce, rice wine, and sesame oil, giving them a savory, umami flavor. Often, vegetables like bell peppers or snow peas are added for extra texture and color. The dish is cooked over high heat in a wok, ensuring that the prawns stay tender while developing a slightly crispy exterior. It's a popular choice for a light, yet satisfying meal, often served with steamed rice or noodles.Chinese prawn fry is a quick and flavorful dish, featuring succulent prawns stir-fried with aromatic ingredients like garlic, ginger, and scallions. The prawns are typically marinated in a mixture of soy sauce, rice wine, and sesame oil, giving them a savory, umami flavor. Often, vegetables like bell peppers or snow peas are added for extra texture and color. The dish is cooked over high heat in a wok, ensuring that the prawns stay tender while developing a slightly crispy exterior. It's a popular choice for a light, yet satisfying meal, often served with steamed rice or noodles.Chinese prawn fry is a quick and flavorful dish, featuring succulent prawns stir-fried with aromatic ingredients like garlic, ginger, and scallions. The prawns are typically marinated in a mixture of soy sauce, rice wine, and sesame oil, giving them a savory, umami flavor. Often, vegetables like bell peppers or snow peas are added for extra texture and color. The dish is cooked over high heat in a wok, ensuring that the prawns stay tender while developing a slightly crispy exterior. It's a popular choice for a light, yet satisfying meal, often served with steamed rice or noodles."
                      ),
                    margin: EdgeInsets.only(left: Dimensions.width20 , right: Dimensions.width20),
                    ),
                ],
              ),
            )
          ],
        ),
       bottomNavigationBar: Column(
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
               AppIcon(
                   iconColor: Colors.white ,
                   backgroundColor: AppColors.mainColor ,
                   icon: Icons.remove,
                   iconSize : Dimensions.iconSize24,
               ),
               
               BigText(text: "\$12.88 " + " X " + " 0 " , color: AppColors.mainBlackColor, size: Dimensions.font26,),
               
               AppIcon(
                 iconColor: Colors.white ,
                 backgroundColor: AppColors.mainColor ,
                 icon: Icons.add,
                 iconSize : Dimensions.iconSize24,
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
                   child: Icon(Icons.favorite , color: AppColors.mainColor)
                 ),
                 Container(
                   padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                   child: BigText(text: "\$10 | Add to Cart", color: Colors.white,),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(Dimensions.radius20),
                     color: AppColors.mainColor,
                   ),
                 ),
               ],
             ),
           ),
         ],
       ),
     );
   }
 }
 