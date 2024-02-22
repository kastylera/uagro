import 'package:agro/app/home/components/home_controller.dart';
import 'package:agro/app/home/order/components/contact.dart';
import 'package:agro/app/home/order/components/call_result_info.dart';
import 'package:agro/model/model_order/model_contact.dart';
import 'package:agro/model/model_order/model_order.dart';
import 'package:agro/model/model_order_price/model_order_price.dart';
import 'package:agro/model/model_user/model_user.dart';
import 'package:agro/model/tariff/tariff.dart';
import 'package:agro/ui/buttons/b_transparent_scalable_button.dart';
import 'package:agro/ui/local_notification/local_notification.dart';
import 'package:agro/ui/theme/colors.dart';
import 'package:agro/ui/theme/fonts.dart';
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
  HomeController homecontroller = Get.find();

  @override
  void initState() {
    controller.initPage(context: context, set: setState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlockPageScreen(
        headerSize: 20,
        header: controller.loadPage
            ? 'Заявка №${controller.modelOrder.id} від ${DateFormat('dd.MM.yyyy').format(controller.modelOrder.startDate!)}'
            : 'Ваші заявки',
        isBack: true,
        endWidget: BTransparentScalableButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(
                  text: controller.contactOpened
                      ? controller.modelOrder.toTextFull(controller.contact)
                      : controller.modelOrder.toTextShort()));
              inAppNotification(
                  text: "Дані про замовлення скопійовані в буфер обміну",
                  c: context);
            },
            scale: ScaleFormat.big,
            child:
                const Icon(Icons.copy, color: AppColors.darkGreen, size: 24)),
        theme: SystemUiOverlayStyle.dark,
        onPressedReturn: () {
          controller.onBack(context);
          homecontroller.updateCallResults();
        },
        child: !controller.loadPage
            ? const SizedBox()
            : SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    const SizedBox(height: 20),
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
                    (controller.tariff?.isVip == true ||
                            controller.tariff?.isExclusive == true ||
                            controller.contactOpened)
                        ? ContactScreen(
                            contact: controller.contact,
                            onLauchPhone: () =>
                                controller.onLaunchPhone(context))
                        : const SizedBox(),
                    const SizedBox(height: 10),
                    controller.modelUser.isTraider
                        ? CallResultInfo(
                            text: controller.result?.label ?? "Встановити",
                            textColor: controller.result?.color,
                            onPressed: () => controller.onSetAnswer(context),
                          )
                        : const SizedBox(),
                    if (controller.modelUser.isTraider) ...[
                      Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(children: [
                            controller.tariff?.isVip == true ||
                                    controller.tariff?.isExclusive == true
                                ? const SizedBox()
                                : Expanded(
                                    child: bStyle(
                                        text: controller.contactOpened
                                            ? "Сховати"
                                            : 'Контакти',
                                        c: context,
                                        colorText: AppColors.darkGreen,
                                        vertical: 15,
                                        border: Border.all(
                                            color: AppColors.darkGreen,
                                            width: 1),
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
                                width:
                                    controller.tariff?.isExclusive == false ||
                                            controller.tariff?.isVip == true
                                        ? 25
                                        : 0),
                            Expanded(
                                child: bStyle(
                                    text: 'Відгуки',
                                    c: context,
                                    colorText: AppColors.darkGreen,
                                    vertical: 15,
                                    border: Border.all(
                                        color: AppColors.darkGreen, width: 1),
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
                          onPressed: () => controller.onAddPrice(context))
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
                          c: context,
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
                  ])));
  }

  Widget orderInfo({required String header, required String text}) => Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(children: [
        readText(text: header, style: AppFonts.body1medium.grey3),
        Expanded(
            child: readText(
                text: text,
                style: AppFonts.body1medium.black,
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

  String toTextFull(ModelContact? contact) {
    return "Заявка №$id від ${DateFormat('dd.MM.yyyy').format(startDate!)}\n"
        "Область: $region\n"
        "Культура: $crop\n"
        "Об’єм: $capacity\n"
        "Рік врожаю: $harvestYear\n"
        "Форма оплати: $payForm\n"
        "Тип доставки: $deliveryForm\n"
        "Коментар: $comment\n"
        "${contact?.userName}\n"
        "Адреса: ${contact?.userRegion}\n"
        "${contact?.userDistrict}\n"
        "${contact?.userCity}\n"
        "E-mail: ${contact?.userEmail}\n"
        "Телефон: ${contact?.userPhone}\n";
  }
}
