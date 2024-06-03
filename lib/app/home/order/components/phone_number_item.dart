import 'package:agro/ui/buttons/b_transparent_scalable_button.dart';
import 'package:agro/ui/buttons/outlined_button.dart';
import 'package:agro/ui/text/read_text.dart';
import 'package:agro/ui/theme/colors.dart';
import 'package:agro/ui/theme/fonts.dart';
import 'package:flutter/material.dart';

Widget phoneNumberItem(
    {required int index,
    required String date,
    required String number,
    required Function() onPhoneClick,
    required Function() onPhoneOpen}) {
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        readText(text: "$index.", style: AppFonts.body1medium.grey3),
        const SizedBox(width: 10),
        Expanded(
            child: readText(text: date, style: AppFonts.body1medium.black)),
        number.isNotEmpty
            ? BTransparentScalableButton(
                onPressed: () {
                  onPhoneClick();
                },
                scale: ScaleFormat.small,
                child: readText(
                    text: number, style: AppFonts.body1medium.additionalGreen))
            : AppOutlinedButton(
                text: "Телефон",
                onTap: onPhoneOpen,
                borderColor: AppColors.additionalGreen,
                textColor: AppColors.additionalGreen,
              ),
      ]));
}
