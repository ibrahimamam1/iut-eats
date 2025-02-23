import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double radius;
  final IconData? icon;

  const CustomButton({super.key, this.onPressed,
  required this.buttonText,
  this.transparent=false,
  this.margin,
  this.width,
    this.height,
    this.fontSize,
    this.radius=5,
    this.icon
  });

  @override
  Widget build(BuildContext context) {
  final ButtonStyle _flatbutton= TextButton.styleFrom(
      backgroundColor: onPressed==null?Theme.of(context).disabledColor:transparent?Colors.transparent:Theme.of(context).primaryColor,
      minimumSize: Size(width==null?Dimensions.screenWidth:width!, height!=null?height!:50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius)
      )
    );
    return Center(
      child: SizedBox(
        width: width?? Dimensions.screenWidth,
        height: height??50,
        child :TextButton(
          onPressed: onPressed,
          style: _flatbutton,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon!=null?Padding(
              padding: EdgeInsets.only(right:Dimensions.width10/2),
          child: Icon(icon,color:transparent?Theme.of(context).primaryColor:Theme.of(context).cardColor),
            ):SizedBox(),
          Text(
            buttonText,style: TextStyle(
            fontSize: fontSize!=null?fontSize:Dimensions.font16,
            color: transparent?Theme.of(context).primaryColor:Theme.of(context).cardColor)
          ),

        ],
      ),
      )
      ),
    );
    return const Placeholder();
  }
}
