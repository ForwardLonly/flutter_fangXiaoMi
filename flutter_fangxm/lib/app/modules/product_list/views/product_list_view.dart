import 'package:flutter/material.dart';
import 'package:flutter_fangxm/app/service/ScreenAdapter.dart';
import 'package:flutter_fangxm/app/service/https_client.dart';

import 'package:get/get.dart';

import '../controllers/product_list_controller.dart';

class ProductListView extends GetView<ProductListController> {
  const ProductListView({super.key});


  // 导航栏的title
  Widget _appBarTitleWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0,  Screenadapter.width(40),0), 
      height: Screenadapter.height(100),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(10, 0, 0, 0)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0), child: Icon(Icons.search, color: Colors.black26)),
          Expanded(child: Text("耳机", style: TextStyle(color: Colors.black45, fontSize: Screenadapter.fontSize(36)))),
        ],
      ),
    );
  }

  // 商品列表
  Widget _productListWidget() {
    return Obx( () {
      if (controller.productList.isNotEmpty) {
        return ListView.builder(
          controller: controller.scrollController,
          padding: EdgeInsets.fromLTRB(
            Screenadapter.width(24),
            Screenadapter.width(124), 
            Screenadapter.width(24), 
            Screenadapter.width(24)),
          itemCount: controller.productList.length,
          itemBuilder: (context, index) {
            var itemModel = controller.productList[index];
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: Screenadapter.width(24)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 图片
                      _listImageWidget(HttpsClient.replacePic("${itemModel.pic}")),
                      // 手机信息
                      Expanded(child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 商品名称,
                          _listProductNameWidget("${itemModel.title}"),
                          // 商品描述
                          _listProductDescritionWidget("${itemModel.subTitle}"),
                          // 商品性能
                          _listProductInterInfoWiget(),
                          // 商品价格,
                          _listProductPrice("${itemModel.price}"),
                          // 商品标签
                          _listProdctTag(),
                          // 商品评论
                          _listProductCommendWidget()
                        ],
                      ))
                    ],
                  ),
                ),
                (index == controller.productList.length - 1) ? _loadingWidget() : SizedBox(height: 1),
              ],
            );

          },
        );
      } else {
        return _loadingWidget();
      }
    });
  }

  // 顶部筛选框
  Widget _topSelectionWiget() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white,
        height: Screenadapter.height(120),
        width: double.infinity,
        child: Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _topSelectionItemWidget("综合", 1),
            _topSelectionItemWidget("销量", 2),
            _topSelectionItemWidget("价格", 3),
            _topSelectionItemWidget("筛选", 4),
          ],
        )),
      ));
  }


  //----------小部件-----------
  // 列表中图片
  Widget _listImageWidget(String imageUrl) {
    return Container(
      width: Screenadapter.width(360),
      padding: EdgeInsets.fromLTRB(Screenadapter.width(20), Screenadapter.height(20), Screenadapter.width(20), 0),
      child: Image.network(
        imageUrl,
        fit: BoxFit.fitWidth,
      ),
    );
  }
  // 列表，手机型号
  Widget _listProductNameWidget(String title) {
    return Padding(
      padding: EdgeInsets.only(
        top: Screenadapter.height(40),
        right: Screenadapter.width(50),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: Screenadapter.fontSize(42)
        ),
      ),
    );
  }
  // 列表，商品描述
  Widget _listProductDescritionWidget(String description) {
    if (description.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.only(
          top: Screenadapter.height(10),
          right: Screenadapter.width(50),
        ),
        child: Text(
          description,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: Screenadapter.fontSize(32),
            color: Colors.black38
          ),
          maxLines: 2,
        ),
      );
    } else {
      return SizedBox(height: 1);
    }
    
  }
  // 列表，商品性能
  Widget _listProductInterInfoWiget() {
    return Padding(
      padding: EdgeInsets.only(
        top: Screenadapter.height(10),
        right: Screenadapter.width(0),
      ),
      child: Row(
        children: [
          Expanded(child: Column(
            children: [
              Text(
                "CPU",
                style: TextStyle(
                  fontSize: Screenadapter.fontSize(32),
                  color: Colors.black45
                ),
              ),
              Text(
                "Helio G25",
                style: TextStyle(
                  fontSize: Screenadapter.fontSize(28),
                  color: Colors.black45
                ),
              ),
            ],
          )),
          Container(
            width: 1,
            height: Screenadapter.height(40),
            color: Colors.black12,
          ),
          Expanded(child: Column(
            children: [
              Text(
                "高清拍摄",
                style: TextStyle(
                  fontSize: Screenadapter.fontSize(32),
                  color: Colors.black45
                ),
              ),
              Text(
                "1300万 像素",
                style: TextStyle(
                  fontSize: Screenadapter.fontSize(28),
                  color: Colors.black45
                ),
              ),
            ],
          )),
          Container(
            width: 1,
            height: Screenadapter.height(40),
            color: Colors.black12,
          ),
          Expanded(child: Column(
            children: [
              Text(
                "超大屏",
                style: TextStyle(
                  fontSize: Screenadapter.fontSize(32),
                  color: Colors.black45
                ),
              ),
              Text(
                "6.3英寸",
                style: TextStyle(
                  fontSize: Screenadapter.fontSize(28),
                  color: Colors.black45
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
  // 列表，商品价格
  Widget _listProductPrice(String price) {
    return Padding(
      padding: EdgeInsets.only(
        top: Screenadapter.height(20),
        right: Screenadapter.width(50),
      ),
      child: Text(
        "￥$price起",
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: Screenadapter.fontSize(42),
          color: Colors.black
        ),
        maxLines: 2,
      ),
    );
  }
  // 列表商品标签
  Widget _listProdctTag() {
    return Padding(
      padding: EdgeInsets.only(
        top: Screenadapter.height(10),
        right: Screenadapter.width(50),
      ),
      child: Container(
        height: Screenadapter.height(38),
        width: Screenadapter.width(88),
        decoration: BoxDecoration(
          color: Colors.blue[300],
          borderRadius: BorderRadius.circular(2)
        ),
        child: Center(child: Text(
          "分期",
          style: TextStyle(
            fontSize: Screenadapter.fontSize(28),
            color: Colors.white
          ),
        )),
      ),
    );
  }
  // 列表，商品评论
  Widget _listProductCommendWidget() {
    return Padding(
      padding: EdgeInsets.only(
        top: Screenadapter.height(10),
        right: Screenadapter.width(50),
        bottom: Screenadapter.height(50),
      ),
      child: Row(
        children: [
          Text(
            "319247条评论",
            style: TextStyle(
              fontSize: Screenadapter.fontSize(24),
              color: Colors.black45
            ),
          ),
          SizedBox(width: Screenadapter.width(24)),
          Text(
            "99.99%满意",
            style: TextStyle(
              fontSize: Screenadapter.fontSize(24),
              color: Colors.black45
            ),
          ),
        ],
      )
    );
  }



  // 综合 销量 价格 新品优先 筛选
  Widget _topSelectionItemWidget(String title, int index) {
    return Expanded(child: InkWell(
      onTap: (){
        controller.updateSelectIndex(index);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: (controller.selectIndex.value == index) ? FontWeight.bold : FontWeight.normal,
              fontSize: Screenadapter.fontSize(38),
              color: (controller.selectIndex.value == index) ? Colors.red : Colors.black45
            ),
            textAlign: TextAlign.center,
          ),
          _topSelectionItemArrowWidget(index)
        ],
      ),
    ));
  }

  // 筛选的箭头
  Widget _topSelectionItemArrowWidget(int index) {
    // controller.selectIndexArrow.value 这个值必须调用，不然不会刷新箭头
    if ((index == 2 || index == 3) && (controller.selectIndexArrow.value == 1 || controller.selectIndexArrow.value == -1) ) {
      bool isSelect = controller.selectIndex.value == index;
      bool arrowDown = controller.subHeaderList[index-1]["sort"] == 1;
      return Icon(
        arrowDown ? Icons.arrow_drop_down : Icons.arrow_drop_up,
        color: isSelect ? Colors.red : Colors.black45,
      );
    } else {
      return SizedBox(width: 1);
    }
  }

  // loading视图
  Widget _loadingWidget() {
    if (controller.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      ); 
    } else {
      if (controller.hasMoreDate) {
        return Center(
          child: CircularProgressIndicator(),
        ); 
      } else {
        return Center(
          child: Text("-----我是有底线的-----"),
        );
      }
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.stateGolbalKey,
      endDrawer:  Drawer(
        child: DrawerHeader(
          child: Text("右侧筛选"),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
         child: Container(
          padding: EdgeInsets.fromLTRB(0, Screenadapter.stateBarHeight(), 0, 0),
          child: Row(
            children: [
              // 返回按钮
              IconButton(
                icon: Icon(Icons.arrow_back_ios_new, color: Colors.black87),
                onPressed: () {
                  // 处理点击事件
                  Get.back();
                },
              ),
              // 搜索视图
              Expanded(
                child: _appBarTitleWidget(),
              ),
            ],
          ),
        )
      ),
      body: Stack(
        children: [
          _productListWidget(),
          _topSelectionWiget(),
        ],
      ),
    );
  }
}
