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
import 'package:shop/config/string.dart';
import '../service/http_service.dart';
import 'dart:convert';

import '../config/index.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  //火爆专区分页
  int page = 1;
  //火爆专区数据
  List<Map> hotGoodsList = [];

  //防止刷新处理，保持当前状态
  @override
  bool get wantKeepAlive => true;

  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  @override
  void initState() {
    super.initState();
    print('首页刷新了...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      appBar: AppBar(
        title: Text(KString.homeTitle),
      ),
      body: FutureBuilder(
        future: request('homePageContext', formData: null),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            List<Map> swiperDataList =
                (data['data']['slides'] as List).cast(); //轮播图
            List<Map> navigatorList =
                (data['data']['category'] as List).cast(); //分类
            List<Map> recommendList =
                (data['data']['recommend'] as List).cast(); //商品推荐
            List<Map> floor1 = (data['data']['floor1'] as List).cast(); //底部商品推荐
            Map fp1 = data['data']['floor1Pic']; //广告

            return EasyRefresh(
              refreshFooter: ClassicsFooter(
                key: _footerKey,
                bgColor: Colors.white,
                textColor: KColor.refreshTextColor,
                moreInfoColor: KColor.refreshTextColor,
                showMore: true,
                noMoreText: '',
                moreInfo: KString.loading,
                loadReadyText: KString.loadReadyText,
              ),
              child: ListView(
                children: <Widget>[
                  SwiperDiy(
                    swiperDataList: swiperDataList,
                  ),
                  TopNavigator(navigatorList: navigatorList),
                  RecommendUi(recommendList: recommendList),
                  FloorPicUi(floorPic: fp1),
                  Floor(floor: floor1,),
                  _hotGoods(),
                ],
              ),
              loadMore: () async {
                print('开始加载更多');
                _hotGoodsFetch();
              },
            );
          } else {
            return Center(
              child: Text('加载中...'),
            );
          }
        },
      ),
    );
  }


  void _hotGoodsFetch(){
    var fromPage = {'page':page};
    request("getHotGoods",formData: fromPage).then((val){
      var data = json.decode(val.toString());
      List<Map> newGoodsList = (data['data'] as List).cast();
      //设置火爆专区数据列表
      setState(() {
        hotGoodsList.addAll(newGoodsList);
        page++;
      });
    });
  }

  //火爆专区title
  Widget _hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    padding: EdgeInsets.all(5.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
        bottom: BorderSide(width: 0.5, color: KColor.defaultBorderColor),
      )
    ),
    //火爆专区
    child: Text(KString.hotTitleText, style: TextStyle(color: KColor.homeSubtitleColor),),
  );
  //火爆专区item
  Widget _wrapList(){
    if(hotGoodsList.length!=0){
      List<Widget> listWidget = hotGoodsList.map((val){
        return InkWell(
          onTap: (){},
          child: Container(
            width: ScreenUtil.instance.setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(val['image'],
                  width : ScreenUtil.instance.setWidth(375),
                  height: ScreenUtil.instance.setHeight(200),
                  fit: BoxFit.cover,),
                
                Text(
                  val['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: ScreenUtil.instance.setSp(26),color: KColor.presentPriceTextColor),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      '¥${val['presentPrice']}',
                       style: TextStyle(color: KColor.presentPriceTextColor),
                    ),
                    Text(
                      '¥${val['oriPrice']}',
                      style: KFont.oriPriceStyle,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();
      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    }else{
      return Text('');
    }
  }

  Widget _hotGoods(){
    return Container(
      child: Column(
        children: <Widget>[
          _hotTitle,
        _wrapList(),
        ],
      ),
    );
  }
}

//首页轮播组件编写
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Container(
      color: Colors.white,
      height: ScreenUtil.instance.setHeight(333),
      width: ScreenUtil.instance.setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
              onTap: () {},
              child: Image.network(
                "${swiperDataList[index]['image']}",
                fit: BoxFit.cover,
              ));
        },
        //图片数量
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

//商品分类
class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUi(BuildContext context, item, index) {
    return InkWell(
      onTap: () {
        // 跳转到分类页面
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: ScreenUtil.instance.setWidth(95)),
          Text(item['firstCategoryName']),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (navigatorList.length > 10) {
      navigatorList.removeRange(10, navigatorList.length);
    }
    var tempIndex = -1;
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 5.0),
      padding: EdgeInsets.all(3.0),
      height: ScreenUtil.instance.setHeight(320),
      child: GridView.count(
        //禁止滚动
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: EdgeInsets.all(4.0),
        children: navigatorList.map((item) {
          tempIndex++;
          return _gridViewItemUi(context, item, tempIndex);
        }).toList(),
      ),
    );
  }
}

//商品分类
class RecommendUi extends StatelessWidget {
  final List recommendList;

  RecommendUi({Key key, this.recommendList}) : super(key: key);

  //推荐商品标题
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            bottom: BorderSide(width: 0.5, color: KColor.defaultBorderColor)),
      ),
      child: Text(
        KString.recommendText, //商品推荐
        style: TextStyle(color: KColor.homeSubtitleColor),
      ),
    );
  }

  //商品推荐列表
  Widget _recommendListUi(BuildContext context) {
    return Container(
      height: ScreenUtil.instance.setHeight(280),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recommendList.length,
          itemBuilder: (context, index) {
            return _recommendItemUi(context, index);
          }),
    );
  }

  Widget _recommendItemUi(BuildContext context, index) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: ScreenUtil.instance.setWidth(280),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                left:
                    BorderSide(width: 0.5, color: KColor.defaultBorderColor))),
        child: Column(
          children: <Widget>[
            //防止溢出
            Expanded(
              child: Image.network(
                recommendList[index]['image'],
                fit: BoxFit.contain,
              ),
            ),
            Text(
              '¥${recommendList[index]['presentPrice']}',
              style: TextStyle(
                color: KColor.presentPriceTextColor,
              ),
            ),
            Text(
              '¥${recommendList[index]['oriPrice']}',
              style: KFont.oriPriceStyle,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendListUi(context),
        ],
      ),
    );
  }
}
//商品中间的广告位
class FloorPicUi extends StatelessWidget {
  final Map floorPic;

