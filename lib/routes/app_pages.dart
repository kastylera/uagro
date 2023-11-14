import 'package:agro/app/home/review/review_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:agro/auth/auth_register_ok/auth_register_ok_screen.dart';
import 'package:agro/auth/auth_register_ok/components/auth_register_ok_binding.dart';
import 'package:agro/auth/components/auth_binding.dart';

import '../app/app_screen.dart';
import '../app/components/app_binding.dart';
import '../app/home/order/components/order_binding.dart';
import '../app/home/order/order_screen.dart';
import '../app/home/review/components/review_binding.dart';
import '../auth/auth_confirmation/auth_confirmation_screen.dart';
import '../auth/auth_confirmation/components/auth_confirmation_binding.dart';
import '../auth/auth_screen.dart';

part './app_routes.dart';

abstract class AppPages {
  static pages({required BuildContext context}) => [
        GetPage(name: Routes.auth, page: () => const AuthScreen(), binding: AuthBinding()),
        GetPage(name: Routes.authConfirm, page: () => const AuthConfirmScreen(), binding: AuthConfirmationBinding()),
        GetPage(name: Routes.app, page: () => const AppScreen(), binding: AppBinding()),
        GetPage(name: Routes.authRegisterOk, page: () => const AuthRegisterOkScreen(), binding: AuthRegisterOkBinding()),
        GetPage(name: Routes.orderInfo, page: () => const OrderScreen(), binding: OrderBinding()),
        GetPage(name: Routes.review, page: () => const ReviewScreen(), binding: ReviewBinding()),
      ];
}
