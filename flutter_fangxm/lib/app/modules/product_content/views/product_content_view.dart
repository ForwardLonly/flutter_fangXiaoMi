import 'package:flutter/material.dart';
import 'package:flutter_fangxm/app/service/ScreenAdapter.dart';

import 'package:get/get.dart';

import '../controllers/product_content_controller.dart';

class ProductContentView extends GetView<ProductContentController> {
  const ProductContentView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 实现透明导航 第一步
      extendBodyBehindAppBar: true, 
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Screenadapter.height(140)),
        child: _appBarWidget()
      ),
      body: _bodyWidget(),
    );
  }

  // 自定义导航栏
  Widget _appBarWidget() {
    return Obx(()=> AppBar(
      leading: _appBarLeadingWidget(),
      title: _appBarTitleWidget(),
      centerTitle: true,
      // 实现透明导航 第二步
      backgroundColor: Colors.white.withAlpha(controller.opacity.value),
      // 实现透明导航 第三步
      elevation: 0,
      actions: _appBarAtionsWidget(),
    ));
  }
  // 自定义 返回按钮
  Widget _appBarLeadingWidget() {
    return Container(
      // 需要添加这一句，不然子控件设置的宽高不管用
      alignment: Alignment.center,
      child: SizedBox(
        width: Screenadapter.width(100),
        height: Screenadapter.width(100),
        child: ElevatedButton(
          style: ButtonStyle(
            padding: WidgetStateProperty.all(EdgeInsets.all(0)) ,
            backgroundColor: WidgetStateProperty.all(Colors.black12),
            shape: WidgetStateProperty.all(CircleBorder())
          ),
          onPressed: (){
            Get.back();
          }, 
          child: Icon(Icons.arrow_back_ios_new, color: Colors.white)
        )
      ),
    );
  }
  // 自定义标题内容
  Widget _appBarTitleWidget() {
    if (controller.isShowTabs.value == true) {
      return Container(
        width: Screenadapter.width(400),
        height: Screenadapter.height(110),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: controller.tabsList.map((value){
            return InkWell(
              onTap: (){
                int index = value["id"];
                controller.updateTabsSelectIndex(index);
                // tab点击跳转到对应的锚点：第四步， 跳转实现
                if (index == 1) {
                  Scrollable.ensureVisible(
                    controller.gk1.currentContext as BuildContext,
                    duration: Duration(milliseconds: 100)
                  );
                } else if (index == 2) {
                  Scrollable.ensureVisible(
                    controller.gk2.currentContext as BuildContext,
                    duration: Duration(milliseconds: 100)
                  );
                } else {
                  Scrollable.ensureVisible(
                    controller.gk3.currentContext as BuildContext,
                    duration: Duration(milliseconds: 100)
                  );
                }
                
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${value["title"]}", style: TextStyle(fontSize: Screenadapter.fontSize(36))),
                  Container(
                    margin: EdgeInsets.only(top: Screenadapter.height(10)),
                    color: (value["id"] == controller.selectTabsIndex.value) ? Colors.red : Colors.transparent,
                    width: Screenadapter.width(100),
                    height: Screenadapter.height(2),
                  )
                ]
              )
            );
          }).toList(),
        ),
      );
    } else {
      return Text("");
    }
    
     
  }

  // 自定义右边操作视图
  List<Widget> _appBarAtionsWidget() {
    return [
      Container(
        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
        width: Screenadapter.width(100),
        height: Screenadapter.width(100),
        child: ElevatedButton(
          style: ButtonStyle(
            padding: WidgetStateProperty.all(EdgeInsets.all(0)) ,
            backgroundColor: WidgetStateProperty.all(Colors.black12),
            shape: WidgetStateProperty.all(CircleBorder())
          ),
          onPressed: (){}, 
          child: Icon(Icons.file_upload_outlined, color: Colors.white)
        )
      ),
      Container(
        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
        width: Screenadapter.width(100),
        height: Screenadapter.width(100),
        child: ElevatedButton(
          style: ButtonStyle(
            padding: WidgetStateProperty.all(EdgeInsets.all(0)) ,
            backgroundColor: WidgetStateProperty.all(Colors.black12),
            shape: WidgetStateProperty.all(CircleBorder())
          ),
          onPressed: (){}, 
          child: Icon(Icons.more_horiz_rounded, color: Colors.white)
        )
      ),
    ];
  }

  // 自定义内容视图
  Widget _bodyWidget() {
    // tab点击跳转到对应的锚点：第二步， 用SingleChildScrollView代替ListView
    return SingleChildScrollView(
      controller: controller.scrollController,
      child: Column(
        children: [
          Container(
            // tab点击跳转到对应的锚点：第三步， 控件关联对应的key
            key: controller.gk1,
            color: Colors.orange,
            alignment: Alignment.center,
            height: Screenadapter.height(1800),
            child: Text("商品", style: TextStyle(fontSize: 100)),
          ),
          Container(
            // tab点击跳转到对应的锚点：第三步， 控件关联对应的key
            key: controller.gk2,
            color: Colors.blue,
            alignment: Alignment.center,
            height: Screenadapter.height(2800),
            child: Text("详情", style: TextStyle(fontSize: 100)),
          ),
          Container(
            // tab点击跳转到对应的锚点：第三步， 控件关联对应的key
            key: controller.gk3,
            color: Colors.red,
            alignment: Alignment.center,
            height: Screenadapter.height(3800),
            child: Text("推荐", style: TextStyle(fontSize: 100)),
          ),
        ],
      ),
    );
  }

}
