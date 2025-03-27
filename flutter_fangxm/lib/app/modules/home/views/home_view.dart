import 'package:flutter/material.dart';
import 'package:flutter_fangxm/app/modules/home/models/category_model.dart';
import 'package:flutter_fangxm/app/modules/home/models/focus_model.dart';
import 'package:flutter_fangxm/app/service/ScreenAdapter.dart';
import 'package:flutter_fangxm/app/service/keepAliveWraper.dart';
import 'package:flutter_fangxm/app/sources/FangXMIcon.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

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
    return Obx((){
      if (controller.adList.isEmpty) {
        return SizedBox(
          width: double.infinity,
          height: Screenadapter.height(685),
          child: Center(child: Text("加载中..."))
        );
      } else {
        return SizedBox(
        width: double.infinity,
        height: Screenadapter.height(685),
        child:  Swiper(
          itemBuilder: (context, index){
            var focusItemModel =  controller.adList[index] as FocusItemModel;
            var imageUrl = focusItemModel.pic  as String;
            imageUrl = imageUrl.replaceAll("\\", "/");
            imageUrl = "https://miapp.itying.com/$imageUrl";
            return Image.network(imageUrl,fit: BoxFit.fill,);
          },
          itemCount: controller.adList.length,
          pagination: const SwiperPagination(
            // 修改分页指示器的配置
            builder: RectSwiperPaginationBuilder(
              activeColor: Colors.white,
              color: Colors.black12
            )
          ),
          autoplay: true,
          loop: true,
        ),
      );
      }
    });
  }

  // 添加标签图
  Widget _bannerWidget() {
    return Container(
      color: Colors.white,
      width: Screenadapter.width(1480),
      height: Screenadapter.height(100),
      child: Image.asset("assets/images/xiaomiBanner.png"),
    );
  }

  // 添加分类视图
  Widget _categoryWidget() {
    return Obx(() => Container(
      color: Colors.white,
      width: double.infinity,
      height: Screenadapter.height(460),
      child: Swiper(
          itemBuilder: (context, index){
            return GridView.builder(
              padding: EdgeInsets.fromLTRB(Screenadapter.width(30), 0, Screenadapter.width(30), 0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: Screenadapter.height(10),
                mainAxisSpacing:  Screenadapter.height(20),
              ),
              itemCount: 10,
              itemBuilder: (context, i) {
                var itemModel = controller.categoryList[index * 10 + i] as CategoryItemModel;
                var imageUrl = itemModel.pic!.replaceAll("\\", "/");
                imageUrl = "https://miapp.itying.com/$imageUrl";
                return InkWell(
                  onTap: (){},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: Screenadapter.height(140),
                        height: Screenadapter.height(140),
                        child: Image.network(imageUrl, fit: BoxFit.fitHeight),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, Screenadapter.height(10), 0, 0),
                        child: Text("${itemModel.title}", style: TextStyle(fontSize:Screenadapter.fontSize(34)),),
                      )
                    ],
                  )
                );
              });
          },
          itemCount: (controller.categoryList.length  / 10).toInt(),
          pagination: SwiperPagination(
            // 修改轮播图指示器距离底部的位置
            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
             // 修改分页指示器的配置
            builder: RectSwiperPaginationBuilder(
              activeColor: Colors.black38,
              color: Colors.black12,
              size: Size(Screenadapter.width(66), Screenadapter.height(6)),
              activeSize: Size(Screenadapter.width(66), Screenadapter.height(6)),
            )
          ),
        )
    ));
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
              child: ListView(
                controller: controller.scrollController,
                children: [
                  _topImageWidget(),
                  _bannerWidget(),
                  _categoryWidget()
                ],
              )
            ),
            Positioned(
              top: 0, 
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
