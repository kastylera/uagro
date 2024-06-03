import 'package:get/get.dart';

import 'order_controller.dart';

class OrderBinding implements Bindings {
  @override
  void dependencies() => Get.create<OrderController>(() => OrderController());
}
