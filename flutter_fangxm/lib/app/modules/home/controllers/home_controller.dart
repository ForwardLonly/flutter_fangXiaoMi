import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fangxm/app/modules/home/models/category_model.dart';
import 'package:flutter_fangxm/app/modules/home/models/focus_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  final ScrollController scrollController = ScrollController();
  // 滚动是否大于20
  RxBool xOffIsBig20 = false.obs;
  // 广告轮播图的数据
  RxList adList = [].obs;
  // 分类的数据
  RxList categoryList = [].obs;
  // 广告的推荐图片
  final List<String> adRecommendPicList = [
    "https://cdn.cnbj1.fds.api.mi-img.com/mi-mall/e981f78d2ac17c504975a719cb8b069d.png?w=632&h=340",
    "https://cdn.cnbj1.fds.api.mi-img.com/mi-mall/6b04dfc206dec442fe161b33082681ec.png?w=632&h=340",
    "https://cdn.cnbj1.fds.api.mi-img.com/mi-mall/6b0c7fadbd84a808287af5faad6e62d7.png?w=632&h=340"
  ];

  @override
  void onInit() {
    super.onInit();

    // 对滚动添加监听
    _scrollControllerListener();
    // 获取广告轮播图的数据
    _getADScrollImagesRequest();
    // 获取分类的数据
    _getCategoryRequest();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // 添加滚动视图的监听
  void _scrollControllerListener() {
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

  // 获取广告轮播图的数据
  void _getADScrollImagesRequest() async {
    final response = await Dio().get("https://miapp.itying.com/api/focus");
    if (response.statusCode == 200) {
      final focusModel = FocusModel.fromJson( response.data);
      adList.value = focusModel.result;
      update();
    }
  }

  // 获取分类的数据
  void _getCategoryRequest() async {
    final response = await Dio().get("https://miapp.itying.com/api/bestCate");
    if (response.statusCode == 200) {
      final categoryModel = CategoryModel.fromJson(response.data);
      categoryList.value = categoryModel.result;
      update();
    }
  }

}
