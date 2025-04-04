import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_fangxm/app/modules/home/models/category_model.dart';
import 'package:flutter_fangxm/app/modules/home/models/focus_model.dart';
import 'package:flutter_fangxm/app/modules/home/models/product_mdel.dart';
import 'package:flutter_fangxm/app/service/ScreenAdapter.dart';
import 'package:flutter_fangxm/app/service/https_client.dart';
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
  // 热销甄选的轮播图
  RxList hotSellSwiperList = [].obs;
  // 热销甄选的数据
  RxList hotSellRecommendList = [].obs;
  // 商品列表的数据
  RxList goodsList = [].obs;

  @override
  void onInit() {
    super.onInit();

    // 对滚动添加监听
    _scrollControllerListener();
    // 获取广告轮播图的数据
    _getADScrollImagesRequest();
    // 获取分类的数据
    _getCategoryRequest();
    // 获取热销甄选轮播图的数据
    _getHotSellSwiperRequest();
    // 获取热销甄选的推荐数据
    _getHotSelRecommendRequest();
    // 获取商品的数据
    _getGoodsListRequest();
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
    final response = await HttpsClient.get("api/focus");
    if (response.statusCode == 200) {
      final focusModel = FocusModel.fromJson( response.data);
      adList.value = focusModel.result;
      update();
    }
  }

  // 获取分类的数据
  void _getCategoryRequest() async {
    final response = await HttpsClient.get("api/bestCate");
    if (response.statusCode == 200) {
      final categoryModel = CategoryModel.fromJson(response.data);
      categoryList.value = categoryModel.result;
      update();
    }
  }

  // 获取热销甄选轮播图的数据
  void _getHotSellSwiperRequest() async {
    final response = await HttpsClient.get("api/focus?position=2");
    if (response.statusCode == 200) {
      final sellModel = FocusModel.fromJson( response.data);
      hotSellSwiperList.value = sellModel.result;
      update();
    }
  }

   // 获取热销甄选的推荐数据
  void _getHotSelRecommendRequest() async {
    final response = await HttpsClient.get("api/plist?is_hot=1");
    if (response.statusCode == 200) {
      final productModel = ProductMdel.fromJson( response.data);
      hotSellRecommendList.value = productModel.result;
      update();
    }
  } 

  // 获取商品的数据
  void _getGoodsListRequest() async {
    final response = await HttpsClient.get("api/plist");
    if (response.statusCode == 200) {
      final productModel = ProductMdel.fromJson( response.data);
      goodsList.value = productModel.result;
      update();
    }
  } 

  // 获取顶部高度
  double getTopMargin() {
    double topMargin;
    if (Screenadapter.stateBarHeight() > 20) {
      topMargin = Screenadapter.height(100 + Screenadapter.stateBarHeight());
    } else {
      topMargin = Screenadapter.height(44 + Screenadapter.stateBarHeight());
    }
    return topMargin;
  }
}
