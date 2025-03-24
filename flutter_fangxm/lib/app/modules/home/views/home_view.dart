import 'package:flutter/material.dart';
import 'package:flutter_fangxm/app/service/ScreenAdapter.dart';
import 'package:flutter_fangxm/app/service/keepAliveWraper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {

  final List<int> indexList = [1,2,3,4,5,6,7,8,9,10, 11,12,13,14,15,16,17,18,19,20];

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {

    print(Screenadapter.screenWidth());
    print(Screenadapter.screenHeight());

    return KeepAliveWraper(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('HomeView'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              width: Screenadapter.width(1080),
              height: Screenadapter.height(600),
              color: Colors.red,
            )
          ],
        ),
      )
    );
  }
}
