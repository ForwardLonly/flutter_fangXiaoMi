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
        preferredSize: Size.fromHeight(Screenadapter.height(96)),
        child: _appBarWidget()
      ),
      body: ListView(
        controller: controller.scrollController,
        children: [
          Container(
            color: Colors.red,
            width: double.infinity,
            height: Screenadapter.height(300),
          ),
          SizedBox(height: 140),
          Text("风萧萧兮易水寒，壮士一去兮不复还。风萧萧兮易水寒，壮士一去兮不复还。风萧萧兮易水寒，壮士一去兮不复还。"),
          SizedBox(height: 140),
          Text("风萧萧兮易水寒，壮士一去兮不复还。风萧萧兮易水寒，壮士一去兮不复还。风萧萧兮易水寒，壮士一去兮不复还。"),
          SizedBox(height: 140),
          Text("风萧萧兮易水寒，壮士一去兮不复还。风萧萧兮易水寒，壮士一去兮不复还。风萧萧兮易水寒，壮士一去兮不复还。"),
          SizedBox(height: 140),
          Text("风萧萧兮易水寒，壮士一去兮不复还。风萧萧兮易水寒，壮士一去兮不复还。风萧萧兮易水寒，壮士一去兮不复还。"),
          SizedBox(height: 140),
          Text("风萧萧兮易水寒，壮士一去兮不复还。风萧萧兮易水寒，壮士一去兮不复还。风萧萧兮易水寒，壮士一去兮不复还。"),
          SizedBox(height: 140),
          Text("风萧萧兮易水寒，壮士一去兮不复还。风萧萧兮易水寒，壮士一去兮不复还。风萧萧兮易水寒，壮士一去兮不复还。"),
          SizedBox(height: 140),
          Text("风萧萧兮易水寒，壮士一去兮不复还。风萧萧兮易水寒，壮士一去兮不复还。风萧萧兮易水寒，壮士一去兮不复还。"),
          SizedBox(height: 140),
          Text("风萧萧兮易水寒，壮士一去兮不复还。风萧萧兮易水寒，壮士一去兮不复还。风萧萧兮易水寒，壮士一去兮不复还。"),
          SizedBox(height: 140),

        ],
      ),
    );
  }

  // 自定义导航栏
  Widget _appBarWidget() {
    return Obx(()=> AppBar(
      leading: Container(
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
      ),
      title: Container(
        width: Screenadapter.width(400),
        height: Screenadapter.height(110),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("商品", style: TextStyle(fontSize: Screenadapter.fontSize(36))),
                  Container(
                    margin: EdgeInsets.only(top: Screenadapter.height(10)),
                    color: Colors.red,
                    width: Screenadapter.width(100),
                    height: Screenadapter.height(2),
                  )
                ]
              )
            ),
            Padding(
              padding: EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("详情", style: TextStyle(fontSize: Screenadapter.fontSize(36))),
                  Container(
                    margin: EdgeInsets.only(top: Screenadapter.height(10)),
                    color: Colors.red,
                    width: Screenadapter.width(100),
                    height: Screenadapter.height(2),
                  )
                ]
              )
            ),
            Padding(
              padding: EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("推荐", style: TextStyle(fontSize: Screenadapter.fontSize(36))),
                  Container(
                    margin: EdgeInsets.only(top: Screenadapter.height(10)),
                    color: Colors.red,
                    width: Screenadapter.width(100),
                    height: Screenadapter.height(2),
                  )
                ]
              )
            ),
          ],
        ),
      ),
      centerTitle: true,
      // 实现透明导航 第二步
      backgroundColor: Colors.white.withAlpha(controller.opacity.value),
      // 实现透明导航 第三步
      elevation: 0,
      actions: [
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
      ],
    ));
  }

}
