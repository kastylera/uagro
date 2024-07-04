import 'dart:developer';

import 'package:agro/app/home/components/home_controller.dart';
import 'package:agro/app/home/order/components/add_price.dart';
import 'package:agro/app/home/order/components/launch_phone.dart';
import 'package:agro/app/home/order/components/set_answer.dart.dart';
import 'package:agro/controllers/abstract/base_controller.dart';
import 'package:agro/model/call_result/call_result.dart';
import 'package:agro/model/model_order/model_contact.dart';
import 'package:agro/model/model_order/struct_order.dart';
import 'package:agro/model/model_order/traider_contact.dart';
import 'package:agro/model/model_order_price/struct_order_price.dart';
import 'package:agro/model/model_user/model_user.dart';
import 'package:agro/model/tariff/tariff.dart';
import 'package:agro/repository/local_storage_repository.dart';
import 'package:agro/ui/adds.dart';
import 'package:flutter/cupertino.dart';
import 'package:agro/model/model_order/model_order.dart';
import 'package:agro/server/api/api.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../../model/model_order_price/model_order_price.dart';
import '../../../../routes/app_pages.dart';
import '../../../../ui/local_notification/local_notification.dart';
import '../../../../vars/model_notifier/user_notifier/user_notifier.dart';

class OrderController extends BaseController {
  late Function(VoidCallback fn) setState;
  ModelOrder? modelOrder;
  ModelContact contact = ModelContact();
  Tariff? tariff;
  CallResult? result;
  bool contactOpened = false;

  ModelUser? modelUser;
  bool loadPage = false;
  int totalPrice = 0;
  List<ModelOrderPrice> modelOrderPrice = [];
  final _localStorageRepository = LocalStorageRepository();
  HomeController homeController = Get.find();
  final _interstitial = Interstitial();

  String? sms;
  String? asId;

  void initPage(
      {required BuildContext context,
      required Function(VoidCallback fn) set}) async {
    setState = set;
    modelUser = context.read<UserNotifier>().modelUser;
    tariff = homeController.tariff;

    await Future.delayed(const Duration(milliseconds: 100));
    if (context.mounted) {
      final arguments = ModalRoute.of(context)!.settings.arguments as List;
      final orderId = arguments[0] as int?;
      await getOrderInfo(orderId);
      modelOrder!.id = orderId;
      result =
          await _localStorageRepository.getResult(modelOrder!.id.toString());
      await Future.delayed(const Duration(milliseconds: 100));
      if (tariff?.isVip == true || tariff?.isPremium == true) {
        onLoadInfoUser();
      }
      onLoadPrice();
      setState(() => loadPage = true);
    }
  }

  void onSell() => loadIfValid(() async {
        ApiAnswer apiAnswer =
            await Api().fermer.closePriceOrder(orderId: modelOrder!.id!);
        log(apiAnswer.data.toString());

        if (apiAnswer.data['status'].toString() == 'true') {
          setState(() => modelOrder!.endDate =
              DateTime.now().subtract(const Duration(days: 1)));
        }
      });

  void onReview() => Get.toNamed(Routes.review, arguments: modelOrder);

  void onLoadPrice() => loadIfValid(() async {
        ApiAnswer apiAnswer =
            await Api().fermer.getInfoPriceOrder(orderId: modelOrder!.id!);
        totalPrice = apiAnswer.data['payload']['total'];

        for (final i in apiAnswer.data['payload']['prices']) {
          modelOrderPrice.add(structOrderPriceData(data: i));
        }

        setState(() {});
      });

  void onSendPrice() => loadIfValid(() async {
        setState(() {});
      });

  void onAddPrice(BuildContext context, ModelOrder order) =>
      showCupertinoModalBottomSheet(
          topRadius: const Radius.circular(30),
          context: context,
          builder: (c) => AddPriceScreen(order: order));

  Future<void> onLoadInfoUser() async {
    ApiAnswer apiAnswer =
        await Api().traider.orderOpenContactFermer(orderId: modelOrder!.id!);

    contact.userName = apiAnswer.data['payload']['name'];
    contact.userRegion = apiAnswer.data['payload']['region'];
    contact.userDistrict = apiAnswer.data['payload']['district'];
    contact.userCity = apiAnswer.data['payload']['city'];
    contact.userEmail = apiAnswer.data['payload']['email'];
    contact.userPhone = apiAnswer.data['payload']['phone'];
    modelOrder?.contact = contact;

    setState(() {});
  }

