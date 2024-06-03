import 'package:agro/ui/buttons/outlined_button.dart';
import 'package:agro/ui/text/read_text.dart';
import 'package:agro/ui/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget offerItem(int index, String date, String url) {
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        readText(text: "$index.", style: AppFonts.body1medium.grey3),
        const SizedBox(width: 10),
        Expanded(
            child: readText(text: date, style: AppFonts.body1medium.black)),
        AppOutlinedButton(
            text: "Завантажити",
            onTap: () {
              launchUrl(Uri.parse(url));
            }),
      ]));
}
