import 'package:agro/ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../generated/assets.dart';
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
      this.padding})
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
          child: Padding(
            padding: allPadding ??
                EdgeInsets.only(
                    left: isCancel ? 20 : 15,
                    right: isCancel ? 20 : 15,
                    top: isCancel ? 25 : 0),
            child: Column(
              children: [
                Padding(
                  padding: padding ?? EdgeInsets.zero,
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: const Color(0xff000000).withOpacity(0.01),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: const Offset(0, 30))
                    ]),
                    child: Row(children: [
                      if (isBack) ...[
                        BTransparentScalableButton(
                            onPressed:
                                onPressedReturn ?? () => Navigator.pop(context),
                            scale: ScaleFormat.small,
                            child: SvgPicture.asset(
                              Assets.componentsBack,
                              width: 18,
                              colorFilter: const ColorFilter.mode(
                                  Colors.black, BlendMode.srcIn),
                            )),
                      ] else if (endIcon != null || isCancel) ...[
                        const SizedBox(width: 32)
                      ],
                      if (header != null) ...[
                        Expanded(
                            child: Center(
                                child: readText(
                                    text: header!,
                                    size: headerSize ?? 24,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    align: TextAlign.center)))
                      ],
                      if (endIcon != null) ...[
                        BTransparentScalableButton(
                            onPressed: onPressed ?? () {},
                            scale: ScaleFormat.small,
                            child: SvgPicture.asset(endIcon!, width: 32)),
                      ] else ...[
                        if (endWidget != null) ...[
                          endWidget!
                        ] else if (isBack) ...[
                          const SizedBox(width: 18)
                        ] else if (isCancel) ...[
                          // BTransparentScalableButton(
                          //     onPressed: () => Navigator.pop(c), scale: ScaleFormat.small, child: SvgPicture.asset(Assets.componentsCancel, width: 32)),
                        ]
                      ]
                    ]),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        color: AppColors.grey3)),
                Expanded(child: child)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
