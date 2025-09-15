import 'package:flutter/material.dart';
import 'package:flutter_fangxm/app/modules/home/models/category_model.dart';
import 'package:flutter_fangxm/app/routes/app_pages.dart';
import 'package:flutter_fangxm/app/service/ScreenAdapter.dart';
import 'package:flutter_fangxm/app/service/https_client.dart';
import 'package:flutter_fangxm/app/sources/FangXMIcon.dart';

import 'package:get/get.dart';

import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({super.key});

  // 导航栏的title
  Widget _appBarTitleWidget() {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.SEARCHES);
      },
      child:  Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0), 
        height: Screenadapter.height(100),
        width:  Screenadapter.width(880) ,
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
      )
    );
  }

  // 导航栏的右侧操作栏
  List<Widget> _appBarActions() {
    return [
      Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        width: Screenadapter.width(124),
        height: Screenadapter.height(100),
        child: InkWell(
          child: Icon(FangXMIcon.xiaoxi, color: Colors.black54 ),
        ),
      )
    ];
  }

  // 分类左侧视图
  Widget _leftCategoryWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.transparent,
      width: Screenadapter.width(280),
      height: double.infinity,
      child: Obx(() => ListView.builder(
        itemCount: controller.leftCategoryList.length,
        itemBuilder: (context, index) {
          final categoryItemModel =  controller.leftCategoryList[index] as CategoryItemModel;
          return InkWell(
            onTap: (){
              controller.updateLeftIndexAction(index);
            },
            child: SizedBox(
              height: Screenadapter.height(150),
              child: Obx(() => Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      color: controller.leftSelectIndex.value == index ? Colors.red : Colors.white,
                      width: Screenadapter.width(10),
                      height: Screenadapter.height(50),
                    ),
                  ),
                  Text(
                    "${categoryItemModel.title}", 
                    style: TextStyle(
                      color: controller.leftSelectIndex.value == index ? Colors.black : Colors.black54, 
                      fontWeight: controller.leftSelectIndex.value == index ? FontWeight.w800 : FontWeight.normal,
                      fontSize: Screenadapter.fontSize(32)))
                ],
              )),
            ),
          );
        },
      )),
    );
  }

  // 分类右侧视图
  Widget _rightCategoryWidget() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        color: Colors.transparent,
        width: double.infinity,
        height: double.infinity,
        child: Obx(() => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: Screenadapter.width(20),
            crossAxisSpacing: Screenadapter.width(20),
            childAspectRatio: 216 / 330
          ), 
          itemCount: controller.rightCategoryList.length,
          itemBuilder: (context, index) {
            final itemModel = controller.rightCategoryList[index] as CategoryItemModel;
            return  InkWell(
              onTap: (){
                Get.toNamed(Routes.PRODUCT_LIST, arguments: {
                  "pid": itemModel.sId,
                  "searchKeywords": itemModel.title                 
                });
              },
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1/1,
                    child: Image.network(
                      HttpsClient.replacePic("${itemModel.pic}"),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, Screenadapter.height(28), 0, 0),
                    child: Text("${itemModel.title}", style: TextStyle(color: Colors.black87, fontSize: Screenadapter.fontSize(32))),
                  )
                ],
              ),
            );
          }))
        ,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        title: _appBarTitleWidget(),
        centerTitle: true,
        actions: _appBarActions(),
      ),
      body: Row(
          children: [
            _leftCategoryWidget(),
            _rightCategoryWidget()
          ],
        ),
    );
  }
}
