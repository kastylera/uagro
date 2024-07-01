import 'dart:developer';

import 'package:agro/controllers/abstract/base_controller.dart';
import 'package:agro/model/model_user/model_user.dart';
import 'package:agro/model/tariff/tariff.dart';
import 'package:agro/server/api/api.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';

class TariffsController extends BaseController {
  late Function(VoidCallback fn) setState;
  Tariff? tariff;
  ModelUser? modelUser;

  void initPage(
      {required BuildContext context,
      required Function(VoidCallback fn) set}) async {
    setState = set;
    modelUser = Hive.box('data').get('modelUser');

    await Future.delayed(const Duration(milliseconds: 100));
    onTariffInfo();
  }

  void onTariffInfo() async {
    try {
      ApiAnswer apiAnswer = await Api().traider.getTariff();
      tariff = Tariff.fromJson(apiAnswer.data['payload']);
    } catch (e) {
      log(e.toString(), error: e);
    }
  }

  void onBuyTariff(String tariff) {
    openTelegram(text: tariff);
  }

  Future<void> openTelegram({
    required String text,
    LaunchMode mode = LaunchMode.externalApplication,
  }) async {
    String url = 'https://t.me/uagro_admin?text=Доброго дня. Хочу придбати пакет "$text" ';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
      );
    } else {
      throw Exception(
          'openTelegram could not launching url: $url');
    }
  }

  void onBack(BuildContext context) => Navigator.pop(context);
}
