import 'package:get/get.dart';
import 'package:iut_eats/controllers/cart_controller.dart';

import 'location_controller.dart';

class CheckoutController extends GetxController {
  // Access the LocationController instance
  final LocationController locationController = Get.find<LocationController>();

  // Observable variable to hold the address
  var address = ''.obs;

  // Other checkout-related variables (example)
  var selectedPayment = 'cash_on_delivery'.obs;

  @override
  @override
  void onInit() {
    super.onInit();
    address.value = locationController.placemark.name ?? '';
  }

  void updateAddress() {
    print("you choosed your address : ");
    address.value = [
      locationController.placemark.name ?? '',
      locationController.placemark.locality ?? '',
      locationController.placemark.postalCode ?? '',
      locationController.placemark.country ?? '',
    ].where((part) => part.isNotEmpty).join(', ');
    print(address.value);
  }
}