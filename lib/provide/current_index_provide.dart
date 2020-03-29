
/*
 * Copyright (c) 29/3/2020
 *
 * Created by Tiger
 *
 * mail : jzh2012@163.com
 */

import 'package:flutter/material.dart';

class CurrentIndexProvide with ChangeNotifier{
  int currentIndex = 0;
  changeIndex(int newIndex){
    currentIndex = newIndex;
    notifyListeners();
  }
}