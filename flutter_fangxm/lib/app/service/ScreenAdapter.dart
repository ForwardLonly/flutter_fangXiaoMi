import 'package:flutter_screenutil/flutter_screenutil.dart';

class Screenadapter {
  static width(num width) {
    return width.w;
  }

  static height(num height) {
    return height.h;
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
}