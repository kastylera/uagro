import 'package:agro/app/home/order/components/contact.dart';
import 'package:agro/app/home/order/components/order_info.dart';
import 'package:agro/model/model_order/model_order.dart';
import 'package:agro/model/model_order_price/model_order_price.dart';
import 'package:agro/model/tariff/tariff.dart';
import 'package:agro/ui/buttons/b_transparent_scalable_button.dart';
import 'package:agro/ui/local_notification/local_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../ui/buttons/b_style.dart';
import '../../../ui/text/read_text.dart';
import '../../components/block_page_screen.dart';
import 'components/block_price.dart';
import 'components/order_controller.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  OrderController controller = Get.find();
  bool contactOpened = false;

  @override
  void initState() {
    controller.initPage(context: context, set: setState);
    super.initState();
  }

  @override
  Widget build(BuildContext c) {
    return BlockPageScreen(
        headerSize: 20,
        header: controller.loadPage
            ? 'Заявка №${controller.modelOrder.id} від ${DateFormat('dd.MM.yyyy').format(controller.modelOrder.startDate!)}'
            : 'Ваші заявки',
        isBack: true,
        endWidget: BTransparentScalableButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(
                  text: contactOpened
                      ? controller.modelOrder.toTextFull()
                      : controller.modelOrder.toTextShort()));
              inAppNotification(
                  text: "Дані про замовлення скопійовані в буфер обміну",
                  c: context);
            },
            scale: ScaleFormat.big,
            child: const Icon(Icons.copy, color: Color(0xffFCD300), size: 24)),
        theme: SystemUiOverlayStyle.dark,
        onPressedReturn: controller.onBack,
        child: !controller.loadPage
            ? const SizedBox()
            : SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    const SizedBox(height: 30),
                    orderInfo(
                        header: 'Область',
                        text: controller.modelOrder.region.toString()),
                    orderInfo(
                        header: 'Культура',
                        text: controller.modelOrder.crop.toString()),
                    orderInfo(
                        header: 'Об’єм',
                        text: controller.modelOrder.capacity.toString()),
                    orderInfo(
                        header: 'Рік врожаю',
                        text: controller.modelOrder.harvestYear.toString()),
                    orderInfo(
                        header: 'Форма оплати',
                        text: controller.modelOrder.payment.toString()),
                    orderInfo(
                        header: 'Тип доставки',
                        text: controller.modelOrder.deliveryForm.toString()),
                    if (controller.modelOrder.comment != null &&
                        controller.modelOrder.comment != '') ...[
                      readText(
                          text: 'Коментар',
                          color: const Color(0xffA9A9A9),
                          size: 20),
                      readText(
                          text: controller.modelOrder.comment!,
                          color: Colors.black,
                          size: 20,
                          fontWeight: FontWeight.w500,
                          padding: const EdgeInsets.only(top: 10))
                    ],
                    (controller.tariff.isVip ||
                            controller.tariff.isExclusive ||
                            contactOpened)
                        ? ContactScreen(
                            modelOrder: controller.modelOrder,
                            onLauchPhone: controller.onLaunchPhone)
                        : const SizedBox(),
                    const SizedBox(height: 10),    
                    OrderInfo(
                      header: "Результат дзвінка",
                      text: controller.result?.label ?? "Не встановлено",
                      textColor: controller.result?.color,
                      onPressed: () {
                        controller.onSetAnswer();
                      },
                    ),
                    if (controller.modelUser.role == 'distrib') ...[
                      Padding(
                          padding: const EdgeInsets.only(top: 35),
                          child: Row(children: [
                            controller.tariff.isVip ||
                                    controller.tariff.isExclusive
                                ? const SizedBox()
                                : Expanded(
                                    child: bStyle(
                                        width: 160,
                                        text: contactOpened
                                            ? "Сховати"
                                            : 'Контакти',
                                        size: 23,
                                        c: c,
                                        colorText: Colors.black,
                                        vertical: 15,
                                        colorButt: const Color(0xffF2F2F2),
                                        onPressed: () {
                                          setState(() {
                                            contactOpened = !contactOpened;
                                          });
                                        })),
                            controller.tariff.isVip
                                ? Expanded(
                                    child: bStyle(
                                        width: 160,
                                        text: 'Угода',
                                        size: 23,
                                        c: c,
                                        colorText: Colors.black,
                                        vertical: 15,
                                        colorButt: const Color(0xffF2F2F2),
                                        onPressed: () {
                                          controller.onDeal();
                                        }))
                                : const SizedBox(),
                            SizedBox(
                                width: !controller.tariff.isExclusive ||
                                        controller.tariff.isVip
                                    ? 25
                                    : 0),
                            Expanded(
                                child: bStyle(
                                    width: 160,
                                    text: 'Відгуки',
                                    size: 23,
                                    c: c,
                                    colorText: Colors.black,
                                    vertical: 15,
                                    colorButt: const Color(0xffF2F2F2),
                                    onPressed: controller.onReview))
                          ])),
                      const SizedBox(height: 25),
                      bStyle(
                          key: UniqueKey(),
                          text: 'Додати ціну',
                          size: 23,
                          c: c,
                          colorButt: const Color(0xffFCD300),
                          onPressed: controller.onAddPrice)
                    ] else ...[
                      bStyle(
                          key: UniqueKey(),
                          padding: const EdgeInsets.only(top: 35),
                          text: DateTime.now().millisecondsSinceEpoch >
                                  controller.modelOrder.endDate!
                                      .millisecondsSinceEpoch
                              ? 'Продано'
                              : 'Продав',
                          size: 23,
                          c: c,
                          active: DateTime.now().millisecondsSinceEpoch <
                              controller
                                  .modelOrder.endDate!.millisecondsSinceEpoch,
                          colorButt: DateTime.now().millisecondsSinceEpoch >
                                  controller.modelOrder.endDate!
                                      .millisecondsSinceEpoch
                              ? const Color(0xffF2F2F2)
                              : const Color(0xffFCD300),
                          onPressed: controller.onSell)
                    ],
                    Row(children: [
                      readText(
                          text: 'Запропоновані ціни',
                          color: Colors.black,
                          size: 20,
                          fontWeight: FontWeight.w600,
                          padding: const EdgeInsets.only(top: 25)),
                      const Spacer(),
                      readText(
                          text: controller.totalPrice.toString(),
                          color: const Color(0xffA9A9A9),
                          size: 22,
                          fontWeight: FontWeight.w600,
                          padding: const EdgeInsets.only(top: 25))
                    ]),
                    for (ModelOrderPrice i in controller.modelOrderPrice) ...[
                      BlockPriceOrder(modelOrderPrice: i)
                    ]
                  ])));
  }

  Widget orderInfo({required String header, required String text}) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(children: [
        readText(text: header, color: const Color(0xffA9A9A9), size: 20),
        Expanded(
            child: readText(
                text: text,
                color: Colors.black,
                size: 20,
                fontWeight: FontWeight.w500,
                align: TextAlign.end))
      ]));
}

extension OrderX on ModelOrder {
  String toTextShort() {
    return "Заявка №$id від ${DateFormat('dd.MM.yyyy').format(startDate!)}\n"
        "Область: $region\n"
        "Культура: $crop\n"
        "Об’єм: $capacity\n"
        "Рік врожаю: $harvestYear\n"
        "Форма оплати: $payForm\n"
        "Тип доставки: $deliveryForm\n"
        "Коментар: $comment\n";
  }

  String toTextFull() {
    return "Заявка №$id від ${DateFormat('dd.MM.yyyy').format(startDate!)}\n"
        "Область: $region\n"
        "Культура: $crop\n"
        "Об’єм: $capacity\n"
        "Рік врожаю: $harvestYear\n"
        "Форма оплати: $payForm\n"
        "Тип доставки: $deliveryForm\n"
        "Коментар: $comment\n"
        "$userName\n"
        "Адреса: $userRegion\n"
        "$userDistrict\n"
        "$userCity\n"
        "E-mail: $userEmail\n"
        "Телефон: $userPhone\n";
  }
}
