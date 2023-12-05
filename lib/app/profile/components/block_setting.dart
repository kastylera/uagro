import 'package:agro/ui/theme/colors.dart';
import 'package:agro/ui/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../ui/buttons/b_transparent_scalable_button.dart';
import '../../../ui/text/read_text.dart';

class BlockSetting extends StatelessWidget {
  final String header, icon;
  final Function() onPressed;
  final bool arrowActive;

  const BlockSetting(
      {Key? key,
      required this.header,
      required this.icon,
      required this.onPressed,
      this.arrowActive = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 15),
            child: BTransparentScalableButton(
              onPressed: onPressed,
              scale: ScaleFormat.small,
              child: Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SvgPicture.asset(
                        icon,
                        width: 32,
                        colorFilter: const ColorFilter.mode(
                            AppColors.additionalGreen, BlendMode.srcIn),
                      )),
                  Expanded(
                      child: readText(
                    text: header,
                    style: AppFonts.body1medium.black,
                    padding: const EdgeInsets.only(left: 20),
                  ))
                ],
              ),
            ),
          ),
          if (arrowActive) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                  color: AppColors.grey3,
                  width: MediaQuery.of(context).size.width,
                  height: 1),
            )
          ]
        ],
      ),
    );
  }
}
