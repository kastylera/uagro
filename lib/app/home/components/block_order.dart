import 'package:agro/app/home/order/components/call_result_info.dart';
import 'package:agro/model/answer/answer.dart';
import 'package:agro/model/model_user/model_user.dart';
import 'package:flutter/material.dart';
import 'package:agro/model/model_order/model_order.dart';
import 'package:agro/ui/text/read_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../generated/assets.dart';
import '../../../ui/buttons/b_transparent_scalable_button.dart';
import 'home_controller.dart';

class BlockOrder extends StatelessWidget {
  final ModelOrder modelOrder;
  final Answer? answer;
  final Function({required ModelOrder model}) onPressed;

  const BlockOrder(
      {super.key,
      required this.modelOrder,
      required this.onPressed,
      this.answer});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: BTransparentScalableButton(
          onPressed: () => onPressed(model: modelOrder),
          scale: ScaleFormat.small,
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xff000000).withOpacity(0.05),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: const Offset(0, 0))
                  ]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                readText(
                                    text:
                                        'Заявка № ${modelOrder.id}\nвід: ${DateFormat('dd.MM.yyyy').format(modelOrder.startDate!)}',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    size: 20),
                                // const SizedBox(height: 5),
                                // readText(text: 'від: ${DateFormat('dd.MM.yyyy').format(modelOrder.startDate!)}', color: const Color(0xffA9A9A9), size: 20),
                              ]),
                          const Spacer(),
                          if (DateTime.now().millisecondsSinceEpoch >
                              modelOrder.endDate!.millisecondsSinceEpoch) ...[
                            readText(
                                text: 'Термін дії закінчився',
                                color: const Color(0xffFF5050),
                                size: 18)
                          ] else if (modelOrder.priceAdded != null &&
                              modelOrder.priceAdded!) ...[
                            readText(
                                text: '₴',
                                color: const Color(0xff01CA20),
                                fontWeight: FontWeight.w600,
                                size: 30,
                                padding: const EdgeInsets.only(bottom: 15))
                          ],
                          if (controller.modelUser.role == 'distrib') ...[
                            const SizedBox(width: 20),
                            Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: SvgPicture.asset(
                                    modelOrder.request != null &&
                                            modelOrder.request!
                                        ? Assets.appIsViewTrue
                                        : Assets.appIsViewFalse,
                                    height: modelOrder.request != null &&
                                            modelOrder.request!
                                        ? 25
                                        : 35))
                          ]
                        ]),
                      ),
                      orderInfo(
                          header: 'Область',
                          text: modelOrder.region.toString()),
                      orderInfo(
                          header: 'Культура', text: modelOrder.crop.toString()),
                      orderInfo(
                          header: 'Об’єм',
                          text: modelOrder.capacity.toString()),
                      orderInfo(
                          header: 'Рік врожаю',
                          text: modelOrder.harvestYear.toString()),
                      orderInfo(
                          header: 'Форма розрахунку',
                          text: modelOrder.payForm == 'beznal'
                              ? '1ф. (б/г)'
                              : modelOrder.payForm == 'nal'
                                  ? '2ф. (гот.)'
                                  : modelOrder.payment.toString()),
                      orderInfo(
                          header: 'Тип доставки',
                          text: modelOrder.deliveryForm.toString()),
                      // orderInfo(header: 'Дата заявки', text: DateFormat('dd.MM.yyyy').format(modelOrder.startDate!), bold: true),
                      if (modelOrder.comment != null &&
                          modelOrder.comment != '') ...[
                        readText(
                            text: 'Коментар',
                            color: const Color(0xffA9A9A9),
                            size: 20),
                        readText(
                            text: modelOrder.comment!,
                            color: Colors.black,
                            size: 20,
                            fontWeight: FontWeight.w500,
                            padding: const EdgeInsets.only(top: 10)),
                        
                      ],
                      controller.modelUser.isTraider
                          ? Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: CallResultInfo(
                                  text:
                                      answer?.result?.label ?? "Не встановлено",
                                  horizontalPadding: 0,
                                  textColor: answer?.result?.color,
                                  onPressed: () {}))
                          : const SizedBox()
                    ]),
              ))),
    );
  }

  Widget orderInfo(
          {required String header, required String text, bool bold = false}) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(children: [
          readText(
              text: header,
              color: bold ? Colors.black : const Color(0xffA9A9A9),
              size: 20,
              fontWeight: bold ? FontWeight.w600 : FontWeight.w400),
          const Spacer(),
          readText(
              text: text,
              color: Colors.black,
              size: 20,
              fontWeight: FontWeight.w500)
        ]),
      );
}
