import 'package:agro/ui/theme/colors.dart';
import 'package:agro/ui/theme/fonts.dart';
import 'package:flutter/material.dart';

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton(
      {super.key,
      this.borderColor = AppColors.mainGreen,
      this.textColor = AppColors.mainGreen,
      required this.text,
      this.onTap, 
      this.padding});

  final Color borderColor, textColor;
  final String text;
  final GestureTapCallback? onTap;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: borderColor, width: 1),
                borderRadius: BorderRadius.circular(100)),
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: Text(
              text,
              style: AppFonts.body2bold.withColor(textColor),
            )));
  }
}
