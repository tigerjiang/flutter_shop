/*
 *  Copyright (c) 15/4/2020
 *  
 *  Created by Tiger
 *
 *  mail : jzh2012@163.com
 */

import 'package:flutter/material.dart';
import '../model/category_goods_list_model.dart';

class CategoryGoodsListProvide with ChangeNotifier {
  List categoryGoodsList = [];
  getCategoryGoodsList(List list) {
    categoryGoodsList = list;
    notifyListeners();
  }
   //加载更多 追加数据
  addCategoryGoodsList(List list) {
    categoryGoodsList.addAll(list);
    notifyListeners();
  }
}
