import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iut_eats/base/custom_loader.dart';
import 'package:iut_eats/controllers/auth_controller.dart';
import 'package:iut_eats/controllers/location_controller.dart';
import 'package:iut_eats/controllers/user_controller.dart';
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
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Profile", size: 24,
        ),
      ),
      body: GetBuilder<UserController>(builder: (userController){
        return _userLoggedIn ?
        (!userController.isLoading? Container(
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
                          bigText: BigText(text: userController.userModel!.name)
                      ),
                      SizedBox(height: Dimensions.height20,),

                      //phone
                      AccountWidget(
                          appIcon:AppIcon(icon: Icons.phone,
                            backgroundColor: AppColors.yellowColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5,),
                          bigText: BigText(text: userController.userModel!.phone)
                      ),
                      SizedBox(height: Dimensions.height20,),

                      //email
                      AccountWidget(
                          appIcon:AppIcon(icon: Icons.email,
                            backgroundColor: AppColors.yellowColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5,),
                          bigText: BigText(text: userController.userModel!.email)
                      ),
                      SizedBox(height: Dimensions.height20,),

                      //address
                     GetBuilder<LocationController>(builder: (locationController){
                       if(_userLoggedIn&&locationController.addressList.isEmpty){
                         return  GestureDetector(
                           onTap: (){
                             Get.offNamed(RouteHelper.getAddressPage());
                           },
                           child: AccountWidget(
                               appIcon:AppIcon(icon: Icons.location_on,
                                 backgroundColor: AppColors.yellowColor,
                                 iconColor: Colors.white,
                                 iconSize: Dimensions.height10*5/2,
                                 size: Dimensions.height10*5,),
                               bigText: BigText(text: "Fill in your address")
                           ),
                         );
                       }else{
                         return  GestureDetector(
                           onTap: (){
                             Get.offNamed(RouteHelper.getAddressPage());
                           },
                           child: AccountWidget(
                               appIcon:AppIcon(icon: Icons.location_on,
                                 backgroundColor: AppColors.yellowColor,
                                 iconColor: Colors.white,
                                 iconSize: Dimensions.height10*5/2,
                                 size: Dimensions.height10*5,),
                               bigText: BigText(text: "Your address")
                           ),
                         );
                       }
                     }),
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
        ):CustomLoader() ) :
        Container(child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.maxFinite,
              height: Dimensions.height20*8,
              margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(""))
              ),
            ),
            GestureDetector(
              onTap: (){
                Get.toNamed(RouteHelper.getSignInPage());
              },
              child: Container(
                width: double.maxFinite,
                height: Dimensions.height20*5,
                margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor
                ),
                child: Center(child:BigText(text: "Sign In", color: Colors.white, size: Dimensions.font20,)),
              ),
            )
          ],
        )),);
      }),
    );
  }
}
