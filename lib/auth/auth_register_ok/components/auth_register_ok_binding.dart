import 'package:get/get.dart';

import 'auth_register_ok_controller.dart';

class AuthRegisterOkBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut<AuthRegisterOkController>(() => AuthRegisterOkController());
}
