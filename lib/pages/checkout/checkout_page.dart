import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iut_eats/widgets/big_text.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class CheckoutPage extends StatefulWidget {
  final String address;
  final double totalPrice;

  const CheckoutPage({required this.address, required this.totalPrice, super.key});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String selectedPayment = 'cash_on_delivery';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: AppColors.mainColor,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.width20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address Field
            GestureDetector(
              onTap: () {
                Get.toNamed('/address-selection'); // Navigate to address selection page
              },
              child: Container(
                padding: EdgeInsets.all(Dimensions.width20),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.mainColor),
                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery Address',
                      style: TextStyle(
                        fontSize: Dimensions.font16,
                        color: AppColors.titleColor,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.address.isEmpty ? 'Select Address' : widget.address,
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                          color: AppColors.mainBlackColor,
                        ),
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: Dimensions.iconSize16,
                      color: AppColors.iconColor1,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: Dimensions.height20),

            // Total Price Display
            Container(
              padding: EdgeInsets.symmetric(vertical: Dimensions.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Price',
                    style: TextStyle(
                      fontSize: Dimensions.font20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.titleColor,
                    ),
                  ),
                  Text(
                    '\$${widget.totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: Dimensions.font20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.height20),

            // Payment Options
            BigText(text: "Payment Options"),
            SizedBox(height: Dimensions.height10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.signColor),
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  RadioListTile<String>(
                    title: const Text('Cash on Delivery'),
                    value: 'cash_on_delivery',
                    groupValue: selectedPayment,
                    onChanged: (value) {
                      setState(() {
                        selectedPayment = value!;
                      });
                    },
                    activeColor: AppColors.mainColor,
                    contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.width15),
                  ),
                  RadioListTile<String>(
                    title: const Text('Bkash'),
                    value: 'bkash',
                    groupValue: selectedPayment,
                    onChanged: (value) {
                      setState(() {
                        selectedPayment = value!;
                      });
                    },
                    activeColor: AppColors.mainColor,
                    contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.width15),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.height30),

            // Checkout Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add your checkout logic here (e.g., process the order)
                  print('Selected Payment: $selectedPayment');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width30,
                    vertical: Dimensions.height15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                  ),
                ),
                child: Text(
                  'Checkout',
                  style: TextStyle(
                    fontSize: Dimensions.font20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
