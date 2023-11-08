import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../load/load_screen.dart';
import '../../ui/local_notification/local_notification.dart';

abstract class FormController extends GetxController {
  // late final Api api;
  late final GlobalKey<FormState> formKey;
  final _errorText = Rx<String?>(null);
  final loading = Rx<bool>(false);
  final _responseInfoText = Rx<String?>(null);

  String? get errorText => _errorText.value;

  String? get responseInfoText => _responseInfoText.value;

  void updateResponseInfoText(String text) {
    _responseInfoText(text);
  }

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    // api = Get.find<Api>();
    super.onInit();
  }

  bool validate = true;

  void updateErrorText(String? errorText) => _errorText.value = errorText;

  Future<void> _load(Future<void> Function() func, {required BuildContext c}) async {
    updateErrorText(null);
    loading(true);
    try {
      await func();
      // }
      // on DioError catch (e) {
      //   late final String errorText;
      //   if (e.response?.data['error'] != null) {
      //     errorText = e.response!.data['error'];
      //   } else {
      //     errorText = e.message;
      //   }
      //   // updateErrorText(Api.getTranslateError(errorText, context: context));
    } catch (e) {
      // updateErrorText(e.toString());
      loading(false);

      // inAppNotification(text: 'An error occurred while uploading data', c: c);
    } finally {
      loading(false);
      // inAppNotification(text: 'An error occurred while uploading data', c: c);
    }
  }

  Future<void> load(Future<void> Function() func, {required BuildContext c}) async {
    await Get.showOverlay(asyncFunction: () async => await _load(func, c: c), loadingWidget: const Center(child: AppCircularProgressIndicator()));
  }

  Future<void> loadIfValid(Future<void> Function() func, {required BuildContext c}) async {
    try {
      await load(func, c: c);
    } catch (err) {
      inAppNotification(text: err.toString(), c: c);
    }
  }
}
