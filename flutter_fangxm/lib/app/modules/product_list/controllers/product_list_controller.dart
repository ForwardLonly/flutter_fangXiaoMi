import 'package:flutter/material.dart';
import 'package:flutter_fangxm/app/modules/home/models/product_mdel.dart';
import 'package:flutter_fangxm/app/service/https_client.dart';
import 'package:get/get.dart';

class ProductListController extends GetxController {

  // 页面
  int page = 1;
  // 每页请求的条数
  int pageSize = 8;
  // 是否有更多的数据
  bool hasMoreDate = true;
  // 是否正在加载中
  bool isLoading = false;
  // 滚动视图
  ScrollController scrollController = ScrollController();
  // 商品数据
  RxList<ProductItemMdel> productList = <ProductItemMdel>[].obs;
  // 筛选选中的索引
  RxInt selectIndex = 1.obs;


  @override
  void onInit() {
    super.onInit();
    // 添加滚动视图的监听
    _scrollControllerListener();
    // 获取商品列表的数据
    _getProductListRequest();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // 添加滚动视图的监听
  void _scrollControllerListener() {
    scrollController.addListener((){
      if (scrollController.position.pixels > scrollController.position.maxScrollExtent + 20) {
        if (isLoading == false && hasMoreDate == true) {
          isLoading = true;
          // 请求数据
          _getProductListRequest();
        } 
      }
    });
  }

  // 获取商品列表的数据
  void _getProductListRequest() async {
    final response = await HttpsClient.get("api/plist?page=$page&pageSize=$pageSize&cid=${Get.arguments["pid"]}");
    if (response.statusCode == 200) {
      final categoryModel = ProductMdel.fromJson(response.data);
      productList.addAll(categoryModel.result);
      if (categoryModel.result.length < pageSize) {
        hasMoreDate = false;
      } else {
        hasMoreDate = true;
      }
      isLoading = false;
      page ++;
      update();
    }
  }

  // 修改筛选选中的索引
  void updateSelectIndex(int index) {
    selectIndex.value = index;
    update();
  }

}
