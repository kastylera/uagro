import 'package:agro/ui/text/read_text.dart';
import 'package:agro/ui/theme/fonts.dart';
import 'package:flutter/material.dart';

Widget orderInfo({required String header, required String text}) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(children: [
      readText(text: header, style: AppFonts.body1medium.grey3),
      Expanded(
          child: readText(
              text: text,
              style: AppFonts.body1medium.black,
              align: TextAlign.end))
    ]));
