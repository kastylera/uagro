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
        padding: EdgeInsets.only(
            left: controller.modelUser.role == 'distrib' ? 0 : 40),
        header: controller.modelUser.role == 'distrib'
            ? controller.messHeader
            : 'Ваші заявки',
        endWidget: controller.modelUser.role == 'distrib'
            ? const SizedBox()
            : BTransparentScalableButton(
                onPressed: controller.fermerCreateOrder,
                scale: ScaleFormat.big,
                child:
                    const Icon(Icons.add, color: Color(0xffFCD300), size: 40)),
        theme: SystemUiOverlayStyle.dark,
        child: Column(
          children: [
            TextFieldWidget(
                padding: const EdgeInsets.only(top: 15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.transparent),
                text: 'Пошук',
                openKeyboardAuto: true,
                colorBg: const Color(0xffF8F8F8),
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
                        waterDropColor: Color(0xff01CA20)),
                    child: ListView.separated(
                        physics: const ClampingScrollPhysics(),
                        itemCount: 1,
                        separatorBuilder: (c, i) {
                          return Container();
                        },
                        itemBuilder: (_, e) => Column(
                              children: [
                                for (ModelOrder i in controller.modelOrder) ...[
                                  BlockOrder(
                                      modelOrder: i,
                                      answer: controller.callResults
                                          .firstWhereOrNull((element) =>
                                              element.orderId ==
                                              i.id.toString()),
                                      onPressed: controller.onPageOrderFermer)
                                ]
                              ],
                            ))))
          ],
        ));
  }
}
