import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  final ScrollController scrollController = ScrollController();
  // 滚动是否大于20
  RxBool xOffIsBig20 = false.obs;

  @override
  void onInit() {
    super.onInit();

    // 对滚动添加监听
    scrollController.addListener((){
      if (scrollController.position.pixels > 20) {
        if (xOffIsBig20.value == false) {
          print("滚动大于20，要改变状态啦");
          xOffIsBig20.value = true;
          update();
        }
      } else {
        if (xOffIsBig20.value == true) {
          print("滚动小于20，要改变状态啦");
          xOffIsBig20.value = false;
          update();
        }
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

}
