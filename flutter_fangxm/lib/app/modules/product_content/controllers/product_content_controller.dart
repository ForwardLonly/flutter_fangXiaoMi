import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductContentController extends GetxController {

  final ScrollController scrollController = ScrollController();
  RxInt opacity = 0.obs;
  List tabsList = [
    {
      "id": 1,
      "title": "商品"
    },
    {
      "id": 2,
      "title": "详情"
    },
    {
      "id": 3,
      "title": "推荐"
    },
  ];

  RxInt selectTabsIndex = 1.obs;
  RxBool isShowTabs = false.obs;
  // tab点击跳转到对应的锚点：第一步
  GlobalKey gk1 = GlobalKey();
  GlobalKey gk2 = GlobalKey();
  GlobalKey gk3 = GlobalKey();


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
        if (isShowTabs.value == true) {
          isShowTabs.value = false;
        }
        update();
      } else {
        if (opacity.value < 255) {
          opacity.value = 255;
          isShowTabs.value = true;
          update();
        } else {
          if (isShowTabs.value == false) {
            isShowTabs.value = true;
            update();
          } 
        }
      }
    });
  }

  // 更新tab选中的索引
  void updateTabsSelectIndex(int index) {
    selectTabsIndex.value = index;
    update();
  }
}
