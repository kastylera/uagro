import 'package:get/get.dart';

import 'order_controller.dart';

class OrderBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut<OrderController>(() => OrderController());
}
