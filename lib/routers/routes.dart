/*
 *  Copyright (c) 17/4/2020
 *
 *  Created by Tiger
 *
 *  mail : jzh2012@163.com
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'router_handler.dart';

class Routes {
  static String root = '/';
  static String detailsPage = '/detail';

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('error ::: 没有匹配的router');
      return Text('error');
    });
    router.define(detailsPage, handler: detailsHandler);
  }
}
