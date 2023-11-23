import 'package:agro/generated/assets.dart';
import 'package:agro/model/model_order/model_order.dart';
import 'package:agro/ui/buttons/b_style.dart';
import 'package:agro/ui/local_notification/local_notification.dart';
import 'package:agro/ui/text/read_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../ui/buttons/b_transparent_scalable_button.dart';

class LaunchPhone extends StatelessWidget {
  final ModelOrder modelOrder;

  const LaunchPhone({super.key, required this.modelOrder});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 200,
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xffEDEDED),
                      borderRadius: BorderRadius.circular(3)),
                  height: 10,
                  width: 100)),
          const SizedBox(height: 32),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            BTransparentScalableButton(
                onPressed: () => onCall(modelOrder.userPhone.toString()),
                scale: ScaleFormat.small,
                child: const Icon(
                  Icons.call_rounded,
                  size: 50,
                  color: Colors.green,
                )),
            const SizedBox(width: 30),
            BTransparentScalableButton(
                onPressed: () {
                  openTelegram(
                      phone: modelOrder.userPhone.toString(), context: context);
                },
                scale: ScaleFormat.small,
                child: Image.asset(Assets.authTelegram, width: 50)),
            const SizedBox(width: 30),
            BTransparentScalableButton(
                onPressed: () {
                  openViber(
                      phone: modelOrder.userPhone.toString(), context: context);
                },
                scale: ScaleFormat.small,
                child: Image.asset(Assets.authViber, width: 50))
          ]),
          bStyle(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              text: 'Закрити',
              size: 23,
              c: context,
              colorText: Colors.black,
              vertical: 15,
              colorButt: const Color(0xffF2F2F2),
              onPressed: () => Navigator.pop(context))
        ],
      ),
    );
  }

  void onContactViber(String phone) =>
      launchUrl(Uri.parse('viber://add?number=%2B${phone.substring(1)}'),
          mode: LaunchMode.externalApplication);

  void onContactTelegram(String phone) =>
      launchUrl(Uri.parse('https://t.me/$phone'),
          mode: LaunchMode.externalApplication);

  Future<void> openTelegram({
    required BuildContext context,
    required String phone,
    LaunchMode mode = LaunchMode.externalApplication,
  }) async {
    const String url = 'tg://msg';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse('$url?to=$phone'),
        mode: mode,
      );
    } else {
      inAppNotification(
          text:
              'Ми не знайшли «Telegram» на Вашому телефоні. Будь ласка, встановіть додаток та стробуйте знову.',
          c: context);
    }
  }

  Future<void> openViber({
    required BuildContext context,
    required String phone,
    LaunchMode mode = LaunchMode.externalApplication,
  }) async {
    final String url = 'viber://chat?number=$phone';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: mode,
      );
    } else {
      inAppNotification(
          text:
              'Ми не знайшли «Viber» на Вашому телефоні. Будь ласка, встановіть додаток та стробуйте знову.',
          c: context);
    }
  }

  void onCall(String phone) => launchUrl(Uri(scheme: 'tel', path: phone),
      mode: LaunchMode.externalApplication);

  Widget orderInfo(
          {required String header,
          required String text,
          Function()? onPressed}) =>
      Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
          child: BTransparentScalableButton(
              onPressed: onPressed ?? () {},
              scale: onPressed == null ? ScaleFormat.none : ScaleFormat.small,
              child: Row(children: [
                readText(
                    text: header, color: const Color(0xffA9A9A9), size: 20),
                Expanded(
                    child: readText(
                        text: text,
                        color: Colors.black,
                        size: 20,
                        fontWeight: FontWeight.w500,
                        align: TextAlign.end))
              ])));
}
