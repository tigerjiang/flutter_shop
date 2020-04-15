
/*
 *  Copyright (c) 15/4/2020
 *
 *  Created by Tiger
 *
 *  mail : jzh2012@163.com
 */

class CategoryGoodsListModel {
  String code;
  String message;
  List<CategoryListData> data;

  CategoryGoodsListModel({this.code, this.message, this.data});

  CategoryGoodsListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<CategoryListData>();
      json['data'].forEach((v) {
        data.add(new CategoryListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryListData {
  String name;
  String image;
  double presentPrice;
  double oriPrice;
  String goodsId;

  CategoryListData({this.name, this.image, this.presentPrice,this.oriPrice, this.goodsId});

  CategoryListData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    presentPrice = json['presentPrice'];
    oriPrice = json['oriPrice'];
    goodsId = json['goodsId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['presentPrice'] = this.presentPrice;
    data['oriPrice'] = this.oriPrice;
    data['goodsId'] = this.goodsId;
    return data;
  }
}

