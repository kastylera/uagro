import 'package:agro/load/load_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  final _errorText = Rx<String?>(null);
  final loading = Rx<bool>(false);
  final _responseInfoText = Rx<String?>(null);

  String? get errorText => _errorText.value;

  String? get responseInfoText => _responseInfoText.value;

  void updateResponseInfoText(String text) {
    _responseInfoText(text);
  }

  void updateErrorText(String? errorText) => _errorText.value = errorText;

  Future<void> _load(Future<void> Function() func) async {
    updateErrorText(null);
    loading(true);
    try {
      await func();
    } catch (e) {
      updateErrorText(e.toString());
      loading(false);
    } finally {
      loading(false);
    }
  }

  Future<void> load(Future<void> Function() func) async {
    await Get.showOverlay(
        asyncFunction: () async => await _load(func),
        loadingWidget: const Center(child: AppCircularProgressIndicator()));
  }

  Future<void> loadIfValid(Future<void> Function() func) async {
    try {
      await load(func);
    } catch (err) {
      updateErrorText(err.toString());
    }
  }
}
