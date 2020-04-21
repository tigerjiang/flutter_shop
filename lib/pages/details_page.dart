/*
 *  Copyright (c) 17/4/2020
 *
 *  Created by Tiger
 *
 *  mail : jzh2012@163.com
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/config/string.dart';
import 'dart:convert';
import '../config/http_conf.dart';
import '../service/http_service.dart';
import '../provide/details_info_provide.dart';
import 'package:provide/provide.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(KString.detailsPageTitle),
        ),
        body: FutureBuilder(
          future: _getGoodsInfo(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: <Widget>[
                  ListView(
                    children: <Widget>[],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Text('底部组件'),
                  ),
                ],
              );
            } else {
              return Text('加载中...');
            }
          },
        ),
      ),
    );
  }

  Future _getGoodsInfo(BuildContext context) async {
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    return '完成加载';
  }
}
