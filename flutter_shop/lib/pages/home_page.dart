/*
 * Copyright (c) 29/3/2020
 *
 * Created by Tiger
 *
 * mail : jzh2012@163.com
 */


import 'package:flutter/cupertino.dart';
import 'package:shop/config/string.dart';

class HomePage extends StatefulWidget{

  _HomePageState createState()=> _HomePageState();

}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text(KString.homeTitle),
    );
  }


}