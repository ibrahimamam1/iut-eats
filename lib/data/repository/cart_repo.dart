import 'dart:convert';

import 'package:iut_eats/models/cart_model.dart';
import 'package:iut_eats/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CartRepo{
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String>cart=[];
  void addToCartList (List<CartModel> cartList){
      cart = [];

      //convert Cart Objects to string because saharedPreferences Only accepts strings
      cartList.forEach( (element) => cart.add(jsonEncode(element)));
      
      sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
      print(sharedPreferences.getStringList(AppConstants.CART_LIST));
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
}