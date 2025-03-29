import 'package:dio/dio.dart';
import 'package:flutter_fangxm/app/modules/home/models/category_model.dart';
import 'package:flutter_fangxm/app/service/https_client.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {

  // 左侧选中的索引
  RxInt leftSelectIndex = 0.obs;
  // 左侧索引的数据
  RxList leftCategoryList = [].obs;
  // 右侧分类的全部数据
  RxMap rightCategoryMap = <String, List>{}.obs;
  // 右侧分类的数据
  RxList rightCategoryList = [].obs;
 
  @override
  void onInit() {
    super.onInit();
    // 获取左侧索引的数据
    geteLeftCategryRequest();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // 更新左侧选中的索引
  void updateLeftIndexAction(int index) {
    leftSelectIndex.value = index;
    update();

    // 获取分类的数据
    getRightCategoryRequest("${leftCategoryList[index].sId}");
  }

  // 获取左侧索引的数据
  void geteLeftCategryRequest() async {
    final response = await HttpsClient.get("api/pcate");
    if (response.statusCode == 200) {
      final categoryModel = CategoryModel.fromJson(response.data);
      leftCategoryList.value = categoryModel.result;
      update();

      // 获取第一个分类的数据
      getRightCategoryRequest("${categoryModel.result.first.sId}");
    }
  }

  // 获取右侧分类的数据
  void getRightCategoryRequest(String id) async {
    if (rightCategoryMap[id] == null) {
      final response = await HttpsClient.get("api/pcate?pid=$id");
      if (response.statusCode == 200) {
        final categoryModel = CategoryModel.fromJson(response.data);
        rightCategoryMap[id] = categoryModel.result;
        rightCategoryList.value = categoryModel.result;
        update();
      }
    } else {
      rightCategoryList.value = rightCategoryMap[id];
      update();
    } 
  }
}
