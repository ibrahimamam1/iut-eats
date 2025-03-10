import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iut_eats/controllers/cart_controller.dart';
import 'package:iut_eats/controllers/user_controller.dart';
import 'package:iut_eats/data/repository/cart_repo.dart';
import 'package:iut_eats/widgets/big_text.dart';
import '../../controllers/checkout_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../address/pick_address_map.dart';

class CheckoutPage extends StatelessWidget {
  final CheckoutController controller = Get.put(CheckoutController());
  final CartController cartController = Get.find<CartController>();
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(Dimensions.width20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address Field
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getPickAddressPage(),
                    arguments: PickAddressMap(
                    fromSignup: false,
                    fromAddress: false,
                    fromCheckout: true,
                )); // Navigate to address selection
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
                      child: Obx(() => Text(
                        controller.address.isEmpty
                            ? 'Select Address'
                            : controller.address.value,
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                          color: AppColors.mainBlackColor,
                        ),
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                      )),
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

            // Phone Number Field
            Container(
              padding: EdgeInsets.all(Dimensions.width15),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.mainColor),
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                color: Colors.white,
              ),
              child: TextField(
                controller: TextEditingController(text: userController.userModel?.phone),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(
                    color: AppColors.titleColor,
                    fontSize: Dimensions.font16,
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.phone,
                    color: AppColors.iconColor1,
                    size: Dimensions.iconSize24,
                  ),
                ),
                style: TextStyle(
                  fontSize: Dimensions.font16,
                  color: AppColors.mainBlackColor,
                ),
                onChanged: (value) {
                  // You can add logic here to save the phone number if needed
                  // For example: controller.phoneNumber.value = value;
                },
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

                  BigText(text: cartController.totalAmount.toString()),

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
              child: Obx(() => Column(
                children: [
                  RadioListTile<String>(
                    title: const Text('Cash on Delivery'),
                    value: 'cash_on_delivery',
                    groupValue: controller.selectedPayment.value,
                    onChanged: (value) {
                      controller.selectedPayment.value = value!;
                    },
                    activeColor: AppColors.mainColor,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width15),
                  ),
                  RadioListTile<String>(
                    title: const Text('Bkash'),
                    value: 'bkash',
                    groupValue: controller.selectedPayment.value,
                    onChanged: (value) {
                      controller.selectedPayment.value = value!;
                    },
                    activeColor: AppColors.mainColor,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width15),
                  ),
                ],
              )),
            ),
            SizedBox(height: Dimensions.height30),

            // Checkout Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if(controller.selectedPayment.value == 'cash_on_delivery'){
                    print('Cash on delivery');
                    cartController.addToHistory();
                    Get.toNamed(RouteHelper.getSuccessPage());
                  }
                  else{
                    print('bkash');
                    Get.toNamed(RouteHelper.getBkashPaymentPage());
                  }
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