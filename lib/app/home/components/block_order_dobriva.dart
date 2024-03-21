import 'package:agro/app/home/order/components/call_result_info.dart';
import 'package:agro/model/answer/answer.dart';
import 'package:agro/model/model_user/model_user.dart';
import 'package:agro/ui/theme/colors.dart';
import 'package:agro/ui/theme/fonts.dart';
import 'package:agro/ui/utils/date_extensions.dart';
import 'package:flutter/material.dart';
import 'package:agro/model/model_order/model_order.dart';
import 'package:agro/ui/text/read_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../generated/assets.dart';
import '../../../ui/buttons/b_transparent_scalable_button.dart';
import 'home_controller.dart';

class BlockOrderDobriva extends StatelessWidget {
  final ModelOrder modelOrder;
  final Answer? answer;
  final Function({required ModelOrder model}) onPressed;

  const BlockOrderDobriva(
      {super.key,
      required this.modelOrder,
      required this.onPressed,
      this.answer});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: BTransparentScalableButton(
          onPressed: () => onPressed(model: modelOrder),
          scale: ScaleFormat.small,
          child: Container(
              decoration: BoxDecoration(
                color: AppColors.dobriva.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.dobriva),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(children: [
                          Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: SvgPicture.asset(Assets.dobriva, width: 32)),
                          Expanded(
                            child: readText(
                              text:
                                  'Заявка № ${modelOrder.id}\nвід: ${modelOrder.startDate?.formatDateShort()}',
                              style: AppFonts.body1bold.black,
                            ),
                          ),
                          if (DateTime.now().millisecondsSinceEpoch >
                              modelOrder.endDate!.millisecondsSinceEpoch) ...[
                            readText(
                              text: 'Термін дії закінчився',
                              style: AppFonts.body2semibold.red,
                            )
                          ] else if (modelOrder.priceAdded != null &&
                              modelOrder.priceAdded!) ...[
                            readText(
                                text: '₴',
                                style: AppFonts.title1.mainGreen,
                                padding: const EdgeInsets.only(bottom: 15))
                          ],
                          if (controller.modelUser.role == 'distrib') ...[
                            const SizedBox(width: 10),
                            Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: SvgPicture.asset(
                                    modelOrder.request != null &&
                                            modelOrder.request!
                                        ? Assets.appIsViewTrue
                                        : Assets.appIsViewFalse,
                                    height: modelOrder.request != null &&
                                            modelOrder.request!
                                        ? 30
                                        : 28))
                          ]
                        ]),
                      ),
                      orderInfo(
                          header: 'Регіон', text: modelOrder.region.toString()),
                      orderInfo(
                          header: 'Продукт', text: modelOrder.crop.toString()),
                      orderInfo(
                          header: 'Обсяг',
                          text: modelOrder.capacity.toString()),
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
                      if (modelOrder.comment != null &&
                          modelOrder.comment != '') ...[
                        readText(
                          text: 'Коментар',
                          style: AppFonts.body1medium.grey3,
                        ),
                        readText(
                            text: modelOrder.comment!,
                            style: AppFonts.body1medium.black,
                            padding: const EdgeInsets.only(top: 4)),
                      ],
                      controller.modelUser.isTraider && answer != null
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

  Widget orderInfo({required String header, required String text}) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(children: [
          readText(
            text: header,
            style: AppFonts.body1medium.grey3,
          ),
          const Spacer(),
          readText(text: text, style: AppFonts.body1medium.black)
        ]),
      );
}
