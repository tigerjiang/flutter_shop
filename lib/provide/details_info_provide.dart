/*
 *  Copyright (c) 21/4/2020
 *  
 *  Created by Tiger
 *
 *  mail : jzh2012@163.com
 */


import 'package:flutter/material.dart';
import '../model/details_model.dart';
import '../service/http_service.dart';
import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier {
  DetailsModel goodsInfo = null;

  getGoodsInfo(String id) async {
    print('getGoodDetail :: id '+ id);
    var formData = {'goodId':id};
    await request('getGoodDetail', formData: formData).then((val) {
      print('getGoodDetail 1::' + val.toString());
      var data = json.decode(val.toString());
      print('getGoodDetail 2::' + data.toString());
      goodsInfo = DetailsModel.fromJson(data);
      print('getGoodDetail 3::' + data.toString());
      notifyListeners();
    });
  }
}
