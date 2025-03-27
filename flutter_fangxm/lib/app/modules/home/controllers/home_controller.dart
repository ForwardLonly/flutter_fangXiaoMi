import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fangxm/app/modules/home/models/focus_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  final ScrollController scrollController = ScrollController();
  // 滚动是否大于20
  RxBool xOffIsBig20 = false.obs;
  // 广告轮播图的数据
  RxList adList = [].obs;

  @override
  void onInit() {
    super.onInit();

    // 对滚动添加监听
    _scrollControllerListener();
    // 获取广告轮播图的数据
    _getADScrollImagesRequest();
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

}
