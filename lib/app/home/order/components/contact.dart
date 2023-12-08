import 'package:agro/model/model_order/model_contact.dart';
import 'package:agro/ui/text/read_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../ui/buttons/b_transparent_scalable_button.dart';

class ContactScreen extends StatelessWidget {
  final ModelContact contact;

  final Function() onLauchPhone;

  const ContactScreen(
      {super.key, required this.contact, required this.onLauchPhone});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          readText(
              text: 'Контакти фермера',
              color: Colors.black,
              fontWeight: FontWeight.w600,
              size: 22,
              padding: const EdgeInsets.only(top: 25, bottom: 30)),
          orderInfo(header: 'ФІО', text: contact.userName.toString()),
          orderInfo(header: 'Регіон', text: contact.userRegion.toString()),
          orderInfo(header: 'Район', text: contact.userDistrict.toString()),
          orderInfo(header: 'Місто', text: contact.userCity.toString()),
          orderInfo(
              header: 'E-mail',
              text: contact.userEmail.toString(),
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
