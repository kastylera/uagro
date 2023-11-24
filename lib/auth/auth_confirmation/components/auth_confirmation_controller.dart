import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:agro/model/model_user/struct_auth.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controllers/abstract/from_controller.dart';
import '../../../controllers/app_input_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../server/api/api.dart';

class AuthConfirmationController extends FormController {
  late Function(VoidCallback fn) setState;
  late BuildContext c;
  late TextEditingController codeController;

  String? errorCode;

  @override
  void onInit() {
    codeController = AppInputController();

    super.onInit();
  }

  void initPage({required BuildContext context, required Function(VoidCallback fn) set}) async {
    c = context;
    setState = set;
  }

  void updScreenError(_) => setState(() => errorCode = null);

  void onContactTelegram() => launchUrl(Uri.parse('https://t.me/uagro_admin'));

  void onContactViber() => launchUrl(Uri.parse('viber://chat?number=${Uri.encodeComponent('+380990026222')}'));

  void onAuth() => Get.offAllNamed(Routes.auth);

  void onLogin() => loadIfValid(() async {
        ApiAnswer apiAnswer = await Api().auth.loginCode(code: codeController.text);

        log(apiAnswer.data.toString());

        if (apiAnswer.data['status']) {
          structUserData(data: apiAnswer.data['payload']['user'], token: apiAnswer.data['payload']['key'], login: true);
        } else {
          setState(() => errorCode = apiAnswer.data['message']);
        }
      }, c: c);
}
