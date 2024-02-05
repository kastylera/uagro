import 'dart:developer';

import 'package:agro/controllers/abstract/base_controller.dart';
import 'package:agro/model/answer/answer.dart';
import 'package:agro/model/message/created.dart';
import 'package:agro/model/message/message.dart';
import 'package:agro/model/model_user/model_user.dart';
import 'package:agro/model/tariff/tariff.dart';
import 'package:agro/repository/local_storage_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:agro/model/model_order/struct_order.dart';
import 'package:agro/routes/app_pages.dart';
import 'package:agro/server/api/api.dart';
import 'package:hive/hive.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../controllers/app_input_controller.dart';
import '../../../model/model_order/model_order.dart';
import '../../../ui/local_notification/local_notification.dart';

class HomeController extends BaseController {
  late Function(VoidCallback fn) setState;
  late BuildContext c;
  late TextEditingController searchController;
  late ModelUser modelUser;
  late final RefreshController controllerLoading;
  late final ScrollController controllerScroll;
  String messHeader = 'Заявки';
  int total = 0;
  final _localStorageRepository = LocalStorageRepository();

  int page = 1;
  List<ModelOrder> modelOrder = [];
  List<Answer> callResults = [];
  List<Message> messages = [];
  List<Created> combinedList = [];
  Tariff? tariff;

  @override
  void onInit() {
    searchController = AppInputController();
    controllerLoading = RefreshController();
    controllerScroll = ScrollController();
    super.onInit();
  }

  void initPage(
      {required BuildContext context,
      required Function(VoidCallback fn) set}) async {
    c = context;
    setState = set;
    modelUser = Hive.box('data').get('modelUser');

    setState(() => page = 1);
    await Future.delayed(const Duration(milliseconds: 100));
    modelOrder = [];
    onTariffInfo();
    loadRequest();
  }

  void fermerCreateOrder() => loadIfValid(() async {
        ApiAnswer apiAnswer = await Api().fermer.createOrder();

        if (c.mounted) {
          if (apiAnswer.data['status']) {
            notification(
              text: 'Заявка відправлена. Скоро з вами зв’яжеться оператор.',
            );
          } else {
            notification(text: apiAnswer.data['message']);
          }
        }
      });

  void onSearch() {
    page = 1;
    modelOrder = [];
    loadRequest();
  }

  void loadRequest() => loadIfValid(() async {
        await onMessages();
        late ApiAnswer apiAnswer;

        if (modelUser.role == 'distrib') {
          apiAnswer = await Api().traider.getOrderList(
              page: page, limit: 15, search: searchController.text);
        } else {
          apiAnswer = await Api().fermer.getOrderList(
              page: page, limit: 15, search: searchController.text);
        }

        log(apiAnswer.data.toString());
        callResults = await _localStorageRepository.getAll();
        setState(() {
          if (c.mounted) {
            if (apiAnswer.data['status']) {
              total =
                  int.tryParse(apiAnswer.data['payload']['total'].toString()) ??
                      0;
              for (final i in apiAnswer.data['payload']['items']) {
                modelOrder.add(structOrderData(data: i));
              }
              page++;
            }
          }
        });
        log('modelOrder.length: ${modelOrder.length}');
        await onCombineList();
      });

  Future<void> onCombineList() async {
    final List<Created> list = [];
    final splitedMessage =
        messages.splitMatch((element) => (element.readed ?? 0) == 0);
    list.addAll(splitedMessage.matched);
    final List<Created> tale = [];
    tale.addAll(modelOrder);
    tale.addAll(splitedMessage.unmatched);
    tale.sort((a, b) => (b.createdAt?.millisecondsSinceEpoch ?? 0)
        .compareTo(a.createdAt?.millisecondsSinceEpoch ?? 0));
    list.addAll(tale);
    setState(() {
      combinedList = list;
    });
  }

  void onLoadData() {
    loadRequest();
    controllerLoading.loadComplete();
  }

  void updateCallResults() async {
    log('callResults.length: ${callResults.length}');
    callResults = await _localStorageRepository.getAll();
  }

  onPageOrderFermer({required ModelOrder model}) async {
    //model.request = true;
    var data = await Get.toNamed(Routes.orderInfo, arguments: [model.id]);

    if (data != null) {
      model = data as ModelOrder;
    }
    setState(() {});
  }

  onContactOpened(ModelOrder order) {
    modelOrder.firstWhere((element) => element.id == order.id).request = true;
    setState(() {});
  }

  onReadMessage(Message message) async {
    await Api().traider.readMessage(message.id);
    log("read message ${message.id}");
    await onMessages();
    onCombineList();
  }

  void onRefresh() {
    setState(() {
      page = 0;

      modelOrder = [];
    });
    loadRequest();
    controllerLoading.refreshCompleted();
  }

  void onTariffInfo() async {
    try {
      ApiAnswer apiAnswer = await Api().traider.getTariff();
      messHeader = apiAnswer.data['message'];
      tariff = Tariff.fromJson(apiAnswer.data['payload']);
    } catch (e) {
      log(e.toString(), error: e);
    }
  }

  Future<void> onMessages() async {
    try {
      ApiAnswer apiAnswer = await Api().traider.getMessages();
      messages.clear();
      for (final i in apiAnswer.data) {
        messages.add(Message.fromJson(i));
      }
    } catch (e) {
      log(e.toString(), error: e);
    }
  }
}

extension SplitMatch<T> on List<T> {
  ListMatch<T> splitMatch(bool Function(T element) matchFunction) {
    final listMatch = ListMatch<T>();

    for (final element in this) {
      if (matchFunction(element)) {
        listMatch.matched.add(element);
      } else {
        listMatch.unmatched.add(element);
      }
    }

    return listMatch;
  }
}

class ListMatch<T> {
  List<T> matched = <T>[];
  List<T> unmatched = <T>[];
}
