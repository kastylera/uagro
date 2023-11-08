import 'package:agro/ui/text/read_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../ui/buttons/b_style.dart';
import '../../../../ui/text_field/text_field.dart';
import 'order_controller.dart';

class AddPriceScreen extends StatefulWidget {
  const AddPriceScreen({super.key});

  @override
  State<AddPriceScreen> createState() => _AddPriceScreenState();
}

class _AddPriceScreenState extends State<AddPriceScreen> {
  OrderController controller = Get.find();

  @override
  Widget build(BuildContext c) {
    return Material(
      child: Container(
        height: 320 + MediaQuery.of(c).viewInsets.bottom,
        color: Colors.white,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 20),
                child: Container(decoration: BoxDecoration(color: const Color(0xffEDEDED), borderRadius: BorderRadius.circular(3)), height: 10, width: 100)),
            readText(text: 'Додати ціну', color: Colors.black, fontWeight: FontWeight.w600, size: 22, padding: const EdgeInsets.only(bottom: 30)),
            TextFieldWidget(
                padding: const EdgeInsets.all(15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.transparent),
                text: 'Ціна',
                suffixText: '₴',
                openKeyboardAuto: true,
                colorBg: const Color(0xffF8F8F8),
                keyboardType: TextInputType.number,
                controller: controller.priceController,
                sizeText: 30),
            bStyle(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                text: 'Додати ціну',
                size: 23,
                c: c,
                colorText: Colors.white,
                vertical: 15,
                colorButt: const Color(0xffFCD300),
                onPressed: controller.onAddPriceSave)
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
