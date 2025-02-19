import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iut_eats/controllers/auth_controller.dart';
import 'package:iut_eats/routes/route_helper.dart';
import 'package:iut_eats/utils/colors.dart';
import 'package:iut_eats/utils/dimensions.dart';
import 'package:iut_eats/widgets/account_widget.dart';
import 'package:iut_eats/widgets/app_icon.dart';
import 'package:iut_eats/widgets/big_text.dart';

import '../../controllers/cart_controller.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Profile", size: 24,
        ),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.height20),
        child: Column(
          children: [
            // profile icon
            AppIcon(icon: Icons.person,
            backgroundColor: AppColors.mainColor,
            iconColor: Colors.white,
            iconSize: Dimensions.height45+Dimensions.height30,
            size: Dimensions.height15*10,),
            SizedBox(height: Dimensions.height30,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //name
                    AccountWidget(
                        appIcon:AppIcon(icon: Icons.person,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,),
                        bigText: BigText(text: "Muntasir")
                    ),
                    SizedBox(height: Dimensions.height20,),
                
                    //phone
                    AccountWidget(
                        appIcon:AppIcon(icon: Icons.phone,
                          backgroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,),
                        bigText: BigText(text: "01748004936")
                    ),
                    SizedBox(height: Dimensions.height20,),
                
                    //email
                    AccountWidget(
                        appIcon:AppIcon(icon: Icons.email,
                          backgroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,),
                        bigText: BigText(text: "muntasir21@iut-dhaka.edu")
                    ),
                    SizedBox(height: Dimensions.height20,),
                
                    //address
                    AccountWidget(
                        appIcon:AppIcon(icon: Icons.location_on,
                          backgroundColor: AppColors.yellowColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,),
                        bigText: BigText(text: "Fill any address")
                    ),
                    SizedBox(height: Dimensions.height20,),
                
                    //message
                    AccountWidget(
                        appIcon:AppIcon(icon: Icons.message_outlined,
                          backgroundColor: Colors.redAccent,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5,),
                        bigText: BigText(text: "Messages")
                    ),
                    SizedBox(height: Dimensions.height20,),
                    //logout
                    GestureDetector(
                      onTap: (){
                        if(Get.find<AuthController>().userLoggedIn()){
                          Get.find<AuthController>().clearSharedData();
                          Get.find<CartController>().clear();
                          Get.find<CartController>().clearCartHistory();
                          Get.offNamed(RouteHelper.getSplashPage());

                        }

                      },
                      child: AccountWidget(
                          appIcon:AppIcon(icon: Icons.logout,
                            backgroundColor: Colors.redAccent,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5,),
                          bigText: BigText(text: "Logout")
                      ),
                    ),
                    SizedBox(height: Dimensions.height20,),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
