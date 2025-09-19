import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductContentController extends GetxController {

  final ScrollController scrollController = ScrollController();
  RxInt opacity = 0.obs;


  @override
  void onInit() {
    super.onInit();
    // 监听滚动条滚动事件
    _scrollControllerListener();
  }


  @override
  void onClose() {
    super.onClose();
  }


  // 监听滚动条滚动事件
  void _scrollControllerListener() {
    scrollController.addListener((){
      if (scrollController.position.pixels <= 100) {
        opacity.value = (scrollController.position.pixels / 100 * 255).toInt();
        print(opacity.value );
        update();
      } else {
        if (opacity.value < 255) {
          opacity.value = 255;

         update();
        }
      }
    });
  }
}
