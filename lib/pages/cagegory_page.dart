/*
 * Copyright (c) 29/3/2020
 *
 * Created by Tiger
 *
 * mail : jzh2012@163.com
 */


import 'package:flutter/cupertino.dart';
import 'package:shop/config/string.dart';

class CategoryPage extends StatefulWidget{

  _CategoryPageState createState()=> _CategoryPageState();
  
}

class _CategoryPageState extends State<CategoryPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text(KString.categoryTitle),
    );
  }


}