  FloorPicUi({Key key, this.floorPic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: InkWell(
        child: Image.network(
          floorPic['PICTURE_ADDRESS'],
          fit: BoxFit.cover,
        ),
        onTap: () {},
      ),
    );
  }
}
//商品推荐底部
class Floor extends StatelessWidget{
  final List floor;

  Floor({Key key, this.floor}):super(key:key);

  void jumpDetail(BuildContext context, goodId){

  }
  @override
  Widget build(BuildContext context) {
    double width = ScreenUtil.getInstance().width;
    return Container(
      child: Row(
       children: <Widget>[
         //左侧商品
         Expanded(
           child: Column(
            children: <Widget>[
              //左上图
              Container(
                padding: EdgeInsets.only(top: 4, right: 1),
                height: ScreenUtil.instance.setHeight(400),
                child: InkWell(
                  child: Image.network(this.floor[0]['image'],fit: BoxFit.cover,),
                  onTap: (){
                    jumpDetail(context,floor[0]['goodsId']);
                  },
                ),
              ),
              //左下图
              Container(
                padding: EdgeInsets.only(top: 1,right: 1),
                height: ScreenUtil.instance.setHeight(200),
                child: InkWell(
                  child: Image.network(this.floor[1]['image'],fit: BoxFit.cover,),
                  onTap: (){
                    jumpDetail(context,floor[1]['goodsId']);
                  },
                ),
              )
            ],
           ),
         ),
         //右侧商品
         Expanded(
           child: Column(
             children: <Widget>[
               //右上图
               Container(
                 padding: EdgeInsets.only(top: 4,left: 1, bottom: 1),
                 height: ScreenUtil.instance.setHeight(200),
                 child: InkWell(
                   child: Image.network(this.floor[2]['image'],fit: BoxFit.cover,),
                   onTap: (){
                     jumpDetail(context,floor[2]['goodsId']);
                   },
                 ),
               ),
               //右中图
               Container(
                 padding: EdgeInsets.only(top: 1,left: 1),
                 height: ScreenUtil.instance.setHeight(200),
                 child: InkWell(
                   child: Image.network(this.floor[3]['image'],fit: BoxFit.cover,),
                   onTap: (){
                     jumpDetail(context,floor[3]['goodsId']);
                   },
                 ),
               ),
               //右下图
               Container(
                 padding: EdgeInsets.only(top: 1,left: 1),
                 height: ScreenUtil.instance.setHeight(200),
                 child: InkWell(
                   child: Image.network(this.floor[4]['image'],fit: BoxFit.cover,),
                   onTap: (){
                     jumpDetail(context,floor[4]['goodsId']);
                   },
                 ),
               )
             ],
           ),
         )
       ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }

}
