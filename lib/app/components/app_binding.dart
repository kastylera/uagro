import 'package:get/get.dart';

import 'app_controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut<AppController>(() => AppController());
}
