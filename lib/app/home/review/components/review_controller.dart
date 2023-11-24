import 'dart:developer';

import 'package:agro/model/model_review/struct_review.dart';
import 'package:agro/model/model_user/model_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:agro/model/model_order/model_order.dart';
import 'package:agro/server/api/api.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../../controllers/abstract/from_controller.dart';
import '../../../../controllers/app_input_controller.dart';
import '../../../../model/model_review/model_review.dart';
import '../../../../ui/local_notification/local_notification.dart';
import '../../../../vars/model_notifier/user_notifier/user_notifier.dart';
import '../add_review.dart';

class ReviewController extends FormController {
  late Function(VoidCallback fn) setState;
  late BuildContext c;
  late ModelOrder modelOrder;
  late ModelUser modelUser;
  bool loadPage = false;
  late TextEditingController reviewController;
  double countStar = 5;
  List<ModelReview> modelReview = [];

  @override
  void onInit() {
    reviewController = AppInputController();
    super.onInit();
  }

  void initPage({required BuildContext context, required Function(VoidCallback fn) set}) async {
    c = context;
    setState = set;
    modelUser = c.read<UserNotifier>().modelUser;

    await Future.delayed(const Duration(milliseconds: 100));
    if (c.mounted) {
      modelOrder = ModalRoute.of(c)!.settings.arguments as ModelOrder;
      await Future.delayed(const Duration(milliseconds: 100));
      // onLoadInfoUser();
      modelReview = [];
      onLoadReview();

      setState(() => loadPage = true);
    }
  }

  void onLoadReview() async => loadIfValid(() async {
        ApiAnswer apiAnswer = await Api().fermer.viewReview(orderId: modelOrder.id!);

        for (final i in apiAnswer.data['payload']['items']) {
          modelReview.add(structReview(data: i));
        }
        setState(() {});
      }, c: c);

  void onAddReviewPage() => showCupertinoModalBottomSheet(topRadius: const Radius.circular(30), context: c, builder: (c) => const AddReviewScreen());

  void onAddReview() => loadIfValid(() async {
        if (reviewController.text == '') {
          inAppNotification(text: 'Потрібно написати відгук', c: c);
        }

        ApiAnswer apiAnswer = await Api().fermer.sendReviewFermer(orderId: modelOrder.id!, rating: countStar.round(), comment: reviewController.text);

        log(modelOrder.id.toString());
        log(apiAnswer.data.toString());

        if (apiAnswer.data['status'].toString() == 'true') {
          if (c.mounted) {
            Navigator.pop(c);
            inAppNotification(text: 'Відгук додано', c: c);
            reviewController.text = '';
            countStar = 5;
            modelReview = [];
            onLoadReview();
          }
        } else {
          if (c.mounted) {
            inAppNotification(text: 'Трапилась помилка при додаванні відгуку, перевірте ваші дані', c: c);
          }
        }
      }, c: c);

  void onChangeStar({required double val, required Function(VoidCallback fn) set}) => set(() => countStar = val);

// void onSell() => loadIfValid(() async {
//       ApiAnswer apiAnswer = await Api().fermer.closePriceOrder(c: c, orderId: modelOrder.id!);
//       print(apiAnswer.data);
//
//       if (apiAnswer.data['status'].toString() == 'true') {
//         setState(() => modelOrder.endDate = DateTime.now().subtract(const Duration(days: 1)));
//       }
//     }, c: c);
//
// void onReview() {}
//
// void onLoadPrice() => loadIfValid(() async {
//       // ApiAnswer apiAnswer = await Api().fermer.getInfoPriceOrder(c: c, orderId: modelOrder.id!);
//       ApiAnswer apiAnswer = await Api().fermer.getInfoPriceOrder(c: c, orderId: 99384);
//       totalPrice = apiAnswer.data['payload']['total'];
//
//       for (final i in apiAnswer.data['payload']['prices']) {
//         modelOrderPrice.add(structOrderData(data: i));
//       }
//
//       setState(() {});
//     }, c: c);
//
// void onAddPrice() => showCupertinoModalBottomSheet(topRadius: const Radius.circular(30), context: c, builder: (c) => const AddPriceScreen());
//
// void onLoadInfoUser() async {
//   ApiAnswer apiAnswer = await Api().traider.orderOpenContactFermer(c: c, orderId: modelOrder.id!);
//
//   modelOrder.userName = apiAnswer.data['payload']['name'];
//   modelOrder.userRegion = apiAnswer.data['payload']['region'];
//   modelOrder.userDistrict = apiAnswer.data['payload']['district'];
//   modelOrder.userCity = apiAnswer.data['payload']['city'];
//   modelOrder.userEmail = apiAnswer.data['payload']['email'];
//   modelOrder.userPhone = apiAnswer.data['payload']['phone'];
//
//   setState(() {});
// }
//
// void onBack() => Navigator.pop(c, modelOrder);
//
// void onContact() => showCupertinoModalBottomSheet(topRadius: const Radius.circular(30), context: c, builder: (c) => ContactScreen(modelOrder: modelOrder));
//
// void onAddPriceSave() {}
}
