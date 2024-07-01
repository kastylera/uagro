import 'package:agro/app/home/order/components/bids.dart';
import 'package:agro/app/home/order/components/call_result_info.dart';
import 'package:agro/app/home/order/components/orderInfo.dart';
import 'package:agro/app/home/order/components/order_controller.dart';
import 'package:agro/app/home/order/components/sphere/seeds.dart';
import 'package:agro/app/home/order/components/traiders_contacts.dart';
import 'package:agro/model/model_user/model_user.dart';
import 'package:agro/model/tariff/tariff.dart';
import 'package:agro/ui/buttons/b_style.dart';
import 'package:agro/ui/text/read_text.dart';
import 'package:agro/ui/theme/colors.dart';
import 'package:flutter/material.dart';

class DobrivaOrder extends StatelessWidget {
  final OrderController controller;

  const DobrivaOrder({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 20),
      orderInfo(
          header: 'Регіон',
          text: controller.modelOrder?.region?.toString() ?? ""),
      orderInfo(
          header: 'Назва', text: controller.modelOrder?.crop?.toString() ?? ""),
      orderInfo(
          header: 'Обсяг',
          text: controller.modelOrder?.capacity?.toString() ?? ''),
      orderInfo(
          header: 'Форма оплати',
          text: controller.modelOrder?.payment?.toString() ?? ""),
      orderInfo(
          header: 'Тип доставки',
          text: controller.modelOrder?.deliveryForm?.toString() ?? ''),
      if (controller.modelOrder?.comment != 'null' &&
          controller.modelOrder?.comment != '') ...[
        readText(text: 'Коментар', color: const Color(0xffA9A9A9), size: 20),
        readText(
            text: controller.modelOrder?.comment ?? '',
            color: Colors.black,
            size: 20,
            fontWeight: FontWeight.w500,
            padding: const EdgeInsets.only(top: 10))
      ],
      const SizedBox(height: 10),
      controller.modelUser!.isTraider
          ? CallResultInfo(
              text: controller.result?.label ?? "Встановити",
              textColor: controller.result?.color,
              onPressed: () => controller.onSetAnswer(context),
            )
          : const SizedBox(),
      if (controller.modelUser!.isTraider) ...[
        traidersButton(controller, context)
      ] else ...[
        fermersButton(controller, context)
      ],
      controller.modelOrder?.quality != null
          ? statisticWidget(controller.modelOrder!.quality!)
          : const SizedBox()
    ]);
  }

  Widget traidersButton(OrderController controller, BuildContext context) {
    return Column(children: [
      bStyle(
          key: UniqueKey(),
          text: 'Відправити пропозицію',
          c: context,
          vertical: 15,
          colorButt: AppColors.yellow,
          onPressed: () => {controller.checkSendOffer()})
    ]);
  }

  Widget fermersButton(OrderController controller, BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const SizedBox(height: 20),
      if ((controller.modelOrder?.bids ?? []).isNotEmpty)
        bids(controller.modelOrder?.bids ?? []),
      if ((controller.modelOrder?.traiderContacts ?? []).isNotEmpty)
        traiderContacts(
            controller.modelOrder?.traiderContacts ?? [],
            controller.tariff!.isVip || controller.tariff!.isPremium,
            (phone) => {controller.onLaunchPhone(context, phone)})
    ]);
  }
}
