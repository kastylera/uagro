import 'dart:developer';

import 'package:agro/model/model_user/model_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:agro/model/model_order/struct_order.dart';
import 'package:agro/routes/app_pages.dart';
import 'package:agro/server/api/api.dart';
import 'package:hive/hive.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../controllers/abstract/from_controller.dart';
import '../../../controllers/app_input_controller.dart';
import '../../../model/model_order/model_order.dart';
import '../../../ui/local_notification/local_notification.dart';

class HomeController extends FormController {
  late Function(VoidCallback fn) setState;
  late BuildContext c;
  late TextEditingController searchController;
  late ModelUser modelUser;
  late final RefreshController controllerLoading;
  late final ScrollController controllerScroll;
  String messHeader = 'Заявки';

  int page = 1;
  List<ModelOrder> modelOrder = [];

  @override
  void onInit() {
    searchController = AppInputController();
    controllerLoading = RefreshController();
    controllerScroll = ScrollController();
    super.onInit();
  }

  void initPage({required BuildContext context, required Function(VoidCallback fn) set}) async {
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
        ApiAnswer apiAnswer = await Api().fermer.createOrder(c: c);

        if (c.mounted) {
          if (apiAnswer.data['status']) {
            inAppNotification(text: 'Заявка відправлена. Скоро з вами зв’яжеться оператор.', c: c, seconds: 5);
          } else {
            inAppNotification(text: apiAnswer.data['message'], c: c);
            // setState(() => errorCode = apiAnswer.data['message']);
          }
        }
      }, c: c);

  void onSearch() {
    page = 1;
    modelOrder = [];
    loadRequest();
  }

  void loadRequest() => loadIfValid(() async {
        late ApiAnswer apiAnswer;

        if (modelUser.role == 'distrib') {
          apiAnswer = await Api().traider.getOrderList(c: c, page: page, limit: 15, search: searchController.text);
        } else {
          apiAnswer = await Api().fermer.getOrderList(c: c, page: page, limit: 15, search: searchController.text);
        }

        log(apiAnswer.data.toString());

        setState(() {
          if (c.mounted) {
            if (apiAnswer.data['status']) {
              for (final i in apiAnswer.data['payload']['items']) {
                modelOrder.add(structOrderData(data: i));
              }
              page++;
            }
          }
        });
        log('modelOrder.length: ${modelOrder.length}');
      }, c: c);

  void onLoadData() {
    loadRequest();
    controllerLoading.loadComplete();
  }

  onPageOrderFermer({required ModelOrder model}) async {
    model.request = true;
    var data = await Get.toNamed(Routes.orderInfo, arguments: model);

    if (data != null) {
      model = data as ModelOrder;
    }
    setState(() {});
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
      ApiAnswer apiAnswer = await Api().traider.getTariff(c: c);
      messHeader = apiAnswer.data['message'];
    } catch (_) {}
  }
}
