/*
 * Copyright (c) 29/3/2020
 *
 * Created by Tiger
 *
 * mail : jzh2012@163.com
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:shop/config/color.dart';
import 'package:shop/config/string.dart';
import 'package:shop/provide/category_provide.dart';
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
  var listIndex = 0; //索引
  @override
  void initState() {
    super.initState();
    _getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryProvide>(builder: (context, child, val) {
      listIndex = val.firstCategoryIndex;
      print('你点击了第'+listIndex.toString() + "个列表");
      return Container(
        width: ScreenUtil.instance.setWidth(180),
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(width: 0.5, color: KColor.defaultBorderColor),
          ),
        ),
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return _leftInkWell(index);
            }),
      );
    });
  }

  //左侧分类
  Widget _leftInkWell(int index){
    bool isClick = false;
    isClick = index == listIndex?true:false;
    return InkWell(
      onTap: (){
        var firstCategoryId = list[index].firstCategoryId;
        var secondCategoryList = list[index].secondCategoryVO;
        Provide.value<CategoryProvide>(context).changeFirstCategory(firstCategoryId, index);
        Provide.value<CategoryProvide>(context).getSecondCategory(secondCategoryList, firstCategoryId);
        //TODO 获取商品列表
      },
      child: Container(
        height: ScreenUtil.instance.setHeight(90),
          padding: EdgeInsets.only(left: 5.0,top: 5.0),
          decoration: BoxDecoration(
          color: isClick?Color.fromRGBO(236, 238, 239, 1.0):Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0, color:KColor.defaultBorderColor),
            left : BorderSide(width: 2.0, color: isClick?KColor.primaryColor:KColor.defaultBorderColor),
          ),
        ),
        child: Text(
          list[index].firstCategoryName,
          style: TextStyle(
            color: isClick?KColor.primaryColor:Colors.black,
            fontSize: ScreenUtil.instance.setSp(28),
          ),
        ),
      ),
    );
  }
  //获取分类数据
  _getCategory() async {
    await request('getCategory', formData: null).then((val) {
      var data = json.decode(val.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
      });
      Provide.value<CategoryProvide>(context)
          .getSecondCategory(list[0].secondCategoryVO, '4');
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

   return Provide<CategoryProvide>(builder: (context, child,categoryProvide){

     return Container(
       height: ScreenUtil.instance.setHeight(80),
       width: ScreenUtil.instance.setWidth(570),
       decoration: BoxDecoration(
         color: Colors.white,
         border: Border(
           bottom: BorderSide(width: 1.0,color: KColor.defaultBorderColor)
         )
       ),
       child: ListView.builder(
           scrollDirection: Axis.horizontal,
           itemCount: categoryProvide.secondCategoryList.length,
           itemBuilder: (context ,index){
            return _rightInkWell(index,categoryProvide.secondCategoryList[index]);
           }),
     );
   });
  }
  //右侧二级分类
  Widget _rightInkWell(int index , SecondCategoryVO item){
    bool isClick = false;
    isClick = (index == Provide.value<CategoryProvide>(context).secondCategoryIndex ?true:false);
    return InkWell(
      onTap: (){
        Provide.value<CategoryProvide>(context).changeSecondCategoryIndex(item.secondCategoryId, index);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
            item.secondCategoryName,
          style: TextStyle(
            color: isClick?KColor.primaryColor:Colors.black,
            fontSize: ScreenUtil.instance.setSp(28),

          ),
        ),
      ),
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
