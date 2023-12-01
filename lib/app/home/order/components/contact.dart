import 'package:agro/model/model_order/model_order.dart';
import 'package:agro/ui/text/read_text.dart';
import 'package:agro/ui/theme/fonts.dart';
import 'package:agro/ui/utils/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../ui/buttons/b_transparent_scalable_button.dart';

class ContactScreen extends StatelessWidget {
  final ModelOrder modelOrder;

  final Function() onLauchPhone;

  const ContactScreen(
      {super.key, required this.modelOrder, required this.onLauchPhone});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          readText(
              text: 'Контакти фермера',
              style: AppFonts.title2.black,
              padding: const EdgeInsets.only(top: 20, bottom: 10)),
          orderInfo(header: 'ФІО', text: modelOrder.userName.toString()),
          orderInfo(header: 'Регіон', text: modelOrder.userRegion.toString()),
          orderInfo(header: 'Район', text: modelOrder.userDistrict.toString()),
          orderInfo(header: 'Місто', text: modelOrder.userCity.orNotSet()),
          orderInfo(
              header: 'E-mail',
              text: modelOrder.userEmail.orNotSet(),
              onPressed: () => launchUrl(Uri(
                  scheme: 'mailto', path: modelOrder.userEmail.toString()))),
          orderInfo(
              header: 'Телефон',
              text: modelOrder.userPhone.toString(),
              onPressed: onLauchPhone)
        ],
      ),
    );
  }

  Widget orderInfo(
          {required String header,
          required String text,
          Function()? onPressed}) =>
      Padding(
          padding: const EdgeInsets.only(bottom: 6),
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
