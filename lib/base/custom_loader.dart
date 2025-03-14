import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iut_eats/controllers/auth_controller.dart';
import 'package:iut_eats/utils/colors.dart';

import '../utils/dimensions.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height20*5,
      width: Dimensions.height20*5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.height20*5/2),
        color: AppColors.mainColor,
      ),
      alignment: Alignment.center,
      child: CircularProgressIndicator(color: Colors.white),
    );
  }
}
