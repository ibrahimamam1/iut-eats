import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iut_eats/base/custom_loader.dart';
import 'package:iut_eats/base/show_custom_snackbar.dart';
import 'package:iut_eats/controllers/auth_controller.dart';
import 'package:iut_eats/models/signup_body_model.dart';
import 'package:iut_eats/utils/colors.dart';
import 'package:iut_eats/widgets/app_text_field.dart';
import 'package:iut_eats/widgets/big_text.dart';

import '../../utils/dimensions.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages =[
      "t.png",
      "f.png",
      "g.png",
    ];
    void _registration(AuthController authController){
      // var authController = Get.find<AuthController>();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty){
        showCustomSnackBar("Type in your name", title: "Name");
      }else if(phone.isEmpty){
        showCustomSnackBar("Type in your phone number", title: "Phone number");
      }else if(email.isEmpty){
        showCustomSnackBar("Type in your email address", title: "Email Address");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in a valid email address", title: "Valid email address");
      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password", title: "Password");
      }else if(password.length<6){
        showCustomSnackBar("Password can not be less than six characters", title: "Password");
      }else{
        showCustomSnackBar("All went well", title: "Perfect");
        SignupBody signupBody = SignupBody(name: name,
            phone: phone,
            email: email,
            password: password);
        authController.registration(signupBody).then((status){
          if(status.isSuccess){
            print("Success registration");
          }else{
           showCustomSnackBar(status.message);
          }
        });
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading? SingleChildScrollView(
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
              //name
              AppTextField(textController: nameController,
                  hintText: "Name",
                  icon: Icons.person),
              SizedBox(height: Dimensions.height20),
              //Phone
              AppTextField(textController: phoneController,
                  hintText: "Phone",
                  icon: Icons.phone),
              SizedBox(height: Dimensions.height20),
              //email
              AppTextField(textController:  emailController,
                  hintText: "Email",
                  icon: Icons.email),
              SizedBox(height: Dimensions.height20),
              //password
              AppTextField(textController: passwordController,
                  hintText: "Password",
                  icon: Icons.password_sharp, isObscure: true,),
              SizedBox(height: Dimensions.height20+Dimensions.height20),
              //Signup button
              GestureDetector(
                onTap: (){
                  _registration(_authController);
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
                      text: "Sign Up",
                      size: Dimensions.font20+Dimensions.font20/2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height10,),

              //tagLine
              RichText(
                text: TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                  text: "Have an account already?",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font20,
                  ),
                ),
              ),

              SizedBox(height: Dimensions.screenHeight*0.05,),
              //signUp option
              RichText(
                text: TextSpan(
                  text: "SignUp using one of the following methods",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font16,
                  ),
                ),
              ),
              Wrap(
                children: List.generate(3, (index) => Padding(

                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: Dimensions.radius30,
                    backgroundImage: AssetImage(
                        "assets/image/"+signUpImages[index]
                    ),

                  ),
                )),
              ),
            ],
          ),
        ):CustomLoader();
      }),
    );


  }
}
