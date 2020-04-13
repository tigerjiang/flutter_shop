/*
 *  Copyright (c) 13/4/2020
 *  
 *  Created by Tiger
 *
 *  mail : jzh2012@163.com
 */

import 'package:flutter/material.dart';
import '../model/category_model.dart';

//分类provide
class CategoryProvide with ChangeNotifier {
  List<SecondCategoryVO> categoryGoodsList = [];
  int secondCategoryIndex = 0; //二级分类索引
  int firstCategoryIndex = 0; //一级分类索引
  String firstCategoryId = '4'; //一级分类id
  String secondCategoryId = ''; //二级分类id
  int page = 1; //判断页数，当改变一级分类或者二级分类时进行改变
  String noMoreText = ''; //显示更多的表示
  bool isNewCategory = true;

  //首页点击类别时更改类标
  changeFirstCategory(String id, int index){
    firstCategoryId = id;
    firstCategoryIndex = index;
    secondCategoryId ='';
    notifyListeners();
  }

  //改变二类索引
  changeSecondCategory(String id, int index){
    isNewCategory = true;
    secondCategoryId = id;
    secondCategoryIndex = index;
    page = 1;
    noMoreText = '';
    notifyListeners();
  }

  addPage(){
    page ++;
  }


}
