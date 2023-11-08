import 'dart:developer';

import 'package:agro/model/model_order/model_order.dart';
import 'package:agro/ui/text/read_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../ui/buttons/b_transparent_scalable_button.dart';

class ContactScreen extends StatelessWidget {
  final ModelOrder modelOrder;

  const ContactScreen({super.key, required this.modelOrder});

  @override
  Widget build(BuildContext c) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Padding(
          //     padding: const EdgeInsets.only(top: 15),
          //     child: Container(
          //         decoration: BoxDecoration(
          //             color: const Color(0xffEDEDED),
          //             borderRadius: BorderRadius.circular(3)),
          //         height: 10,
          //         width: 100)),
          readText(
              text: 'Контакти фермера',
              color: Colors.black,
              fontWeight: FontWeight.w600,
              size: 22,
              padding: const EdgeInsets.only(top: 25, bottom: 30)),
          orderInfo(header: 'ФІО', text: modelOrder.userName.toString()),
          orderInfo(header: 'Регіон', text: modelOrder.userRegion.toString()),
          orderInfo(header: 'Район', text: modelOrder.userDistrict.toString()),
          orderInfo(header: 'Місто', text: modelOrder.userCity.toString()),
          orderInfo(
              header: 'E-mail',
              text: modelOrder.userEmail.toString(),
              onPressed: () => launchUrl(Uri(
                  scheme: 'mailto', path: modelOrder.userEmail.toString()))),
          orderInfo(
              header: 'Телефон',
              text: modelOrder.userPhone.toString(),
              onPressed: () async {
                final phoneNumber = Uri(scheme: 'tel', path: '${modelOrder.userPhone}');
                if (await canLaunchUrl(phoneNumber)) {
                  await launchUrl(phoneNumber,
                      mode: LaunchMode.externalApplication);
                } else {
                  log('Could not launch $phoneNumber');
                }
              }),
          // bStyle(
          //     padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
          //     text: 'Закрити',
          //     size: 23,
          //     c: c,
          //     colorText: Colors.black,
          //     vertical: 15,
          //     colorButt: const Color(0xffF2F2F2),
          //     onPressed: () => Navigator.pop(c))
        ],
      ),
    );
  }

  Widget orderInfo(
          {required String header,
          required String text,
          Function()? onPressed}) =>
      Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
          child: BTransparentScalableButton(
              onPressed: onPressed ?? () {},
              scale: onPressed == null ? ScaleFormat.none : ScaleFormat.small,
              child: Row(children: [
                readText(
                    text: header, color: const Color(0xffA9A9A9), size: 20),
                Expanded(
                    child: readText(
                        text: text,
                        color: Colors.black,
                        size: 20,
                        fontWeight: FontWeight.w500,
                        align: TextAlign.end))
              ])));
}
