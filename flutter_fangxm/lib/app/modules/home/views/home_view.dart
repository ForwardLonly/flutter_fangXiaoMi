import 'package:flutter/material.dart';
import 'package:flutter_fangxm/app/service/ScreenAdapter.dart';
import 'package:flutter_fangxm/app/service/keepAliveWraper.dart';
import 'package:flutter_fangxm/app/sources/FangXMIcon.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {

  final List<int> indexList = [1,2,3,4,5,6,7,8,9,10, 11,12,13,14,15,16,17,18,19,20];

  HomeView({super.key});

  // 添加导航栏
  Widget _topNavigationWidget() {
    final xMargin = Screenadapter.width(42);
    return Container(
      color: controller.xOffIsBig20.value ? Colors.white : Colors.transparent,
      padding: EdgeInsets.fromLTRB(0, Screenadapter.height(158), 0, 0),
      width: Screenadapter.width(1080),
      height: Screenadapter.height(288),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 小米图标
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: controller.xOffIsBig20.value ? 0 : Screenadapter.width(130),
            padding: EdgeInsets.fromLTRB(xMargin, 0, 0, 0), 
            child: Icon(FangXMIcon.xiaomiIcon, color: Colors.white)
          ),
          // 中间搜索的视图
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.fromLTRB(xMargin, 0, 0, 0), 
            height: Screenadapter.height(100),
            width: controller.xOffIsBig20.value ? Screenadapter.width(780) : Screenadapter.width(648),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(10, 0, 0, 0)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0), child: Icon(Icons.search, color: Colors.black26)),
                Expanded(child: Text("耳机", style: TextStyle(color: Colors.black45, fontSize: Screenadapter.fontSize(36)))),
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0), child: Icon(FangXMIcon.saomiao, color: Colors.black26)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(xMargin, 0, 0, 0),
            width: Screenadapter.width(124),
            height: Screenadapter.height(100),
            child: InkWell(
              child: Icon(Icons.qr_code_outlined, color: controller.xOffIsBig20.value ? Colors.black54 : Colors.white),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(xMargin, 0, 0, 0),
            width: Screenadapter.width(124),
            height: Screenadapter.height(100),
            child: InkWell(
              child: Icon(FangXMIcon.xiaoxi, color: controller.xOffIsBig20.value ? Colors.black54 : Colors.white),
            ),
          )
        ],
      ),
    );
  }

  // 添加图片轮播图
  Widget _topImageWidget() {
    return SizedBox(
      width: double.infinity,
      height: Screenadapter.height(685),
      child: Image.network(
        "https://www.itying.com/images/focus/focus02.png",
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return KeepAliveWraper(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: Screenadapter.height(-164),
              left: 0,
              right: 0,
              bottom: 0,
              child: ListView.builder(
                controller: controller.scrollController,
                itemCount: 200,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _topImageWidget();
                  } else {
                    return ListTile(
                      leading: Icon(Icons.people),
                      title: Text("放小米的cell"),
                    );
                  }
                }
              )
            ),
            Positioned(
              top: 0, // Screenadapter.height(158),
              left: 0,
              right: 0,
              child: Obx((){
                return _topNavigationWidget();
              })
            )
          ],
        )
      )
    );
  }
}
