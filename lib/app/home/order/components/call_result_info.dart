import 'package:agro/ui/text/read_text.dart';
import 'package:agro/ui/theme/colors.dart';
import 'package:agro/ui/theme/fonts.dart';
import 'package:flutter/material.dart';

class CallResultInfo extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Function() onPressed;
  final double horizontalPadding;

  const CallResultInfo(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.textColor,
      this.horizontalPadding = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            bottom: 10, left: horizontalPadding, right: horizontalPadding),
        child: Row(children: [
          Expanded(
              child: readText(
                  text: "Результат дзвінка",
                  style: AppFonts.body1medium.grey3)),
          GestureDetector(
              onTap: onPressed,
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: textColor ?? AppColors.grey4, width: 1),
                      borderRadius: BorderRadius.circular(100)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  child: Text(
                    text,
                    style: AppFonts.body2bold.withColor(textColor ?? AppColors.grey4),
                  )))
        ]));
  }
}
