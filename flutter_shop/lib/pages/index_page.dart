/*
 * Copyright (c) 29/3/2020
 *
 * Created by Tiger
 *
 * mail : jzh2012@163.com
 */

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter/material.dart';
import 'package:shop/config/index.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/home_page.dart';
import 'package:shop/pages/mine_page.dart';
import 'package:shop/provide/current_index_provide.dart';
import '../config/index.dart';
import 'cagegory_page.dart';

class IndexPage extends StatelessWidget{
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text(KString.homeTitle)),
    BottomNavigationBarItem(
        icon: Icon(Icons.category),
        title: Text(KString.categoryTitle)),
    BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart),
        title: Text(KString.shopCartTitle)),
    BottomNavigationBarItem(
        icon: Icon(Icons.person),
        title: Text(KString.personTitle))
  ];

final List<Widget> tabBodies = [
  HomePage(),
  CategoryPage(),
  CartPage(),
  MinePage()
];

  @override
  Widget build(BuildContext context) {

    ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(context);
    return Provide<CurrentIndexProvide>(
        builder: (context, child, val){
          //取得当前索引值
        int currentindex = Provide.value<CurrentIndexProvide>(context).currentIndex;
        return Scaffold(
          backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: bottomTabs,
              onTap: (index){
                Provide.value<CurrentIndexProvide>(context).changeIndex(index);
              },
          ),
          body: IndexedStack(
            index: currentindex,
            children: tabBodies,
          ),
        );
    },
    );
  }}

