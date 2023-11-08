import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../ui/buttons/b_transparent_scalable_button.dart';
import '../../../ui/text/read_text.dart';

class BlockSetting extends StatelessWidget {
  final String header, icon;
  final Function() onPressed;
  final bool arrowActive;

  const BlockSetting({Key? key, required this.header, required this.icon, required this.onPressed, this.arrowActive = true}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
            child: BTransparentScalableButton(
              onPressed: onPressed,
              scale: ScaleFormat.small,
              child: Row(
                children: [
                  SvgPicture.asset(icon, width: 32, color: const Color(0xff7A7B7D)),
                  Expanded(child: readText(text: header, color: Colors.black, fontWeight: FontWeight.w400, padding: const EdgeInsets.only(left: 20), size: 21))
                ],
              ),
            ),
          ),
          if (arrowActive) ...[Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(color: const Color(0xffDDC3F9), width: MediaQuery.of(c).size.width, height: 1),
          )]
        ],
      ),
    );
  }
}
