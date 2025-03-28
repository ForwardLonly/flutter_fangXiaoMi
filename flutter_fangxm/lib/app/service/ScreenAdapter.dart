import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Screenadapter {
  static width(num width) {
    return width.w;
  }

  static height(num height) {
    // return height.h;
    return height.w;
  }

  static fontSize(num size) {
    return size.sp;
  }

  static screenWidth() {
    return ScreenUtil().screenWidth;
  }

  static screenHeight() {
    return ScreenUtil().screenHeight;
  }

  static stateBarHeight() {
    return ScreenUtil().statusBarHeight;
  }

  static navigationBarHeight() {
    return AppBar().preferredSize.height;
  }
}