import 'package:agro/ui/theme/colors.dart';
import 'package:agro/ui/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../ui/buttons/b_transparent_scalable_button.dart';
import '../../ui/text/read_text.dart';
import '../../vars/valid_themes.dart';

class BlockPageScreen extends StatelessWidget {
  final String? header, endIcon;
  final Widget child;
  final Widget? endWidget;
  final bool isBack, isCancel, resizeToAvoidBottomInset;
  final Function()? onPressed, onPressedReturn;
  final EdgeInsetsGeometry? padding, allPadding;
  final double? headerSize;
  final SystemUiOverlayStyle? theme;
  final Color topbarColor, headerColor;
  final Color dividerColor;

  const BlockPageScreen(
      {Key? key,
      this.header,
      this.headerSize,
      this.allPadding,
      required this.child,
      this.onPressed,
      this.theme,
      this.onPressedReturn,
      this.endIcon,
      this.endWidget,
      this.isBack = false,
      this.isCancel = false,
      this.resizeToAvoidBottomInset = false,
      this.padding,
      this.topbarColor = AppColors.white,
      this.headerColor = AppColors.black,
      this.dividerColor = AppColors.grey3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: ValidThemes(
        theme: theme,
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              TopBar(
                  isBack: isBack,
                  endIcon: endIcon,
                  endWidget: endWidget,
                  header: header,
                  padding: padding,
                  onPressed: onPressed,
                  headerColor: headerColor,
                  background: topbarColor,
                  onPressedReturn: onPressedReturn,
                  dividerColor: dividerColor,),
              Expanded(
                  child: Padding(
                      padding: allPadding ??
                          EdgeInsets.only(
                              left: isCancel ? 20 : 15,
                              right: isCancel ? 20 : 15,
                              top: isCancel ? 25 : 0),
                      child: child))
            ],
          ),
        ),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  final Widget? endWidget;
  final bool isBack;
  final String? header, endIcon;
  final EdgeInsetsGeometry? padding;
  final Function()? onPressed, onPressedReturn;
  final Color background, headerColor, dividerColor;

  const TopBar(
      {super.key,
      this.endWidget,
      required this.isBack,
      this.header,
      this.endIcon,
      this.padding,
      this.onPressed,
      this.onPressedReturn,
      this.headerColor = AppColors.black,
      this.background = AppColors.white,
      this.dividerColor = AppColors.grey3});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: background),
      child: Column(children: [
        Row(children: [
          const SizedBox(width: 10),
          if (isBack) ...[
            BTransparentScalableButton(
                onPressed: onPressedReturn ?? () => Navigator.pop(context),
                scale: ScaleFormat.small,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 24,
                  color: headerColor,
                )),
          ] else if (endIcon != null) ...[
            const SizedBox(width: 32)
          ],
          if (header != null) ...[
            Expanded(
                child: Center(
                    child: readText(
                        text: header!,
                        style: AppFonts.body1bold.copyWith(color: headerColor),
                        align: TextAlign.center)))
          ],
          if (endIcon != null) ...[
            BTransparentScalableButton(
                onPressed: onPressed ?? () {},
                scale: ScaleFormat.small,
                child: SvgPicture.asset(
                  endIcon!,
                  width: 32,
                  colorFilter: ColorFilter.mode(headerColor, BlendMode.color),
                )),
          ] else ...[
            if (endWidget != null) ...[
              endWidget!
            ] else if (isBack) ...[
              const SizedBox(width: 18)
            ]
          ],
          const SizedBox(width: 10),
        ]),
        const SizedBox(height: 15),
        Divider(height: 2, color: dividerColor)
      ]),
    );
  }
}
