import 'dart:developer';

import 'package:agro/app/home/order/components/add_price.dart';
import 'package:agro/app/home/order/components/launch_phone.dart';
import 'package:agro/model/model_order_price/struct_order_price.dart';
import 'package:agro/model/model_user/model_user.dart';
import 'package:agro/model/tariff/tariff.dart';
import 'package:flutter/cupertino.dart';
import 'package:agro/model/model_order/model_order.dart';
import 'package:agro/server/api/api.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../../controllers/abstract/from_controller.dart';
import '../../../../controllers/app_input_controller.dart';
import '../../../../model/model_order_price/model_order_price.dart';
import '../../../../routes/app_pages.dart';
import '../../../../ui/local_notification/local_notification.dart';
import '../../../../vars/model_notifier/user_notifier/user_notifier.dart';

class OrderController extends FormController {
  late Function(VoidCallback fn) setState;
  late BuildContext c;
  late ModelOrder modelOrder;
  late Tariff tariff;

  late ModelUser modelUser;
  bool loadPage = false;
  int totalPrice = 0;
  List<ModelOrderPrice> modelOrderPrice = [];
  late TextEditingController priceController;

  @override
  void onInit() {
    priceController = AppInputController();
    super.onInit();
  }

  void initPage(
      {required BuildContext context,
      required Function(VoidCallback fn) set}) async {
    c = context;
    setState = set;
    modelUser = c.read<UserNotifier>().modelUser;

    await Future.delayed(const Duration(milliseconds: 100));
    if (c.mounted) {
      final arguments = ModalRoute.of(c)!.settings.arguments as List;
      modelOrder = arguments[0] as ModelOrder;
      tariff = arguments[1] as Tariff;
      await Future.delayed(const Duration(milliseconds: 100));
      onLoadInfoUser();
      onLoadPrice();
      setState(() => loadPage = true);
    }
  }

  void onSell() => loadIfValid(() async {
        ApiAnswer apiAnswer =
            await Api().fermer.closePriceOrder(c: c, orderId: modelOrder.id!);
        log(apiAnswer.data.toString());

        if (apiAnswer.data['status'].toString() == 'true') {
          setState(() => modelOrder.endDate =
              DateTime.now().subtract(const Duration(days: 1)));
        }
      }, c: c);

  void onReview() => Get.toNamed(Routes.review, arguments: modelOrder);

  void onLoadPrice() => loadIfValid(() async {
        ApiAnswer apiAnswer =
            await Api().fermer.getInfoPriceOrder(c: c, orderId: modelOrder.id!);
        // ApiAnswer apiAnswer = await Api().fermer.getInfoPriceOrder(c: c, orderId: 99384);
        totalPrice = apiAnswer.data['payload']['total'];

        for (final i in apiAnswer.data['payload']['prices']) {
          modelOrderPrice.add(structOrderData(data: i));
        }

        setState(() {});
      }, c: c);

  void onAddPrice() => showCupertinoModalBottomSheet(
      topRadius: const Radius.circular(30),
      context: c,
      builder: (c) => const AddPriceScreen());

  void onLoadInfoUser() async {
    ApiAnswer apiAnswer = await Api()
        .traider
        .orderOpenContactFermer(c: c, orderId: modelOrder.id!);

    modelOrder.userName = apiAnswer.data['payload']['name'];
    modelOrder.userRegion = apiAnswer.data['payload']['region'];
    modelOrder.userDistrict = apiAnswer.data['payload']['district'];
    modelOrder.userCity = apiAnswer.data['payload']['city'];
    modelOrder.userEmail = apiAnswer.data['payload']['email'];
    modelOrder.userPhone = apiAnswer.data['payload']['phone'];

    setState(() {});
  }

  void onBack() => Navigator.pop(c, modelOrder);

  void onLaunchPhone() => showCupertinoModalBottomSheet(
      topRadius: const Radius.circular(30),
      context: c,
      builder: (c) => LaunchPhone(modelOrder: modelOrder));

  void onAddPriceSave() => loadIfValid(() async {
        ApiAnswer apiAnswer = await Api().traider.addPrice(
            c: c, orderId: modelOrder.id!, price: priceController.text);

        log(apiAnswer.data.toString());
        if (apiAnswer.data['status'].toString() == 'true') {
          Navigator.pop(c);
          modelOrderPrice = [];
          onLoadPrice();
        } else {
          inAppNotification(
              text: 'Трапилась помилка при додаванні ціни, перевірте ваші дані',
              c: c);
        }

        //addPrice
      }, c: c);

  void onDeal() => loadIfValid(() async {
        ApiAnswer apiAnswer = await Api().traider.deal(
            c: c, tenderId: modelOrder.id!);

        log(apiAnswer.data.toString());
        if (apiAnswer.data['status'].toString() == 'true') {
          Navigator.pop(c);
          modelOrderPrice = [];
          onLoadPrice();
        } else {
          inAppNotification(
              text: 'Трапилась помилка при угоді',
              c: c);
        }

        //addPrice
      }, c: c);
}
