import 'package:agro/app/home/order/components/block_price.dart';
import 'package:agro/app/home/order/components/call_result_info.dart';
import 'package:agro/app/home/order/components/contact.dart';
import 'package:agro/app/home/order/components/orderInfo.dart';
import 'package:agro/app/home/order/components/order_controller.dart';
import 'package:agro/model/model_order_price/model_order_price.dart';
import 'package:agro/model/model_user/model_user.dart';
import 'package:agro/model/tariff/tariff.dart';
import 'package:agro/ui/buttons/b_style.dart';
import 'package:agro/ui/text/read_text.dart';
import 'package:agro/ui/theme/colors.dart';
import 'package:agro/ui/theme/fonts.dart';
import 'package:flutter/material.dart';

class ZernoOrder extends StatelessWidget {
  final OrderController controller;

  const ZernoOrder({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 20),
      orderInfo(
          header: 'Область', text: controller.modelOrder?.region ?? ''),
      orderInfo(
          header: 'Культура', text: controller.modelOrder?.crop ?? ''),
      orderInfo(
          header: 'Об’єм', text: controller.modelOrder?.capacity ?? ""),
      orderInfo(
          header: 'Рік врожаю',
          text: controller.modelOrder?.harvestYear.toString() ?? ''),
      orderInfo(
          header: 'Форма оплати',
          text: controller.modelOrder?.payment ?? ''),
      orderInfo(
          header: 'Тип доставки',
          text: controller.modelOrder?.deliveryForm ?? ''),
      if (controller.modelOrder?.comment != null &&
          controller.modelOrder?.comment != '') ...[
        readText(text: 'Коментар', color: const Color(0xffA9A9A9), size: 20),
        readText(
            text: controller.modelOrder?.comment ?? '',
            color: Colors.black,
            size: 20,
            fontWeight: FontWeight.w500,
            padding: const EdgeInsets.only(top: 10))
      ],
      (controller.tariff?.isVip == true ||
              controller.tariff?.isExclusive == true ||
              controller.contactOpened)
          ? ContactScreen(
              contact: controller.contact,
              onLauchPhone: () => controller.onLaunchPhone(context))
          : const SizedBox(),
      const SizedBox(height: 10),
      controller.modelUser!.isTraider
          ? CallResultInfo(
              text: controller.result?.label ?? "Встановити",
              textColor: controller.result?.color,
              onPressed: () => controller.onSetAnswer(context),
            )
          : const SizedBox(),
      if (controller.modelUser!.isTraider) ...[
        Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(children: [
              controller.tariff?.isVip == true ||
                      controller.tariff?.isExclusive == true
                  ? const SizedBox()
                  : Expanded(
                      child: bStyle(
                          text:
                              controller.contactOpened ? "Сховати" : 'Контакти',
                          c: context,
                          colorText: AppColors.darkGreen,
                          vertical: 15,
                          border:
                              Border.all(color: AppColors.darkGreen, width: 1),
                          colorButt: Colors.transparent,
                          onPressed: () {
                            controller.onContactClick();
                          })),
              controller.tariff?.isVip == true
                  ? Expanded(
                      child: bStyle(
                          text: 'Угода',
                          c: context,
                          colorText: AppColors.white,
                          vertical: 15,
                          onPressed: () {
                            controller.onDeal();
                          }))
                  : const SizedBox(),
              SizedBox(
                  width: controller.tariff?.isExclusive == false ||
                          controller.tariff?.isVip == true
                      ? 25
                      : 0),
              Expanded(
                  child: bStyle(
                      text: 'Відгуки',
                      c: context,
                      colorText: AppColors.darkGreen,
                      vertical: 15,
                      border: Border.all(color: AppColors.darkGreen, width: 1),
                      colorButt: Colors.transparent,
                      onPressed: controller.onReview))
            ])),
        const SizedBox(height: 16),
        bStyle(
            key: UniqueKey(),
            text: 'Додати ціну',
            c: context,
            vertical: 15,
            colorButt: AppColors.yellow,
            onPressed: () => controller.onAddPrice(context, controller.modelOrder!))
      ] else ...[
        bStyle(
            key: UniqueKey(),
            padding: const EdgeInsets.only(top: 35),
            text: DateTime.now().millisecondsSinceEpoch >
                    (controller.modelOrder?.endDate?.millisecondsSinceEpoch ?? 0)
                ? 'Продано'
                : 'Продав',
            size: 23,
            c: context,
            active: DateTime.now().millisecondsSinceEpoch <
                (controller.modelOrder?.endDate!.millisecondsSinceEpoch ?? 0) ,
            colorButt: DateTime.now().millisecondsSinceEpoch >
                    (controller.modelOrder?.endDate?.millisecondsSinceEpoch ?? 0)
                ? const Color(0xffF2F2F2)
                : const Color(0xffFCD300),
            onPressed: controller.onSell)
      ],
      Row(children: [
        readText(
            text: 'Запропоновані ціни',
            style: AppFonts.body1bold.black,
            padding: const EdgeInsets.only(top: 25)),
        const Spacer(),
        readText(
            text: controller.totalPrice.toString(),
            style: AppFonts.title2.grey3,
            padding: const EdgeInsets.only(top: 25))
      ]),
      for (ModelOrderPrice i in controller.modelOrderPrice) ...[
        BlockPriceOrder(modelOrderPrice: i)
      ]
    ]);
  }
}
