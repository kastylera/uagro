import 'package:agro/model/model_user/model_user.dart';
import 'package:agro/ui/text/read_text.dart';
import 'package:agro/ui/theme/colors.dart';
import 'package:agro/ui/theme/fonts.dart';
import 'package:agro/ui/utils/date_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:agro/app/components/block_page_screen.dart';
import 'package:agro/app/home/components/block_order.dart';
import 'package:agro/model/model_order/model_order.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../ui/buttons/b_transparent_scalable_button.dart';
import '../../ui/footer_load.dart';
import '../../ui/text_field/text_field.dart';
import 'components/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.find();

  @override
  void initState() {
    controller.initPage(context: context, set: setState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlockPageScreen(
        headerSize: 21,
        allPadding: const EdgeInsets.all(0),
        padding: EdgeInsets.only(
            left: controller.modelUser.isTraider ? 30 : 40,
            right: controller.modelUser.isTraider ? 30 : 0),
        header: controller.modelUser.role == 'distrib' ? null : 'Ваші заявки',
        endWidget: controller.modelUser.role == 'distrib'
            ? Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    headerItem((controller.total).toString(), "Заявок"),
                    headerItem(
                        (controller.tariff?.balanceContactsDayOsttk ?? 0)
                            .toString(),
                        "Котактів"),
                    headerItem(
                        (controller.tariff?.balanceSms ?? 0).toString(), "SMS"),
                    headerItem(
                        controller.tariff?.balanceEnd?.formatDateShort() ?? '',
                        "Термін дії тарифу")
                  ]))
            : BTransparentScalableButton(
                onPressed: controller.fermerCreateOrder,
                scale: ScaleFormat.big,
                child:
                    const Icon(Icons.add, color: Color(0xffFCD300), size: 40)),
        theme: SystemUiOverlayStyle.dark,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                TextFieldWidget(
                    padding: const EdgeInsets.only(top: 12),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppColors.grey2),
                    text: 'Пошук',
                    height: 60,
                    textStyle: AppFonts.body1medium.black,
                    hintStyle: AppFonts.body1medium.grey3,
                    openKeyboardAuto: true,
                    colorBg: AppColors.grey1,
                    controller: controller.searchController,
                    onChanged: (_) => controller.onSearch()),
                Expanded(
                    child: SmartRefresher(
                        controller: controller.controllerLoading,
                        scrollController: controller.controllerScroll,
                        enablePullUp: true,
                        enablePullDown: true,
                        onLoading: controller.onLoadData,
                        onRefresh: controller.onRefresh,
                        footer: const FooterLoad(),
                        header: const WaterDropHeader(
                            complete: CompleteWidget(),
                            waterDropColor: AppColors.mainGreen),
                        child: ListView.separated(
                            physics: const ClampingScrollPhysics(),
                            itemCount: 1,
                            separatorBuilder: (c, i) {
                              return Container();
                            },
                            itemBuilder: (_, e) => Column(
                                  children: [
                                    for (ModelOrder i
                                        in controller.modelOrder) ...[
                                      BlockOrder(
                                          modelOrder: i,
                                          answer: controller.callResults
                                              .firstWhereOrNull((element) =>
                                                  element.orderId ==
                                                  i.id.toString()),
                                          onPressed:
                                              controller.onPageOrderFermer)
                                    ]
                                  ],
                                ))))
              ],
            )));
  }

  Widget headerItem(String value, String description) {
    return Column(children: [
      readText(text: value, style: AppFonts.body1bold.mainGreen),
      readText(text: description, style: AppFonts.caption.darkGreen)
    ]);
  }
}

class CompleteWidget extends StatelessWidget {
  const CompleteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(
          Icons.done,
          color: Colors.grey,
        ),
        Container(
          width: 15.0,
        ),
        const Text(
          "Оновлення завершено",
          style: TextStyle(color: Colors.grey),
        )
      ],
    );
  }
}
