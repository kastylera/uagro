import 'package:agro/ui/text/read_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';

import '../../../../ui/buttons/b_style.dart';
import '../../../../ui/text_field/text_field.dart';
import 'components/review_controller.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({super.key});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  ReviewController controller = Get.find();

  @override
  Widget build(BuildContext c) {
    return Material(
      child: Container(
        height: 490 + MediaQuery.of(c).viewInsets.bottom,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 20),
                child:
                    Center(child: Container(decoration: BoxDecoration(color: const Color(0xffEDEDED), borderRadius: BorderRadius.circular(3)), height: 10, width: 100))),
            Center(child: readText(text: 'Додати відгук', color: Colors.black, fontWeight: FontWeight.w600, size: 22, padding: const EdgeInsets.only(bottom: 30))),
            Padding(
                padding: const EdgeInsets.only(left: 15),
                child: RatingStars(
                    value: controller.countStar,
                    starBuilder: (index, color) => Icon(Icons.star, color: color, size: 40),
                    starCount: 5,
                    starSize: 40,
                    // valueLabelColor: const Color(0xff9b9b9b),
                    // valueLabelTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 12.0),
                    // valueLabelRadius: 20,
                    maxValue: 5,
                    starSpacing: 0,
                    maxValueVisibility: false,
                    valueLabelVisibility: false,
                    animationDuration: const Duration(seconds: 2),
                    valueLabelPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                    valueLabelMargin: const EdgeInsets.only(right: 8),
                    starOffColor: const Color(0xffe7e8ea),
                    onValueChanged: (val) => controller.onChangeStar(set: setState, val: val),
                    starColor: const Color(0xffFEBF2F))),
            TextFieldWidget(
                height: 200,
                padding: const EdgeInsets.all(15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.transparent),
                text: 'Почніть писати...',
                minLines: 7,
                maxLine: 7,
                openKeyboardAuto: true,
                colorBg: const Color(0xffF8F8F8),
                controller: controller.reviewController,
                sizeText: 20),
            bStyle(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                text: 'Додати відгук',
                size: 23,
                // active: controll,
                c: c,
                colorText: Colors.white,
                vertical: 15,
                colorButt: const Color(0xffFCD300),
                onPressed: controller.onAddReview)
          ],
        ),
      ),
    );
  }

  Widget orderInfo({required String header, required String text}) => Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
      child: Row(children: [
        readText(text: header, color: const Color(0xffA9A9A9), size: 20),
        Expanded(child: readText(text: text, color: Colors.black, size: 20, fontWeight: FontWeight.w500, align: TextAlign.end))
      ]));
}
