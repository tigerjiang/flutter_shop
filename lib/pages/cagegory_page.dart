/*
 * Copyright (c) 29/3/2020
 *
 * Created by Tiger
 *
 * mail : jzh2012@163.com
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/config/string.dart';
import '../service/http_service.dart';
import 'dart:convert';
import '../model/category_model.dart';

class CategoryPage extends StatefulWidget {
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        title: Text(KString.categoryTitle),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoodSList(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

//左侧分类
class LeftCategoryNav extends StatefulWidget {
  LeftCategoryNavState createState() => LeftCategoryNavState();
}

class LeftCategoryNavState extends State<LeftCategoryNav> {

  List list = [];
  var index = 1;
  @override
  void initState(){
    super.initState();
    print('initState');
    _getCategory();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('左侧分类'),
    );
  }

  //获取分类数据
  _getCategory() async {
    await request('getCategory', formData:null).then((val){
      var data = json.decode(val.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
      });
    });
  }
}

//右侧分类
class RightCategoryNav extends StatefulWidget {
  RightCategoryNavState createState() => RightCategoryNavState();
}

class RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('右侧分类'),
    );
  }
}

//商品列表
class CategoryGoodSList extends StatefulWidget {
  CategoryGoodsState createState() => CategoryGoodsState();
}

class CategoryGoodsState extends State<CategoryGoodSList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('商品列表'),
    );
  }
}

