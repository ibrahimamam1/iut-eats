import 'dart:convert';

import 'package:iut_eats/models/cart_model.dart';
import 'package:iut_eats/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CartRepo{
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String>cart=[];
  List<String> cartHistory=[];
  void addToCartList (List<CartModel> cartList){

    /*sharedPreferences.remove(AppConstants.CART_LIST);
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
    return;*/

    var time = DateTime.now().toString();
      cart = [];

      //convert Cart Objects to string because sharedPreferences Only accepts strings
      for (var element in cartList) {
        element.time = time;
        continue;
      }
      
      sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
      //print(sharedPreferences.getStringList(AppConstants.CART_LIST));
  }

  List<CartModel>getCartList(){
    List<CartModel> cartList=[];
    List<String> carts=[];

    if(sharedPreferences.containsKey(AppConstants.CART_LIST)){
     carts =  sharedPreferences.getStringList(AppConstants.CART_LIST)!;
    }

    for (var element in carts) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartList;
  }

  List<CartModel>getCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      cartHistory=[];
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }

    List<CartModel> cartListHistory=[];
    for (var element in cartHistory) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartListHistory;
  }

  void addToCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      print("shared preferences contains key");
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    } else {
      print("shared preferences does not contains key");
      cartHistory = [];
    }
    print("there are ${cart.length} items in cart");
    for (int i = 0; i < cart.length; i++){
      cartHistory.add(cart[i]);
    }
    print("clearing cart");
    removeCart();
    print("saving ${cartHistory.length} elements to shared preferences");
    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
  }


  void removeCart(){
    cart=[];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  void clearCartHistory(){
      removeCart();
      cartHistory=[];
      sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }
}