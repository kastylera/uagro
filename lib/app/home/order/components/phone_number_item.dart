import 'package:agro/ui/buttons/b_transparent_scalable_button.dart';
import 'package:agro/ui/buttons/outlined_button.dart';
import 'package:agro/ui/local_notification/local_notification.dart';
import 'package:agro/ui/text/read_text.dart';
import 'package:agro/ui/theme/colors.dart';
import 'package:agro/ui/theme/fonts.dart';
import 'package:flutter/material.dart';

class PhoneNumberItem extends StatefulWidget {
  final int index;
  final String date, number;
  final Function() onPhoneClick;
  final bool canOpenPhone;

  const PhoneNumberItem(
      {super.key,
      required this.index,
      required this.date,
      required this.number,
      required this.onPhoneClick,
      required this.canOpenPhone});

  @override
  State<PhoneNumberItem> createState() {
    return PhoneNumberItemState();
  }
}

class PhoneNumberItemState extends State<PhoneNumberItem> {
  bool phoneOpen = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(children: [
          readText(text: "${widget.index}", style: AppFonts.body1medium.grey3),
          const SizedBox(width: 10),
          Expanded(
              child: readText(
                  text: widget.date, style: AppFonts.body1medium.black)),
          widget.number.isNotEmpty
              ? BTransparentScalableButton(
                  onPressed: () {
                    if (widget.number != "Не вказано") {
                      widget.onPhoneClick();
                    }
                  },
                  scale: ScaleFormat.small,
                  child: readText(
                      text: widget.number,
                      style: AppFonts.body1medium.additionalGreen))
              : AppOutlinedButton(
                  text: phoneOpen ? widget.number : "Телефон",
                  onTap: () {
                    setState(() {
                      if (widget.canOpenPhone) {
                        phoneOpen = true;
                      } else {
                        notification(
                            text:
                                "Ця можливість для платних користувачів. Деталі в телеграм t.me/uagro_oper");
                      }
                    });
                  },
                  borderColor: AppColors.additionalGreen,
                  textColor: AppColors.additionalGreen,
                ),
        ]));

  }
}
