/*
 *  Copyright (c) 17/4/2020
 *
 *  Created by Tiger
 *
 *  mail : jzh2012@163.com
 */

import 'package:fluro/fluro.dart';
import '../pages/details_page.dart';
import 'package:flutter/material.dart';

Handler detailsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String goodsId = params['id'].first;
  return DetailsPage(goodsId);
});
