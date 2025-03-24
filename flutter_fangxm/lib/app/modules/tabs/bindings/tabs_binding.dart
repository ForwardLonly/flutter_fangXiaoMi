import 'package:flutter_fangxm/app/modules/cart/controllers/cart_controller.dart';
import 'package:flutter_fangxm/app/modules/category/controllers/category_controller.dart';
import 'package:flutter_fangxm/app/modules/give/controllers/give_controller.dart';
import 'package:flutter_fangxm/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_fangxm/app/modules/user/controllers/user_controller.dart';
import 'package:get/get.dart';

import '../controllers/tabs_controller.dart';

class TabsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabsController>(
      () => TabsController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController()
    );
    Get.lazyPut<CartController>(
      () => CartController()
    );
    Get.lazyPut<GiveController>(
      () => GiveController()
    );
    Get.lazyPut<UserController>(
      () => UserController()
    );
    Get.lazyPut<CategoryController>(
      () => CategoryController()
    );
  }
}
