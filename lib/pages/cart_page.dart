/*
 * Copyright (c) 29/3/2020
 *
 * Created by Tiger
 *
 * mail : jzh2012@163.com
 */


import 'package:flutter/cupertino.dart';
import 'package:shop/config/string.dart';

class CartPage extends StatefulWidget{

  _CartPageState createState()=> _CartPageState();
  
}

class _CartPageState extends State<CartPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text(KString.shopCartTitle),
    );
  }


}