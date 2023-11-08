import 'package:agro/app/home/review/components/block_review.dart';
import 'package:agro/app/home/review/components/review_controller.dart';
import 'package:agro/ui/buttons/b_transparent_scalable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../model/model_review/model_review.dart';
import '../../components/block_page_screen.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {

  ReviewController controller = Get.find();
  @override
  void initState() {
    controller.initPage(context: context, set: setState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlockPageScreen(
        header: 'Відгуки',
        isBack: true,
        endWidget: BTransparentScalableButton(onPressed: controller.onAddReviewPage, scale: ScaleFormat.big, child: const Icon(Icons.add, color: Color(0xffFCD300), size: 40)),
        theme: SystemUiOverlayStyle.dark,
        child: Column(
          children: [

            for(final ModelReview i in controller.modelReview)...[

              BlockReview(modelReview: i)

            ]
            // TextFieldWidget(
            //     padding: const EdgeInsets.only(top: 15),
            //     borderRadius: BorderRadius.circular(10),
            //     border: Border.all(color: Colors.transparent),
            //     text: 'Пошук',
            //     openKeyboardAuto: true,
            //     colorBg: const Color(0xffF8F8F8),
            //     controller: controller.searchController,
            //     onChanged: (_) => controller.onSearch()),
            // Expanded(
            //     child: SmartRefresher(
            //         controller: controller.controllerLoading,
            //         scrollController: controller.controllerScroll,
            //         enablePullUp: true,
            //         enablePullDown: false,
            //         onLoading: controller.onLoadData,
            //         footer: const FooterLoad(),
            //         header: const WaterDropHeader(waterDropColor: Color(0xffFF7D5C)),
            //         child: ListView.separated(
            //             physics: const ClampingScrollPhysics(),
            //             itemCount: 1,
            //             separatorBuilder: (c, i) {
            //               return Container();
            //             },
            //             itemBuilder: (_, e) => Column(
            //                   children: [
            //                     for (ModelOrder i in controller.modelOrder) ...[BlockOrder(modelOrder: i, onPressed: controller.onPageOrderFermer)]
            //                   ],
            //                 ))))
          ],
        ));
  }
}
