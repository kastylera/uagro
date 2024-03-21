import 'package:agro/app/home/order/components/call_result_info.dart';
import 'package:agro/app/home/order/components/orderInfo.dart';
import 'package:agro/app/home/order/components/order_controller.dart';
import 'package:agro/model/model_user/model_user.dart';
import 'package:agro/ui/text/read_text.dart';
import 'package:flutter/material.dart';

class UnknownOrder extends StatelessWidget {
  final OrderController controller;

  const UnknownOrder({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 20),
      orderInfo(
          header: 'Регіон', text: controller.modelOrder?.region ?? ''),
      orderInfo(header: 'Назва', text: controller.modelOrder?.crop ?? ''),
      orderInfo(
          header: 'Обсяг', text: controller.modelOrder?.capacity ?? ""),
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
      const SizedBox(height: 10),
      controller.modelUser!.isTraider
          ? CallResultInfo(
              text: controller.result?.label ?? "Встановити",
              textColor: controller.result?.color,
              onPressed: () => controller.onSetAnswer(context),
            )
          : const SizedBox()
      
    ]);
  }
}
