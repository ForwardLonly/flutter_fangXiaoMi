import 'package:flutter/material.dart';
import 'package:flutter_fangxm/app/modules/cart/views/cart_view.dart';
import 'package:flutter_fangxm/app/modules/category/views/category_view.dart';
import 'package:flutter_fangxm/app/modules/give/views/give_view.dart';
import 'package:flutter_fangxm/app/modules/home/views/home_view.dart';
import 'package:flutter_fangxm/app/modules/user/views/user_view.dart';
import 'package:get/get.dart';

class TabsController extends GetxController {
  // 选中的索引值
  RxInt currentIndex = 0.obs;
  // 页面数组
  final List<Widget> pages = [
    HomeView(),
    CategoryView(),
    GiveView(),
    CartView(),
    UserView()
  ];
  // pageController
  PageController pageController = PageController(initialPage: 0);

  @override
  void onInit() {
    super.onInit();
  }


  @override
  void onClose() {
    super.onClose();
  }

  // 更新选中的索引
  void setCurrentIndex(int index) {
    currentIndex.value = index;
    update();
  }
}
