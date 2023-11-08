import 'package:get/get.dart';

import 'auth_confirmation_controller.dart';

class AuthConfirmationBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut<AuthConfirmationController>(() => AuthConfirmationController());
}
