import 'package:agro/ui/text/read_text.dart';
import 'package:agro/ui/views/bottom_drawer_header.dart';
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
  Currency currency = Currency.uah;
  PaymentForm paymentForm = PaymentForm.f1;

  final List<DropdownMenuItem<Currency>> currencies = Currency.values
      .map((e) => DropdownMenuItem(
          value: e,
          child: readText(
            text: e.text,
            size: 30,
            fontWeight: FontWeight.w500,
          )))
      .toList();

  final List<DropdownMenuItem<PaymentForm>> paymentForms = PaymentForm.values
      .map((e) => DropdownMenuItem(
          value: e,
          child: readText(
            text: e.label,
            size: 30,
            fontWeight: FontWeight.w500,
          )))
      .toList();

  @override
  Widget build(BuildContext c) {
    return Material(
      child: Container(
        height: 500 + MediaQuery.of(c).viewInsets.bottom,
        color: Colors.white,
        child: Column(
          children: [
            const BottomDrawerHeader(),
            readText(
                text: 'Додати ціну',
                color: Colors.black,
                fontWeight: FontWeight.w600,
                size: 22,
                padding: const EdgeInsets.only(bottom: 30)),
            TextFieldWidget(
                padding: const EdgeInsets.all(15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.transparent),
                text: 'Ціна',
                suffixText: currency.label,
                openKeyboardAuto: true,
                colorBg: const Color(0xffF8F8F8),
                keyboardType: TextInputType.number,
                controller: controller.priceController,
                sizeText: 30),
            Container(
                width: MediaQuery.of(context).size.width - 32,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: const Color(0xffF8F8F8),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton<Currency>(
                  hint: readText(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      text: currency.text,
                      fontWeight: FontWeight.w500,
                      size: 30,
                      color: Colors.black),
                  isDense: false,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded,
                      size: 40, color: Colors.black),
                  style: const TextStyle(color: Colors.black),
                  menuMaxHeight: 300,
                  items: currencies,
                  onChanged: (value) {
                    setState(() {
                      currency = value!;
                    });
                  },
                ))),
            const SizedBox(height: 15),
            Container(
                width: MediaQuery.of(context).size.width - 32,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: const Color(0xffF8F8F8),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton<PaymentForm>(
                  hint: readText(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      text: paymentForm.label,
                      fontWeight: FontWeight.w500,
                      size: 30,
                      color: Colors.black),
                  isDense: false,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded,
                      size: 40, color: Colors.black),
                  style: const TextStyle(color: Colors.black),
                  menuMaxHeight: 300,
                  items: paymentForms,
                  onChanged: (value) {
                    setState(() {
                      paymentForm = value!;
                    });
                  },
                ))),
            bStyle(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                text: 'Додати ціну',
                size: 23,
                c: c,
                colorText: Colors.white,
                vertical: 15,
                colorButt: const Color(0xffFCD300),
                onPressed: () => controller.onAddPriceSave(
                    currency.json, paymentForm.json))
          ],
        ),
      ),
    );
  }

  Widget orderInfo({required String header, required String text}) => Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
      child: Row(children: [
        readText(text: header, color: const Color(0xffA9A9A9), size: 20),
        Expanded(
            child: readText(
                text: text,
                color: Colors.black,
                size: 20,
                fontWeight: FontWeight.w500,
                align: TextAlign.end))
      ]));
}

enum Currency {
  uah("₴", "Гривня", "UAH"),
  usd("\$", "Долар", "USD"),
  euro("€", "Євро", "EUR");
  final String label;
  final String description;
  final String json;

  String get text => "$description ($label)";

  const Currency(this.label, this.description, this.json);
}

enum PaymentForm {
  f1("1ф. (по перерахунку)", '1f'),
  f2("2ф. (готівка)", '2f');

  final String label;
  final String json;

  const PaymentForm(this.label, this.json);
}
