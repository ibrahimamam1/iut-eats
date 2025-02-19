import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iut_eats/base/custom_loader.dart';
import 'package:iut_eats/pages/auth/sign_up_page.dart';
import 'package:iut_eats/routes/route_helper.dart';
import 'package:iut_eats/utils/colors.dart';
import 'package:iut_eats/widgets/app_text_field.dart';
import 'package:iut_eats/widgets/big_text.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';
import '../../models/signup_body_model.dart';
import '../../utils/dimensions.dart';

class SignInPage extends StatelessWidget {
  const SignInPage ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    void _login(AuthController authController){

      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(email.isEmpty){
        showCustomSnackBar("Type in your email address", title: "Email Address");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in a valid email address", title: "Valid email address");
      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password", title: "Password");
      }else if(password.length<6){
        showCustomSnackBar("Password can not be less than six characters", title: "Password");
      }else{
        print("going to try loging in");
        authController.login(email, password).then((status){
          print("finished loging in");
          if(status.isSuccess){
            print("Status sucess");
            // Get.toNamed(RouteHelper.getInitial());
            Get.toNamed(RouteHelper.getCartPage());
          }else{
            print("Status not sucess");
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading? SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //app_logo
              Container(
                height: Dimensions.screenHeight*0.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    backgroundImage: AssetImage(
                        "assets/image/logo part1.jpg"
                    ),
                  ),
                ),
              ),

              //welcome
              Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(
                        fontSize: Dimensions.font20*3+Dimensions.font20/2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Sign into your account",
                      style: TextStyle(
                        fontSize: Dimensions.font20,
                        // fontWeight: FontWeight.bold,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20),

              //Phone
              AppTextField(textController: emailController,
                  hintText: "email",
                  icon: Icons.email),
              SizedBox(height: Dimensions.height20),

              //password
              AppTextField(textController: passwordController,
                hintText: "Password",
                icon: Icons.password_sharp,isObscure: true,),
              SizedBox(height: Dimensions.height20+Dimensions.height20),


              //tagLine
              Row(
                children: [
                  Expanded(child: Container()),
                  RichText(
                    text: TextSpan(
                      text: "Sign into your account",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20,
                      ),
                    ),
                  ),
                  SizedBox(width: Dimensions.width20,)
                ],
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //SignIn button
              GestureDetector(
                onTap: (){
                  _login(authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: AppColors.mainColor,
                  ),
                  child: Center(
                    child: BigText(
                      text: "Sign in",
                      size: Dimensions.font20+Dimensions.font20/2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),


              //signUp option
              RichText(
                text: TextSpan(
                  text: "Don\'t have an account?",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font20,
                  ),
                  children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(), transition: Transition.fade),
                        text: " Create",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainBlackColor,
                          fontSize: Dimensions.font20,
                        )),
                  ],
                ),
              ),

            ],
          ),
        ):CustomLoader();
      })
    );
  }
}
