import 'package:flutter/material.dart';
import 'package:flutter_fangxm/app/service/ScreenAdapter.dart';
import 'package:flutter_fangxm/app/sources/FangXMIcon.dart';

import 'package:get/get.dart';

import '../controllers/give_controller.dart';

class GiveView extends GetView<GiveController> {
  const GiveView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        title: Container(
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
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0), child: Icon(FangXMIcon.saomiao, color: Colors.black26)),
              ],
            ),
          ),
        centerTitle: true,
        actions: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            width: Screenadapter.width(124),
            height: Screenadapter.height(100),
            child: InkWell(
              child: Icon(FangXMIcon.xiaoxi, color: Colors.black54 ),
            ),
          )
        ],
      ),
      body: const Center(
        child: Text(
          'GiveView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
