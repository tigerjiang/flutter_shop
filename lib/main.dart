/*
 * Copyright (c) 29/3/2020
 *
 * Created by Tiger
 *
 * mail : jzh2012@163.com
 */

import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:shop/provide/category_provide.dart';
import 'package:shop/provide/category_goods_list_provide.dart';
import './config/index.dart';
import './provide/current_index_provide.dart';
import './pages/index_page.dart';
import 'pages/index_page.dart';

void main() {
  var currentIndexProvide = CurrentIndexProvide();
  var currentCategoryProvide = CategoryProvide();
  var categoryGoodsListProvide = CategoryGoodsListProvide();

  var providers = Providers();
  providers
    ..provide(Provider<CategoryProvide>.value(currentCategoryProvide))
    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide))
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide));

  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: KString.appTitle,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: KColor.primaryColor),
        home: IndexPage(),
      ),
    );
  }
}
