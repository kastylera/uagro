import 'package:agro/controllers/abstract/base_controller.dart';
import 'package:agro/model/model_user/model_user.dart';
import 'package:agro/repository/local_storage_repository.dart';
import 'package:agro/routes/app_pages.dart';
import 'package:agro/vars/model_notifier/user_notifier/user_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../main.dart';
import '../../../ui/local_notification/local_notification.dart';
import '../../../ui/text/read_text.dart';
import '../../../vars/model_notifier/bottom_menu_notifier/bottom_menu_notifier.dart';
import '../../home/components/home_controller.dart';

class ProfileController extends BaseController {
  late Function(VoidCallback fn) setState;
  final modelUser = Rx<ModelUser>(ModelUser());
  final user = ModelUser();
  @override
  void onInit() {
    modelUser.value = Hive.box('data').get('modelUser');
    super.onInit();
  }

  void onSite() => launchUrl(Uri.parse('https://uagro.trade/'));

  void onHelp() => launchUrl(Uri.parse('https://t.me/uagro_admin'));

  void onPrivacy() => launchUrl(Uri.parse(
      'https://www.freeprivacypolicy.com/live/3afe785c-8de8-4a5b-985b-353bfca6bd17'));

  void onTariffs() => Get.toNamed(Routes.tariffs);

  void onDeleteAccount(BuildContext context) => showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext c) => Theme(
          data: ThemeData.light(),
          child: CupertinoAlertDialog(
              title: Center(
                  child: readText(
                      text: 'Видалити профіль?',
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      size: 20)),
              content: Center(
                  child: readText(
                      text: 'Всі ваші дані будуть видалені',
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      size: 18,
                      align: TextAlign.center)),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () async {
                      await Hive.box('data').clear();
                      startActive = false;

                      if (c.mounted) {
                        c.read<UserNotifier>().setModelUser(val: ModelUser());
                        c
                            .read<BottomMenuNotifier>()
                            .setActiveButtMenu(val: 0, upd: false);
                        inAppNotification(
                            text:
                                'Ваш профіль буде видалено через 90 днів, щоб скасувати дію, зайдіть в свій аккаунт',
                            c: c);
                        Get.delete<HomeController>();
                        Get.deleteAll();

                        Navigator.pushAndRemoveUntil<dynamic>(
                            c,
                            MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) =>
                                    const Material(child: MyStart())),
                            (route) => false);
                      }
                    },
                    child: readText(
                        text: 'Так',
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        size: 20)),
                CupertinoDialogAction(
                    isDestructiveAction: true,
                    onPressed: () => Navigator.pop(c),
                    child: readText(
                        text: 'Скасувати',
                        color: const Color(0xffFF1616),
                        fontWeight: FontWeight.w500,
                        size: 20))
              ])));

  void onExit(BuildContext context) => showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext c) => Theme(
          data: ThemeData.light(),
          child: CupertinoAlertDialog(
              title: Center(
                  child: readText(
                      text: 'Вийти з профілю?',
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      size: 20)),
              content: Center(
                  child: readText(
                      text: 'Всі ваші дані на даному девайсі буде видалено',
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      size: 18,
                      align: TextAlign.center)),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () async {
                      await Hive.box('data').clear();
                      await LocalStorageRepository().clear();
                      startActive = false;

                      if (c.mounted) {
                        c.read<UserNotifier>().setModelUser(val: ModelUser());
                        c
                            .read<BottomMenuNotifier>()
                            .setActiveButtMenu(val: 0, upd: false);
                        Navigator.pushAndRemoveUntil<dynamic>(
                            c,
                            MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) =>
                                    const Material(child: MyStart())),
                            (route) => false);
                      }
                    },
                    child: readText(
                        text: 'Так',
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        size: 20)),
                CupertinoDialogAction(
                    isDestructiveAction: true,
                    onPressed: () => Navigator.pop(c),
                    child: readText(
                        text: 'Скасувати',
                        color: const Color(0xffFF1616),
                        fontWeight: FontWeight.w500,
                        size: 20))
              ])));
}
