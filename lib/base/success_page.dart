import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/route_helper.dart'; // Added GetX import

class SuccessPage extends StatelessWidget {
  final String text;
  final String imgPath;

  const SuccessPage({
    super.key,
    this.text = "Your Order Is Complete. Our Delivery agent will contact you.",
    this.imgPath = "assets/image/order_success.png"
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          imgPath,
          height: MediaQuery.of(context).size.height * 0.22,
          width: MediaQuery.of(context).size.width * 0.22,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Text(
          text,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.0175,
              color: Theme.of(context).disabledColor
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04), // Added spacing before button
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1 // Responsive horizontal padding
          ),
          child: ElevatedButton(
            onPressed: () {
              Get.toNamed(RouteHelper.getInitial());
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 30,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
              backgroundColor: Theme.of(context).primaryColor, // Uses theme primary color
            ),
            child: const Text(
              'Home',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}