import 'package:flutter/material.dart';
import 'package:flutter_fangxm/app/sources/FangXMIcon.dart';
import 'package:get/get.dart';
import '../controllers/tabs_controller.dart';

class TabsView extends GetView<TabsController> {
  const TabsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        body: PageView(
          // 让页面可以左右滑动
          controller: controller.pageController,
          children: controller.pages,
          onPageChanged: (index){
            // 改变tab的索引
            controller.setCurrentIndex(index);
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.red,
          currentIndex: controller.currentIndex.value,
          type: BottomNavigationBarType.fixed,
          onTap: (index){
            // 改变tab的索引
            controller.setCurrentIndex(index);
            // 改变对应的页面索引
            controller.pageController.jumpToPage(index);
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
            BottomNavigationBarItem(icon: Icon(Icons.category), label: "分类"),
            BottomNavigationBarItem(icon: Icon(FangXMIcon.fuwu), label: "服务"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "购物车"),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: "用户"),
          ]
        ),
      );
    });
  }
}