  void onBack(BuildContext context) => Navigator.pop(context, modelOrder);

  void onLaunchPhone(BuildContext context, String? phone) =>
      showCupertinoModalBottomSheet(
          topRadius: const Radius.circular(30),
          context: context,
          builder: (c) => LaunchPhone(contact: phone));

  void onSetAnswer(BuildContext context) => showCupertinoModalBottomSheet(
      topRadius: const Radius.circular(30),
      context: context,
      builder: (c) => SetAnswer(onAnswered: (p0) {
            _localStorageRepository.addNew(p0, modelOrder!.id.toString());
            result = p0;
            setState(() {});
            Navigator.pop(c);
          }));

  void onAddPriceSave(
          String currency, String paymentForm, String price, int orderId) =>
      loadIfValid(() async {
        ApiAnswer apiAnswer = await Api().traider.addPrice(
            orderId: orderId,
            price: price,
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
        if (tariff?.isPremium == false || tariff?.isVip == false) {
          await _interstitial.loadInterstitialAd(
            doAfter: () async {
              await onLoadInfoUser();
              homeController.onContactOpened(modelOrder!);
            },
            onFailed: () async {
              await Future.delayed(const Duration(milliseconds: 100));
              await onLoadInfoUser();
              homeController.onContactOpened(modelOrder!);
            },
          );
        } else {
          await onLoadInfoUser();
          homeController.onContactOpened(modelOrder!);
        }
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

  Future<void> getOrderInfo(int? orderId) async {
    try {
      ApiAnswer apiAnswer = await Api().traider.getOrder(orderId: orderId);
      modelOrder = structOrderData(data: apiAnswer.data['payload']);

      log("contacts ${apiAnswer.data['tradersopened']}");
      if (apiAnswer.data['tradersopened'] != null) {
        final list = apiAnswer.data['tradersopened'];
        List<TraiderContact> tradersContacts = [];
        for (var element in list) {
          final item = TraiderContact();
          item.date = element['date'].toString();
          item.phone = element['phone'].toString();
          tradersContacts.add(item);
        }
        modelOrder?.traiderContacts = tradersContacts;
      }
    } catch (e) {
      log(e.toString(), error: e);
    }
  }

  void onDeal() => loadIfValid(() async {
        ApiAnswer apiAnswer =
            await Api().traider.deal(tenderId: modelOrder!.id!);

        log(apiAnswer.data.toString());
        if (apiAnswer.data['status'].toString() == 'true') {
          Get.back();
          modelOrderPrice = [];
          onLoadPrice();
        } else {
          notification(text: 'Трапилась помилка при угоді');
        }
      });

  void checkSendOffer() => loadIfValid(() async {
        ApiAnswer apiAnswer =
            await Api().traider.checkSendOffer(sphere: modelOrder?.sphere);
        log(apiAnswer.data.toString());
        if (apiAnswer.data['status'] == '-') {
          notification(
              text:
                  "Встановіть налаштування заявок у вашому кабінеті та завантажте прайс");
          return;
        }
        asId = apiAnswer.data['as_id'];
        sms = apiAnswer.data['sms'];
        final int smsCount =
            int.tryParse(apiAnswer.data['smslimit'].toString()) ?? 0;
        final int abonents =
            int.tryParse(apiAnswer.data['abonents'].toString()) ?? 0;
        if (smsCount >= abonents) {
          showConfirmDialog(
              title: 'Чи впевнені ви?',
              text:
                  "Вашу пропозицію буде відправлено $abonents абонентам. Якщо впевнені в цій дії натисніть ОК.",
              onConfirm: () {
                onSendOffer();
              });
        } else {
          showConfirmDialog(
              title: 'Чи впевнені ви?',
              text:
                  "Через те що кількість доступних Вам sms менша за кількість абонентів, Вашу пропозицію буде відправлено $smsCount з $abonents абонентам. Якщо впевнені в цій дії натисніть ОК.",
              onConfirm: () {
                onSendOffer();
              });
        }
      });

  void onSendOffer() => loadIfValid(() async {
        ApiAnswer apiAnswer = await Api().traider.sendOffer(asId, sms);
        log(apiAnswer.data.toString());
        if (apiAnswer.data['status'] == '+') {
          final recepients = apiAnswer.data['recepients'];
          notification(
              text: "Ваша пропозиція була надіслана $recepients-м абонентам.");
          return;
        }
      });
}
