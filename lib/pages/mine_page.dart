/*
 * Copyright (c) 29/3/2020
 *
 * Created by Tiger
 *
 * mail : jzh2012@163.com
 */


import 'package:flutter/cupertino.dart';
import 'package:shop/config/string.dart';

class MinePage extends StatefulWidget{

  _MinePageState createState()=> _MinePageState();
  
}

class _MinePageState extends State<MinePage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text(KString.personTitle),
    );
  }


}