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
  // 右侧侧边栏
  GlobalKey<ScaffoldState> stateGolbalKey = GlobalKey<ScaffoldState>();
  // 商品数据
  RxList<ProductItemMdel> productList = <ProductItemMdel>[].obs;
  // 筛选选中的索引
  RxInt selectIndex = 1.obs;
  // 筛选选中的箭头
  RxInt selectIndexArrow = 1.obs;
  /*二级导航数据*/
  List subHeaderList = [
    // 排序     升序：price_1     {price:1}        降序：price_-1   {price:-1}
    {"id": 1,"title": "综合","fileds": "all","sort": -1,},
    {"id": 2, "title": "销量", "fileds": 'salecount', "sort": -1},
    {"id": 3, "title": "价格", "fileds": 'price', "sort": -1},
    {"id": 4, "title": "筛选"}
  ];
  // 排序的数据
  String sort = "";
  // 搜索关键字
  String searchKeywords = Get.arguments["searchKeywords"] ?? "";
  // 分类id
  String? pid = Get.arguments["pid"];

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
    print("api/plist?page=$page&pageSize=$pageSize&cid=${Get.arguments["pid"]}&sort=$sort");
    String apiUrl = "";
    if (pid != null) {
      apiUrl = "api/plist?page=$page&pageSize=$pageSize&cid=$pid&sort=$sort";
    } else {
      apiUrl = "api/plist?page=$page&pageSize=$pageSize&search=$searchKeywords&sort=$sort";
    }
    final response = await HttpsClient.get(apiUrl);
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
    if (index == 4) {
      selectIndex.value = index;
      stateGolbalKey.currentState?.openEndDrawer();
      update();
      return;
    }
    if (selectIndex.value == index) {
      // 如果索引相等，就改变箭头
      subHeaderList[index - 1]["sort"] = subHeaderList[index - 1]["sort"] * (-1);
      // 先清空一下数据，不然可能不会触发selectIndexArrow值的改变
      selectIndexArrow.value = 0;
      selectIndexArrow.value = subHeaderList[index - 1]["sort"];
    }
    selectIndex.value = index;
    // 获取搜索的数据
    sort = "${subHeaderList[index - 1]["fileds"]}_${subHeaderList[index - 1]["sort"]}";
    
    // 重置page
    page = 1;
    // 重置数据
    if (productList.isNotEmpty) {
      // 重置滚动的位置
      scrollController.jumpTo(0);
      // 重置数据
      productList.value = [];
    }
    // 重置是否有更多数据
    hasMoreDate = true;
    // 重新请求数据
    _getProductListRequest();

    update();
  }

}
