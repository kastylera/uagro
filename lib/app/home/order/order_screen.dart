import 'package:agro/app/home/components/home_controller.dart';
import 'package:agro/app/home/order/components/sphere/dobriva.dart';
import 'package:agro/app/home/order/components/sphere/oil.dart';
import 'package:agro/app/home/order/components/sphere/seeds.dart';
import 'package:agro/app/home/order/components/sphere/unknown.dart';
import 'package:agro/app/home/order/components/sphere/zerno.dart';
import 'package:agro/model/model_order/model_order.dart';
import 'package:agro/ui/buttons/b_transparent_scalable_button.dart';
import 'package:agro/ui/local_notification/local_notification.dart';
import 'package:agro/ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../components/block_page_screen.dart';
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
        headerColor: AppColors.white,
        topbarColor: getOrderColor(controller.modelOrder),
        dividerColor: getOrderColor(controller.modelOrder),
        header: controller.loadPage
            ? 'Заявка №${controller.modelOrder!.id} від ${DateFormat('dd.MM.yyyy').format(controller.modelOrder!.startDate!)}'
            : '',
        isBack: true,
        endWidget: BTransparentScalableButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(
                  text: (controller.contactOpened
                      ? controller.modelOrder?.toTextFull(controller.contact)
                      : controller.modelOrder?.toTextShort()) ?? ''));
              inAppNotification(
                  text: "Дані про замовлення скопійовані в буфер обміну",
                  c: context);
            },
            scale: ScaleFormat.big,
            child:
                const Icon(Icons.copy, color: AppColors.white, size: 24)),
        theme: SystemUiOverlayStyle.dark.copyWith(statusBarColor: getOrderColor(controller.modelOrder)),
        onPressedReturn: () {
          controller.onBack(context);
          homecontroller.updateCallResults();
        },
        child: !controller.loadPage
            ? const SizedBox()
            : SingleChildScrollView(
                child: getOrderWidget(controller.modelOrder!)));
  }

  Widget getOrderWidget(ModelOrder order) {
    switch (order.sphere) {
      case 15:
        return ZernoOrder(controller: controller);
      case 12:
        return DobrivaOrder(controller: controller);
      case 13:
        return SeedsOrder(controller: controller);
      case 14:
        return OilOrder(controller: controller);
      default:
        return UnknownOrder(controller: controller);
    }
  }

  Color getOrderColor(ModelOrder? order) {
    switch (order?.sphere) {
      case 15:
        return AppColors.zerno;
      case 12:
        return AppColors.dobriva;
      case 14:
        return AppColors.oil;
      case 13:
        return AppColors.seeds;
      default:
        return AppColors.white;
    }
  }
}
