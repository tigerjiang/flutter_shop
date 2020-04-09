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

import '../config/index.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget{

  _HomePageState createState()=> _HomePageState();

}


class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{

  //防止刷新处理，保持当前状态
  @override
  bool get wantKeepAlive => true;


  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

  @override
  void initState(){
    super.initState();
    print('首页刷新了...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244,245,245,1.0),
      appBar: AppBar(title: Text(KString.homeTitle),),
      body: FutureBuilder(
        future: request('homePageContext', formData: null),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var data = json.decode(snapshot.data.toString());
            List<Map> swipDataList = (data['data']['slides'] as List).cast(); //轮播图
            List<Map> category = (data['data']['category'] as List).cast(); //分类
            List<Map> recommendList = (data['data']['recommend'] as List).cast(); //商品推荐
            List<Map> floor1 = (data['data']['floor1'] as List).cast();//底部商品推荐
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
                ],
              ),
              loadMore: () async {
                print('开始加载更多');
              },
            );

          }else{
            return Center(
              child: Text('加载中...'),
            );
          }
        },
      ),
    );
  }

//首页轮播组件编写



}