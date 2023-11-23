import 'package:agro/ui/buttons/b_transparent_scalable_button.dart';
import 'package:agro/ui/text/read_text.dart';
import 'package:flutter/material.dart';

class OrderInfo extends StatelessWidget {
  final String header;
  final String text;
  final Color? textColor;
  final Function()? onPressed;

  const OrderInfo(
      {Key? key,
      required this.header,
      required this.text,
      this.onPressed,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        child: BTransparentScalableButton(
            onPressed: onPressed ?? () {},
            scale: onPressed == null ? ScaleFormat.none : ScaleFormat.small,
            child: Row(children: [
              readText(text: header, color: const Color(0xffA9A9A9), size: 20),
              Expanded(
                  child: readText(
                      text: text,
                      color: textColor ?? Colors.black,
                      size: 20,
                      fontWeight: FontWeight.w500,
                      align: TextAlign.end))
            ])));
  }
}
