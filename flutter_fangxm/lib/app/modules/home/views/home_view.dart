import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fangxm/app/modules/home/models/category_model.dart';
import 'package:flutter_fangxm/app/modules/home/models/focus_model.dart';
import 'package:flutter_fangxm/app/modules/home/models/product_mdel.dart';
import 'package:flutter_fangxm/app/service/ScreenAdapter.dart';
import 'package:flutter_fangxm/app/service/keepAliveWraper.dart';
import 'package:flutter_fangxm/app/sources/FangXMIcon.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {

 const HomeView({super.key});

  // 添加导航栏
  Widget _topNavigationWidget() {
    final xMargin = Screenadapter.width(42);
    double topMargin = controller.getTopMargin();
    double height = Screenadapter.height(188 + topMargin);
    if (Screenadapter.stateBarHeight() > 20) {
      height = Screenadapter.height(188 + topMargin + 40);
    }
    return Container(
      color: controller.xOffIsBig20.value ? Colors.white : Colors.transparent,
      padding: EdgeInsets.fromLTRB(0, topMargin, 0, 0),
      width: Screenadapter.width(1080),
      height: height,
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
            var imageUrl = "https://miapp.itying.com/${focusItemModel.pic}";
            return Image.network(imageUrl.replaceAll("\\", "/"),fit: BoxFit.fill,);
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
      height: Screenadapter.height(480),
      child: Swiper(
          itemBuilder: (context, index){
            return GridView.builder(
              padding: EdgeInsets.fromLTRB(Screenadapter.width(30), 0, Screenadapter.width(30), 0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: Screenadapter.height(10),
                mainAxisSpacing:  Screenadapter.height(20),
                childAspectRatio: 1/1.1
              ),
              itemCount: 10,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
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

  // 添加广告视图
  Widget _adWidget() {
    var margin = Screenadapter.width(30);
    var margin20 = Screenadapter.width(20);
    return Container(
      padding: EdgeInsets.fromLTRB(margin, 0, margin, 0),
      height: Screenadapter.height(730),
      child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: NetworkImage(
                    // "https://cdn.cnbj1.fds.api.mi-img.com/mi-mall/2e389157059c44d9352b42e04407cbb7.jpg?w=2452&h=920"
                    "https://cdn.cnbj1.fds.api.mi-img.com/mi-mall/b75dfaeaed384e1c7110b4fc855d65bf.jpg?thumb=1&w=2452&h=920&f=webp&q=90"
                  )
                )
              ),
              height: Screenadapter.height(730)
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.fromLTRB(margin20, 0, margin20, margin20),
                height: Screenadapter.height(266),
                child: Row(
                  spacing: margin20,
                  children: controller.adRecommendPicList.map((imageUrl) {
                    return  Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(imageUrl)
                          )
                        ),
                        height: Screenadapter.height(246)
                      )
                    );
                  }).toList()
                ),
              ),
            )
          ],
        ),
    );
  }

  // 添加标题
  Widget _titleWidget(String title, String subTitle) {
    return SizedBox(
      height: Screenadapter.height(100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: Screenadapter.fontSize(48))),
          Text(subTitle, style: TextStyle(color: Colors.black54, fontSize: Screenadapter.fontSize(38))),
        ],
      )
    );
  }

  // 添加热销甄选
  Widget _hotSellWidget() {
    var topMargin = Screenadapter.height(20);
    var xMargin = Screenadapter.width(20);
    var yMargin = Screenadapter.height(15);
    return Container(
      padding: EdgeInsets.fromLTRB(Screenadapter.width(30), topMargin, Screenadapter.width(30), yMargin),
      height: Screenadapter.height(890),
      child: Column(
        children: [
          _titleWidget("热销甄选", "更多手机推荐 >"),
          Row(
            spacing: xMargin,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: Screenadapter.height(740),
                  child: Obx(()=> Swiper(
                    itemBuilder: (context, index){
                      var focusItemModel =  controller.hotSellSwiperList[index] as FocusItemModel;
                      var imageUrl = "https://miapp.itying.com/${focusItemModel.pic}";
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(imageUrl.replaceAll("\\", "/"), fit: BoxFit.cover),
                      );
                    },
                    itemCount: controller.hotSellSwiperList.length,
                    pagination: const SwiperPagination(
                      // 修改分页指示器的配置
                      builder: RectSwiperPaginationBuilder(
                        activeColor: Colors.white,
                        color: Colors.black12
                      )
                    ),
                    autoplay: true,
                    loop: true,
                  ))
                )
              ),
              Expanded(
                flex: 1,
                child: Obx(() => Column(
                  spacing: yMargin,
                  children: controller.hotSellRecommendList.map((value){
                    var itemModel = value as ProductItemMdel;
                    var imageUrl = "https://miapp.itying.com/${itemModel.pic}";

                    return Container(
                      height: Screenadapter.height(236),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 240, 240, 240),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                    Screenadapter.width(30), 
                                    Screenadapter.height(40), 
                                    0, 
                                    0
                                  ),
                                  child: Text("${itemModel.title}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: Screenadapter.fontSize(34))),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                    Screenadapter.width(30),
                                    yMargin, 
                                    0, 
                                    0
                                  ),
                                  child: Text("${itemModel.subTitle}", style: TextStyle(color: Colors.black54, fontSize: Screenadapter.fontSize(30))),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                    Screenadapter.width(30), 
                                    yMargin, 
                                    0, 
                                    0
                                  ),
                                  child: Text("到手价¥${itemModel.price}起", style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w300, 
                                    fontSize: Screenadapter.fontSize(30)
                                  )),
                                ),
                              ],

                            )
                          ),
                          Expanded(
                            flex: 2,
                            child: Image.network(
                              imageUrl.replaceAll("\\", "/"),
                              fit: BoxFit.cover,
                            )
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ))
              )
            ],
          )
        ],
      ),
    );
  }


  // 添加商品列表
  Widget _goodsListWidget() {
    return Obx(() => Container(
      padding: EdgeInsets.fromLTRB(
        Screenadapter.width(30), 
        Screenadapter.height(20),
        Screenadapter.width(30),
        Screenadapter.height(20)
      ),
      child: Column(
        children: [
          _titleWidget("精选推荐", ""),
          MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: Screenadapter.width(20),
            crossAxisSpacing: Screenadapter.width(20),
            itemCount: controller.goodsList.length,
            // 自适应宽度
            shrinkWrap: true,
            // 禁止内部滚动
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var itemModel = controller.goodsList[index] as ProductItemMdel;
              var imageUrl = "https://miapp.itying.com/${itemModel.pic}";
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)
                        ),
                      child: Image.network(
                        imageUrl.replaceAll("\\", "/"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                        top: Screenadapter.height(30),
                        left: Screenadapter.width(20),
                      ),
                      child: Text(
                        "${itemModel.title}", 
                        textAlign: TextAlign.start, 
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: Screenadapter.fontSize(38))
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                        top: Screenadapter.height(20),
                        left: Screenadapter.width(20),
                      ),
                      child: Text(
                        "${itemModel.title}",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black38, fontSize: Screenadapter.fontSize(32))
                      ),
                    ),

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                        top: Screenadapter.height(40),
                        left: Screenadapter.width(20),
                        bottom: Screenadapter.height(50),
                      ),
                      child: Text(
                        "￥${itemModel.price}元起",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: Screenadapter.fontSize(36))
                      ),
                    ),
                  ],
                ),
              );
            }
          )
        ],
      ),
      
    ));
  }

  @override
  Widget build(BuildContext context) {

    return KeepAliveWraper(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: -controller.getTopMargin(),
              left: 0,
              right: 0,
              bottom: 0,
              child: ListView(
                controller: controller.scrollController,
                children: [
                  _topImageWidget(),
                  _bannerWidget(),
                  _categoryWidget(),
                  _adWidget(),
                  _hotSellWidget(),
                  _goodsListWidget()
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
