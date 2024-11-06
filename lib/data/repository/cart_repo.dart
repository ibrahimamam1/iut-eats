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
    var time = DateTime.now().toString();
      cart = [];

      //convert Cart Objects to string because saharedPreferences Only accepts strings
      cartList.forEach( (element){
        element.time = time;
        return cart.add(jsonEncode(element));
      }
      );
      
      sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
      //print(sharedPreferences.getStringList(AppConstants.CART_LIST));
  }

  List<CartModel>getCartList(){
    List<CartModel> cartList=[];
    List<String> carts=[];

    if(sharedPreferences.containsKey(AppConstants.CART_LIST)){
     carts =  sharedPreferences.getStringList(AppConstants.CART_LIST)!;
    }

    carts.forEach( (element) =>cartList.add(CartModel.fromJson(jsonDecode(element))));
    return cartList;
  }

  List<CartModel>getCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      cartHistory=[];
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }

    List<CartModel> cartListHistory=[];
    cartHistory.forEach( (element) => cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }

  void addToCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for(int i=0; i<cart.length; i++){
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
  }

  void removeCart(){
    print("Remooooovvvvvve");
    cart=[];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }
}