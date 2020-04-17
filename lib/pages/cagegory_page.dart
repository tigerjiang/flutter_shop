/*
 * Copyright (c) 29/3/2020
 *
 * Created by Tiger
 *
 * mail : jzh2012@163.com
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provide/provide.dart';
import 'package:shop/config/color.dart';
import 'package:shop/config/font.dart';
import 'package:shop/config/string.dart';
import 'package:shop/model/category_goods_list_model.dart';
import 'package:shop/provide/category_provide.dart';
import '../service/http_service.dart';
import 'dart:convert';
import '../model/category_model.dart';
import '../model/category_goods_list_model.dart';
import '../provide/category_goods_list_provide.dart';

class CategoryPage extends StatefulWidget {
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      appBar: AppBar(
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
      print('你点击了第' + listIndex.toString() + "个列表");
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
  Widget _leftInkWell(int index) {
    bool isClick = false;
    isClick = index == listIndex ? true : false;
    return InkWell(
      onTap: () {
        var firstCategoryId = list[index].firstCategoryId;
        var secondCategoryList = list[index].secondCategoryVO;
        Provide.value<CategoryProvide>(context)
            .changeFirstCategory(firstCategoryId, index);
        Provide.value<CategoryProvide>(context)
            .getSecondCategory(secondCategoryList, firstCategoryId);
        _getCategoryGoods(context, firstCategoryId);
      },
      child: Container(
        height: ScreenUtil.instance.setHeight(90),
        padding: EdgeInsets.only(left: 5.0, top: 5.0),
        decoration: BoxDecoration(
          color: isClick ? Color.fromRGBO(236, 238, 239, 1.0) : Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0, color: KColor.defaultBorderColor),
            left: BorderSide(
                width: 2.0,
                color:
                    isClick ? KColor.primaryColor : KColor.defaultBorderColor),
          ),
        ),
        child: Text(
          list[index].firstCategoryName,
          style: TextStyle(
            color: isClick ? KColor.primaryColor : Colors.black,
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

  //获取商品列表
  _getCategoryGoods(context, String firstCategoryId) {
    var data = {
      'firstCategoryId': firstCategoryId == null
          ? Provide.value<CategoryProvide>(context).firstCategoryId
          : firstCategoryId,
      'secondCategoryId':
          Provide.value<CategoryProvide>(context).secondCategoryId,
      'page': 1,
    };
    request('getCategoryGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      print("_getCategoryGoods :: " + data.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if (goodsList.data == null) {
        Provide.value<CategoryGoodsListProvide>(context)
            .getCategoryGoodsList(null);
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .getCategoryGoodsList(goodsList.data);
      }
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
    return Provide<CategoryProvide>(builder: (context, child, categoryProvide) {
      return Container(
        height: ScreenUtil.instance.setHeight(80),
        width: ScreenUtil.instance.setWidth(570),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom:
                    BorderSide(width: 1.0, color: KColor.defaultBorderColor))),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryProvide.secondCategoryList.length,
            itemBuilder: (context, index) {
              return _rightInkWell(
                  index, categoryProvide.secondCategoryList[index]);
            }),
      );
    });
  }

  //右侧二级分类
  Widget _rightInkWell(int index, SecondCategoryVO item) {
    bool isClick = false;
    isClick =
        (index == Provide.value<CategoryProvide>(context).secondCategoryIndex
            ? true
            : false);
    return InkWell(
      onTap: () {
        Provide.value<CategoryProvide>(context)
            .changeSecondCategoryIndex(item.secondCategoryId, index);
        _getCategoryGoods(context, item.secondCategoryId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.secondCategoryName,
          style: TextStyle(
            color: isClick ? KColor.primaryColor : Colors.black,
            fontSize: ScreenUtil.instance.setSp(28),
          ),
        ),
      ),
    );
  }

  //获取商品列表
  _getCategoryGoods(context, String secondCategoryId) {
    var data = {
      'firstCategoryId':
          Provide.value<CategoryProvide>(context).firstCategoryId,
      'secondCategoryId': secondCategoryId,
      'page': 1,
    };
    request('getCategoryGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      print("_getCategoryGoods secondCategory :: " + data.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if (goodsList.data == null) {
        Provide.value<CategoryGoodsListProvide>(context)
            .getCategoryGoodsList(null);
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .getCategoryGoodsList(goodsList.data);
      }
    });
  }
}

//商品列表
class CategoryGoodSList extends StatefulWidget {
  CategoryGoodsState createState() => CategoryGoodsState();
}

class CategoryGoodsState extends State<CategoryGoodSList> {
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();
  var scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) {
        try {
          //分类切换时滚动到顶部位置
          if (Provide.value<CategoryProvide>(context).page == 1) {
            scrollController.jumpTo(0.0);
          }
        } catch (e) {
          print('进入页面第一次初始化${e}');
        }
        if (data.categoryGoodsList.length > 0) {
          return Expanded(
            child: Container(
              width: ScreenUtil.instance.setWidth(570),
              child: EasyRefresh(
                refreshFooter: ClassicsFooter(
                  key: _footerKey,
                  bgColor: Colors.white,
                  textColor: KColor.refreshTextColor,
                  moreInfoColor: KColor.refreshTextColor,
                  showMore: true,
                  noMoreText:
                      Provide.value<CategoryProvide>(context).noMoreText,
                  moreInfo: KString.loading,
                  loadReadyText: KString.loadReadyText,
                ),
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: data.categoryGoodsList.length,
                    itemBuilder: (context, index) {
                      return _listWidget(data.categoryGoodsList, index);
                    }),
                loadMore: () async {
                  if (Provide.value<CategoryProvide>(context).noMoreText ==
                      KString.noMoreText) {
                    Fluttertoast.showToast(
                        msg: KString.toBottom,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIos: 1,
                        backgroundColor: KColor.refreshTextColor,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    _getMoreList();
                  }
                },
              ),
            ),
          );
        } else {
          //加载更多
          return Text(KString.noMoreData);
        }
      },
    );
  }

  //列表项
  Widget _listWidget(List newList, int index) {
    return InkWell(
      onTap: () {
        //TODO 跳转到商品详情页
      },
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0, color: KColor.defaultBorderColor),
          ),
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(newList, index),
            Column(
              children: <Widget>[
                _goodsName(newList, index),
                _goodsPrice(newList, index),
              ],
            )
          ],
        ),
      ),
    );
  }

  //加载更多
  void _getMoreList() {
    Provide.value<CategoryProvide>(context).addPage();
    var data = {
      'firstCategoryId':
          Provide.value<CategoryProvide>(context).firstCategoryId,
      'secondCategoryId':
          Provide.value<CategoryProvide>(context).secondCategoryId,
      'page': Provide.value<CategoryProvide>(context).page,
    };
    request('getCategoryGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if (goodsList.data == null) {
        Provide.value<CategoryProvide>(context)
            .changeNoMoreText(KString.noMoreText);
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .addCategoryGoodsList(goodsList.data);
      }
    });
  }

  //图片
  Widget _goodsImage(List newList, int index) {
    return Container(
      width: ScreenUtil.instance.setWidth(200),
      child: Image.network(newList[index].image),
    );
  }

  //商品名称
  Widget _goodsName(List newList, int index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil.instance.setWidth(370),
      child: Text(
        newList[index].name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil.instance.setSp(28)),
      ),
    );
  }

  //商品价格
  Widget _goodsPrice(List newList, int index) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      width: ScreenUtil.instance.setWidth(370),
      child: Row(
        children: <Widget>[
          Text(
            '¥${newList[index].presentPrice}',
            style: TextStyle(color: KColor.presentPriceTextColor),
          ),
          Text(
            '¥${newList[index].oriPrice}',
            style: KFont.oriPriceStyle,
          ),
        ],
      ),
    );
  }
}
