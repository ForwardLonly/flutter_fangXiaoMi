import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fangxm/app/service/ScreenAdapter.dart';
import 'package:flutter_fangxm/app/service/store_service.dart';

import 'package:get/get.dart';

import '../controllers/searches_controller.dart';

class SearchesView extends GetView<SearchesController> {
  const SearchesView({super.key});

  // 自定义导航栏
  Widget _appBarTitleWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, Screenadapter.stateBarHeight(), 0, 0),
      child: Row(
        children: [
          // 返回按钮
          IconButton(
            onPressed: (){
              Get.back();
            }, 
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.black54)
          ),
          Expanded(child: Container(
            height: Screenadapter.height(96),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30)
            ),
            child: TextField(
              autofocus: true,
              style: TextStyle(
                color: Colors.black54,
                fontSize: Screenadapter.fontSize(36)
              ),
              decoration: InputDecoration(
                // 让文字居中
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(Icons.search, color: Colors.black54,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none
                )
              ),
              onChanged: (value) {
                controller.searchKeywords = value;
              },
              onSubmitted: (value) {
                // 保存搜索记录
                StoreService.setSearchHistoryString(controller.searchKeywords);
                // 替换路由，让搜索结果页返回根控制器
                Get.offAndToNamed("/product-list", arguments: {
                  "searchKeywords" : controller.searchKeywords
                });
              },
            ),
          )),
          TextButton(
            onPressed: (){
              // 保存搜索记录
              StoreService.setSearchHistoryString(controller.searchKeywords);
              // 跳转
              Get.offAndToNamed("/product-list", arguments: {
                "searchKeywords" : controller.searchKeywords
              });
            }, 
            child: Text(
              "搜索", 
              style: TextStyle(
                color: Colors.black87,
                fontSize: Screenadapter.fontSize(36)
              )
            )
          )
        ],
      ),
    );
  }

  // 内容视图
  Widget _bodyWidget() {
    return ListView(
      padding: EdgeInsets.all(Screenadapter.height(40)),
      children: [
        _searchListWidget(),
        _guessLikeSearchWideget(),
        SizedBox(height: 25),
         _hotSearchWidget()
      ],
    );
  }

  // 搜索历史
  Widget _searchListWidget() {
    return Obx((){
      if (controller.historyList.isNotEmpty) {
        return Column(
          children: [
            SizedBox(height: 5),
            _sectionHeaderWidget(
              "搜索历史", 
              IconButton(
                onPressed: (){
                  _clearHistoryAlert();
                }, 
                icon: Icon(Icons.delete_outline)
              )
            ),
            _sectionContentWidget(controller.historyList, true),
          ],
        );
      } else {
        return SizedBox(height: 0);
      }
    });
  }

  // 猜你想搜
  Widget _guessLikeSearchWideget() {
    return Column(
      children: [
        SizedBox(height: 20),
        _sectionHeaderWidget(
          "猜你想搜", 
          IconButton(
            onPressed: (){

            }, 
            icon: Icon(Icons.refresh)
          )
        ),
        _sectionContentWidget(["手机111", "电脑44","手机89", "电脑222", "手机", "电脑333", "手机", "电脑"], false)
      ],
    );
  }

  // 热搜商品
  Widget _hotSearchWidget() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.circular(10)
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: Screenadapter.height(138),
            decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/hot_search.png"))),
          ),
          Container(
            padding: EdgeInsets.all(Screenadapter.width(20)),
            child: GridView.builder(
                shrinkWrap: true, //收缩
                itemCount: 8, //必须设置
                padding: EdgeInsets.zero, // 移除默认的内边距
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: Screenadapter.width(40),
                    mainAxisSpacing: Screenadapter.height(20),
                    childAspectRatio: 3 / 1),
                itemBuilder: ((context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: Screenadapter.width(120),
                        padding: EdgeInsets.all(Screenadapter.width(10)),
                        child: Image.network(
                          "https://www.itying.com/images/shouji.png",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(Screenadapter.width(10)),
                          alignment: Alignment.centerLeft,
                          child: RichText(text: TextSpan(
                            style: TextStyle(color: Colors.black87, fontSize: Screenadapter.fontSize(32)), // 继承默认文本样式
                            children: [
                              TextSpan(text: '这是一段很长的文字222'),
                              WidgetSpan(
                                child: Icon(
                                  Icons.whatshot,
                                  color: Colors.red,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                          softWrap: true, // 允许换行
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                          )
                      ))
                    ],
                  );
                })),
          )
        ],
      ),
    
      );
  }

  // 组头
  Widget _sectionHeaderWidget(String title, IconButton icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title, 
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: Screenadapter.fontSize(42)
          )
        ),
        icon
      ],
    );
  }

  // 分组内容
  Widget _sectionContentWidget(List<String> data, bool isNeedAction) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.start,
        children: data.map((value){
          return GestureDetector(
            onLongPress: (){
              if (isNeedAction) {
                _removeSingleHistoryAlert(value);
              }
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(Screenadapter.width(30), Screenadapter.width(10), Screenadapter.width(30), Screenadapter.width(10)),
              margin: EdgeInsets.fromLTRB(Screenadapter.width(15), Screenadapter.width(20), Screenadapter.width(15), 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Text(value, style: TextStyle(fontSize: Screenadapter.fontSize(32), color: Colors.black87),),
            ),
          );
        }).toList(),
      )
    );
  }

  // 确认是否清空的弹框
  void _clearHistoryAlert() {
    Get.bottomSheet(Container(
      padding: EdgeInsets.all(Screenadapter.width(20)),
      width: double.infinity,
      height: Screenadapter.height(400),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
      ),
      child: Column(
        children: [
          SizedBox(height: Screenadapter.height(40)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "确定要清空历史记录吗？", 
                style: TextStyle(fontSize: Screenadapter.fontSize(42), fontWeight: FontWeight.bold))
            ],
          ),
          SizedBox(height: Screenadapter.height(40)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Screenadapter.width(420),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color.fromARGB(235, 222, 222, 219)),
                    foregroundColor: WidgetStatePropertyAll(Colors.white)
                  ),
                  onPressed: (){
                    Get.back();
                  }, 
                  child: Text("取消")
                ),
              ),
              SizedBox(
                width: Screenadapter.width(420),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color.fromARGB(235, 222, 222, 219)),
                    foregroundColor: WidgetStatePropertyAll(Colors.red)
                  ),
                  onPressed: (){
                    controller.clearSearchHistory();
                    Get.back();
                  }, 
                  child: Text("确定")
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }

  // 删除某条数据
  void _removeSingleHistoryAlert(String keyword) {
    Get.defaultDialog(
      title: "提示",
      middleText: "确定要删除\"$keyword\"这个记录吗?",
      confirm: ElevatedButton(
        onPressed: (){
          controller.removeSingleHistory(keyword);
          Get.back();
        }, 
        child: Text("确定")
      ),
      cancel: ElevatedButton(
        onPressed: (){
          Get.back();
        }, 
        child: Text("取消")
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Screenadapter.height(96)),
        child: _appBarTitleWidget()
      ),
      body: _bodyWidget(),
    );
  }
}

