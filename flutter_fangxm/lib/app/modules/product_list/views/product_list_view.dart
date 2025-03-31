import 'package:flutter/material.dart';
import 'package:flutter_fangxm/app/service/ScreenAdapter.dart';

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
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(
        Screenadapter.width(24),
        Screenadapter.width(124), 
        Screenadapter.width(24), 
        Screenadapter.width(24)),
      itemCount: 30,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: Screenadapter.width(24)),
          height: Screenadapter.width(532),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 图片
              Container(
                width: Screenadapter.width(360),
                padding: EdgeInsets.fromLTRB(Screenadapter.width(20), Screenadapter.height(20), Screenadapter.width(20), 0),
                child: Image.network(
                  "https://cdn.cnbj0.fds.api.mi-img.com/b2c-shopapi-pms/pms_1735279484.83039321.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              // 手机信息
              Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: Screenadapter.height(40),
                      right: Screenadapter.width(50),
                    ),
                    child: Text(
                      "Redmi 10A",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Screenadapter.fontSize(42)
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: Screenadapter.height(10),
                      right: Screenadapter.width(50),
                    ),
                    child: Text(
                      "6.53 大尺寸屏幕11300万超清主摄1 Helio G25八核处理器15000mAh充电宝级大...",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: Screenadapter.fontSize(32),
                        color: Colors.black38
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Padding(
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: Screenadapter.height(20),
                      right: Screenadapter.width(50),
                    ),
                    child: Text(
                      "￥699起",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: Screenadapter.fontSize(42),
                        color: Colors.black
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Padding(
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: Screenadapter.height(10),
                      right: Screenadapter.width(50),
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
                  ),
                ],
              ))
            ],
          ),
        );

      },
    );
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _topSelectionItemWidget("综合"),
            _topSelectionItemWidget("销量"),
            _topSelectionItemWidget("价格"),
            _topSelectionItemWidget("新品优先"),
            _topSelectionItemWidget("筛选"),
          ],
        ),
      ));
  }


  //----------小部件-----------
  // 综合 销量 价格 新品优先 筛选
  Widget _topSelectionItemWidget(String title) {
    return Expanded(child: Text(
      title,
      style: TextStyle(
        fontSize: Screenadapter.fontSize(38),
        color: Colors.black45
      ),
      textAlign: TextAlign.center,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
