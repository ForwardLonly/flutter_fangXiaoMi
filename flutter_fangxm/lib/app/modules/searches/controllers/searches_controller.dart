import 'package:flutter_fangxm/app/service/store_service.dart';
import 'package:get/get.dart';

class SearchesController extends GetxController {

  String searchKeywords = "";
  RxList<String> historyList = <String>[].obs; 

  @override
  void onInit() {
    super.onInit();
    getHistoryData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // 获取历史记录
  getHistoryData() async {
    List<String> tempList = await StoreService.getSearchHistoryListString();
    if (tempList.isNotEmpty) {
      historyList.addAll(tempList);
      update();
    }
  }

  // 清空历史记录
  clearSearchHistory() async {
    await StoreService.clearSearchHistory();
    historyList.clear();
    update();
  }

  // 删除某条记录
  removeSingleHistory(String keyword) async {
    await StoreService.deleteSearchHistory(keyword);
    if (historyList.isNotEmpty) {
      historyList.remove(keyword);
      update();
    }
  }
}
