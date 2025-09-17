import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StoreService {

  static final _searchKey = "SearchHistory";

  // 获取搜索历史记录
  static Future<List<String>> getSearchHistoryListString() async {
    var shareInstance = await SharedPreferences.getInstance();
    try {
      List<String>? stringList = shareInstance.getStringList(_searchKey);
      if (stringList != null) {
        return stringList;
      } else {
        print("搜索历史记录 没有数据");
        return [];
      }
    } catch (e) {
      print("搜索历史记录 没有数据");
      return [];
    }
  }
  
  // 设置搜索数据
  static Future<List> setSearchHistoryString(String keyword) async {
    var shareInstance = await SharedPreferences.getInstance();
    try {
      List<String>? stringList = shareInstance.getStringList(_searchKey);
      if (stringList != null) {
        if (stringList.contains(keyword)) {
          // 历史记录包含了当前关键字，就把当前关键字提前
          stringList.remove(keyword);
          stringList.insert(0, keyword);
          shareInstance.setStringList(_searchKey, stringList);
        } else {
          // 历史记录不包含当前关键字
          stringList.insert(0, keyword);
          shareInstance.setStringList(_searchKey, stringList);
        } 
        return stringList;
      } else {
        stringList = [];
        stringList.add(keyword);
        shareInstance.setStringList(_searchKey, stringList);
        return stringList;
      }
    } catch (e) {
      print("保存搜索历史记录失败");
      return [];
    }
  }

  // 删除某个历史数据
  static Future<List> deleteSearchHistory(String keyword) async {
    var shareInstance = await SharedPreferences.getInstance();
    try {
      List<String>? stringList = shareInstance.getStringList(_searchKey); 
      if (stringList != null) {
        if (stringList.contains(keyword)) {
          stringList.remove(keyword);
          shareInstance.setStringList(_searchKey, stringList);
          return stringList;
        } else {
          return stringList;
        }
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  // 清空搜索历史记录
  static clearSearchHistory() async {
    var shareInstance = await SharedPreferences.getInstance();
    try {
      shareInstance.remove(_searchKey);
    } catch (e) {
      print(e);
    }
  }

}