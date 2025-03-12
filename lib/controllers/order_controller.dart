import 'package:get/get.dart';
import 'package:get/get_connect.dart';

import '../data/repository/order_repo.dart';


class OrderController extends GetxController {
  final OrderRepo orderRepo;

  OrderController({required this.orderRepo});

  List<dynamic> _orderList = [];
  List<dynamic> get orderList => _orderList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  // Future<void> getOrderList() async {
  //   Response response = await productRepo.getProductList();
  //   if (response.statusCode == 200) {
  //     print("Got products");
  //     _productList = [];
  //     _productList.addAll(Product.fromJson(response.body).products);
  //     _isLoaded = true;
  //     update();
  //   } else {
  //     // Handle error if needed.
  //   }
  // }

  Future<bool> placeOrder(
      String user_name, String user_phone, String delivery_address, int total_amount, String order_items) async {
    print("creating form data");
    final data = {
      'user_name': user_name,
      'user_phone': user_phone,
      'delivery_address': delivery_address,
      'order_amount': total_amount,
      'order_items': order_items, // Make sure this is a valid JSON string if required.
    };

    Response response = await orderRepo.placeOrder(data);
    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Order placed succesfully');
      return true;
    } else {
      print("Error: ${response.statusCode}");
      print(response.body.toString());
      Get.snackbar('Error', response.statusText!);
    }
    return false;
  }


}
