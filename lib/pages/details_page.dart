/*
 *  Copyright (c) 17/4/2020
 *
 *  Created by Tiger
 *
 *  mail : jzh2012@163.com
 */


import 'package:flutter/cupertino.dart';
import 'package:shop/config/string.dart';

class DetailsPage extends StatelessWidget{
  final String goodsId;
  DetailsPage(this.goodsId);
  @override
  Widget build(BuildContext context) {

    return Container(
      child : Center(
        child: Text('详情页面 ${goodsId}'),
      )
    );
  }
}