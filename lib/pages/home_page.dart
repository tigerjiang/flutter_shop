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

class HomePage extends StatefulWidget{

  _HomePageState createState()=> _HomePageState();

}

class _HomePageState extends State<HomePage>{
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
            print(data);
            return Container(
              child: Text(''),
            );
          }else{
            return Container(
              child: Text('加载中...'),
            );
          }
        },
      ),
    );
  }


}