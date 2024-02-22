import 'package:agro/app/home/components/block_message.dart';
import 'package:agro/app/home/components/home_header.dart';
import 'package:agro/model/message/created.dart';
import 'package:agro/model/message/message.dart';
import 'package:agro/model/model_user/model_user.dart';
import 'package:agro/ui/theme/colors.dart';
import 'package:agro/ui/theme/fonts.dart';
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
            left: controller.modelUser.isTraider ? 30 : 40,
            right: controller.modelUser.isTraider ? 30 : 0),
        header: controller.modelUser.isTraider ? null : 'Ваші заявки',
        endWidget: controller.modelUser.isTraider
            ? Expanded(
                child: HomeHeader(tariff: controller.tariff, total: controller.total))
            : BTransparentScalableButton(
                onPressed: controller.fermerCreateOrder,
                scale: ScaleFormat.big,
                child:
                    const Icon(Icons.add, color: Color(0xffFCD300), size: 40)),
        theme: SystemUiOverlayStyle.dark,
        child:  Column(
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
                                                    itemBuilder: (_, e) {
                          return Column(
                            children: [
                              for (Created item in controller.combinedList) ...[
                                item is ModelOrder
                                    ? BlockOrder(
                                        modelOrder: item,
                                        answer: controller.callResults
                                            .firstWhereOrNull((element) =>
                                                element.orderId ==
                                                item.id.toString()),
                                        onPressed: controller.onPageOrderFermer)
                                    : item is Message
                                        ? BlockMessage(message: item)
                                        : const SizedBox()
                              ]
                            ],
                          );
                        })))
              ],
            ));
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
