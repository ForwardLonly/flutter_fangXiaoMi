import 'package:flutter/material.dart';
import 'package:flutter_fangxm/app/service/ScreenAdapter.dart';
import 'package:flutter_fangxm/app/sources/FangXMIcon.dart';

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
        child: _appBarWidget(context)
      ),
      body: _bodyWidget(),
    );
  }

  // 自定义导航栏
  Widget _appBarWidget(BuildContext context) {
    return Obx(()=> AppBar(
      leading: _appBarLeadingWidget(),
      title: _appBarTitleWidget(),
      centerTitle: true,
      // 实现透明导航 第二步
      backgroundColor: Colors.white.withAlpha(controller.opacity.value),
      // 实现透明导航 第三步
      elevation: 0,
      actions: _appBarAtionsWidget(context),
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
  List<Widget> _appBarAtionsWidget(BuildContext context) {
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
          onPressed: (){
            _showMoreButtonMenu(context);
          }, 
          child: Icon(Icons.more_horiz_rounded, color: Colors.white)
        )
      ),
    ];
  }

  // 自定义内容视图
  Widget _bodyWidget() {
    return Stack(
      children: [
        _bodyContentWidget(),
        _bottomTabbarWidget()
      ],
    );
  }

  Widget _bodyContentWidget() {
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
          _bottomTabbarWidget()
        ],
      ),
    );
  }

  // 显示弹窗
  void _showMoreButtonMenu(BuildContext context) {
    showMenu(
      color: Colors.black38,
      context: context, 
      position: RelativeRect.fromLTRB(
        Screenadapter.width(800), 
        Screenadapter.height(300), 
        Screenadapter.width(20), 
        0
      ), 
      items: [
        PopupMenuItem(child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, color: Colors.white),
            SizedBox(width: 10),
            Text("首页", style: TextStyle(color: Colors.white))
          ],
        )),
        PopupMenuItem(child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.message, color: Colors.white),
            SizedBox(width: 10),
            Text("消息", style: TextStyle(color: Colors.white))
          ],
        )),
        PopupMenuItem(child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, color: Colors.white),
            SizedBox(width: 10),
            Text("收藏", style: TextStyle(color: Colors.white))
          ],
        )),
      ]
    );
  }

  // 底部浮动导航栏
  Widget _bottomTabbarWidget() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        height: Screenadapter.width(190),
        padding: EdgeInsets.fromLTRB(0, Screenadapter.width(20), Screenadapter.width(40), 0),
        decoration: BoxDecoration(
          color: Colors.white,
          // 只设置一条边框
          border: Border(
            top: BorderSide(width: Screenadapter.width(2), color: Colors.black12),
          )
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: Screenadapter.width(470),
              height: Screenadapter.width(130),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.question_answer, color: Colors.black54, size: Screenadapter.width(60)),
                      Text("客服", style: TextStyle(color: Colors.black87, fontSize: Screenadapter.fontSize(32)),)
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FangXMIcon.fuwu, color: Colors.black54, size: Screenadapter.width(60)),
                      Text("收藏", style: TextStyle(color: Colors.black87, fontSize: Screenadapter.fontSize(32)),)
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart_checkout, color: Colors.black54, size: Screenadapter.width(60)),
                      Text("购物车", style: TextStyle(color: Colors.black87, fontSize: Screenadapter.fontSize(32)),)
                    ],
                  ),
                ],
              ),
            ),
            Expanded(child: SizedBox(
              height: Screenadapter.width(110),
              child: ElevatedButton(
                onPressed: (){

                }, 
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(EdgeInsets.zero),
                  backgroundColor: WidgetStatePropertyAll(Colors.orange),
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                  // 按钮设置圆角
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Screenadapter.width(55)),
                        bottomLeft: Radius.circular(Screenadapter.width(55)),
                      ) 
                    )
                  )
                ),
                child: Text("加入购物车", style: TextStyle(fontSize: Screenadapter.fontSize(40)))
              ),
            )),
            Expanded(child: Container(
              height: Screenadapter.width(110),
              child: ElevatedButton(
                onPressed: (){

                }, 
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(EdgeInsets.zero),
                  backgroundColor: WidgetStatePropertyAll(Color.fromARGB(235, 232, 59, 11)),
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Screenadapter.width(55)),
                        bottomRight: Radius.circular(Screenadapter.width(55)),
                      ) 
                    )
                  )
                ),
                child: Text("立即购买", style: TextStyle(fontSize: Screenadapter.fontSize(40)))
              ),
            )),
          ],
        ),
      )
    );
  }

}
