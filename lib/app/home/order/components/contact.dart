import 'package:agro/model/model_order/model_contact.dart';
import 'package:agro/ui/text/read_text.dart';
import 'package:agro/ui/theme/fonts.dart';
import 'package:agro/ui/utils/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../ui/buttons/b_transparent_scalable_button.dart';

class ContactScreen extends StatelessWidget {
  final ModelContact contact;
  final bool isVip;

  final Function() onLauchPhone;

  const ContactScreen(
      {super.key, required this.contact, required this.onLauchPhone, this.isVip = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
         !isVip ?
          readText(
              text: 'Контакти фермера',
              style: AppFonts.title2.black,
              padding: const EdgeInsets.only(top: 20, bottom: 10)) : const SizedBox(height: 6),
          orderInfo(header: 'ПІБ', text: contact.userName.toString()),
          orderInfo(header: 'Регіон', text: contact.userRegion.toString()),
          orderInfo(header: 'Район', text: contact.userDistrict.toString()),
          orderInfo(header: 'Місто', text: contact.userCity.orNotSet()),
          orderInfo(
              header: 'E-mail',
              text: contact.userEmail.orNotSet(),
              onPressed: () => launchUrl(
                  Uri(scheme: 'mailto', path: contact.userEmail.toString()))),
          orderInfo(
              header: 'Телефон',
              text: contact.userPhone.toString(),
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
