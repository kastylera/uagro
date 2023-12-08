import 'dart:developer';

import 'package:agro/app/home/components/home_controller.dart';
import 'package:agro/app/home/order/components/add_price.dart';
import 'package:agro/app/home/order/components/launch_phone.dart';
import 'package:agro/app/home/order/components/set_answer.dart.dart';
import 'package:agro/controllers/abstract/base_controller.dart';
import 'package:agro/model/call_result/call_result.dart';
import 'package:agro/model/model_order/model_contact.dart';
import 'package:agro/model/model_order_price/struct_order_price.dart';
import 'package:agro/model/model_user/model_user.dart';
import 'package:agro/model/tariff/tariff.dart';
import 'package:agro/repository/local_storage_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:agro/model/model_order/model_order.dart';
import 'package:agro/server/api/api.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../../controllers/app_input_controller.dart';
import '../../../../model/model_order_price/model_order_price.dart';
import '../../../../routes/app_pages.dart';
import '../../../../ui/local_notification/local_notification.dart';
import '../../../../vars/model_notifier/user_notifier/user_notifier.dart';

class OrderController extends BaseController {
  late Function(VoidCallback fn) setState;
  late ModelOrder modelOrder;
  ModelContact contact = ModelContact();
  late Tariff? tariff;
  late CallResult? result;
  bool contactOpened = false;

  late ModelUser modelUser;
  bool loadPage = false;
  int totalPrice = 0;
  List<ModelOrderPrice> modelOrderPrice = [];
  late TextEditingController priceController;
  final _localStorageRepository = LocalStorageRepository();
  HomeController homeController = Get.find();

  @override
  void onInit() {
    priceController = AppInputController();
    super.onInit();
  }

  void initPage(
      {required BuildContext context,
      required Function(VoidCallback fn) set}) async {
    setState = set;
    modelUser = context.read<UserNotifier>().modelUser;

    await Future.delayed(const Duration(milliseconds: 100));
    if (context.mounted) {
      final arguments = ModalRoute.of(context)!.settings.arguments as List;
      modelOrder = arguments[0] as ModelOrder;
      tariff = arguments[1] as Tariff?;
      result =
          await _localStorageRepository.getResult(modelOrder.id.toString());
      await Future.delayed(const Duration(milliseconds: 100));
      if (tariff?.isVip == true || tariff?.isExclusive == true) {
        onLoadInfoUser();
      }
      onLoadPrice();
      setState(() => loadPage = true);
    }
  }

  void onSell() => loadIfValid(() async {
        ApiAnswer apiAnswer =
            await Api().fermer.closePriceOrder(orderId: modelOrder.id!);
        log(apiAnswer.data.toString());

        if (apiAnswer.data['status'].toString() == 'true') {
          setState(() => modelOrder.endDate =
              DateTime.now().subtract(const Duration(days: 1)));
        }
      });

  void onReview() => Get.toNamed(Routes.review, arguments: modelOrder);

  void onLoadPrice() => loadIfValid(() async {
        ApiAnswer apiAnswer =
            await Api().fermer.getInfoPriceOrder(orderId: modelOrder.id!);
        totalPrice = apiAnswer.data['payload']['total'];

        for (final i in apiAnswer.data['payload']['prices']) {
          modelOrderPrice.add(structOrderData(data: i));
        }

        setState(() {});
      });

  void onAddPrice(BuildContext context) => showCupertinoModalBottomSheet(
      topRadius: const Radius.circular(30),
      context: context,
      builder: (c) => const AddPriceScreen());

  Future<void> onLoadInfoUser() async {
    ApiAnswer apiAnswer =
        await Api().traider.orderOpenContactFermer(orderId: modelOrder.id!);

    contact.userName = apiAnswer.data['payload']['name'];
    contact.userRegion = apiAnswer.data['payload']['region'];
    contact.userDistrict = apiAnswer.data['payload']['district'];
    contact.userCity = apiAnswer.data['payload']['city'];
    contact.userEmail = apiAnswer.data['payload']['email'];
    contact.userPhone = apiAnswer.data['payload']['phone'];

    setState(() {});
  }

  void onBack(BuildContext context) => Navigator.pop(context, modelOrder);

  void onLaunchPhone(BuildContext context) => showCupertinoModalBottomSheet(
      topRadius: const Radius.circular(30),
      context: context,
      builder: (c) => LaunchPhone(contact: contact));

  void onSetAnswer(BuildContext context) => showCupertinoModalBottomSheet(
      topRadius: const Radius.circular(30),
      context: context,
      builder: (c) => SetAnswer(onAnswered: (p0) {
            _localStorageRepository.addNew(p0, modelOrder.id.toString());
            result = p0;
            setState(() {});
            Navigator.pop(c);
          }));

  void onAddPriceSave(String currency, String paymentForm) =>
      loadIfValid(() async {
        ApiAnswer apiAnswer = await Api().traider.addPrice(
            orderId: modelOrder.id!,
            price: priceController.text,
            currency: currency,
            form: paymentForm);

        log(apiAnswer.data.toString());
        if (apiAnswer.data['status'].toString() == 'true') {
          Get.back();
          modelOrderPrice = [];
          onLoadPrice();
        } else {
          notification(
              text:
                  'Трапилась помилка при додаванні ціни, перевірте ваші дані');
        }
      });

  Future<void> onContactClick() async {
    if (contact.userName == null) {
      try {
        await onLoadInfoUser();
        homeController.onContactOpened(modelOrder);
      } catch (e) {
        log("contact doesn't opened");
      }
    }
    setState(() {
      if (contact.userName != null) {
        contactOpened = !contactOpened;
      } else {
        notification(
            text:
                "Ви не можете відкрити ці контакти. Перевірте кількіть контактів в тарифі.");
      }
    });
  }

  void onDeal() => loadIfValid(() async {
        ApiAnswer apiAnswer =
            await Api().traider.deal(tenderId: modelOrder.id!);

        log(apiAnswer.data.toString());
        if (apiAnswer.data['status'].toString() == 'true') {
          Get.back();
          modelOrderPrice = [];
          onLoadPrice();
        } else {
          notification(text: 'Трапилась помилка при угоді');
        }
      });
}
