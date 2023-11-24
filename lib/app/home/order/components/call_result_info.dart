import 'package:agro/ui/text/read_text.dart';
import 'package:agro/ui/theme/colors.dart';
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
                  color: const Color(0xffA9A9A9),
                  size: 20)),
          GestureDetector(
              onTap: onPressed,
              child: Container(
                  decoration: BoxDecoration(
                      color: textColor ?? AppColors.grey,
                      borderRadius: BorderRadius.circular(8)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  )))
        ]));
  }
}
