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
}
