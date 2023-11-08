import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../text/read_text.dart';

class TextFieldWidget extends StatefulWidget {
  final String? icon, error, iconClear, leftIcon, text, labelText, endText, header, prefixText, suffixText;
  final TextEditingController controller;
  final bool passActive, errorActive, enable, openKeyboardAuto, isGreenColor, isBorder;
  final Function(String)? onChanged, onSubmitted;
  final Function()? onEditingComplete;
  final EdgeInsetsGeometry? padding;
  final TextInputType? keyboardType;
  final Color? colorBg, colorText, colorIcon, colorEndText, headerColor;
  final BoxBorder? border;
  final EdgeInsetsGeometry? paddingTextField;
  final TextStyle? textStyle, hintStyle;
  final int? maxLine, minLines, maxLength;
  final double? height, iconSize, sizeText;
  final BorderRadiusGeometry? borderRadius;
  final TextCapitalization? textCapitalization;
  final FontWeight? fontWeightHeader;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;

  const TextFieldWidget(
      {Key? key,
      this.icon,
      this.endText,
      this.headerColor,
      this.colorIcon,
      this.focusNode,
      this.header,
      this.fontWeightHeader,
      this.onSubmitted,
      this.sizeText,
      this.prefixText,
      this.suffixText,
      this.errorActive = false,
      this.isGreenColor = false,
      this.isBorder = true,
      this.iconSize,
      this.onEditingComplete,
      this.hintStyle,
      this.colorEndText,
      this.leftIcon,
      this.openKeyboardAuto = false,
      this.text,
      required this.controller,
      this.passActive = false,
      this.enable = true,
      this.error,
      this.onChanged,
      this.maxLength,
      this.padding,
      this.keyboardType,
      this.iconClear,
      this.colorBg,
      this.border,
      this.paddingTextField,
      this.colorText,
      this.textStyle,
      this.maxLine,
      this.height,
      this.minLines,
      this.borderRadius,
      this.labelText,
      this.inputFormatters,
      this.textCapitalization})
      : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldState();
}

class _TextFieldState extends State<TextFieldWidget> {
  late bool passActiveView;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    if (widget.focusNode != null) {
      focusNode = widget.focusNode!;
    }

    focusNode.addListener(() {
      try {
        setState(() {});
      } catch (_) {}
    });

    passActiveView = widget.passActive;
    super.initState();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      focusNode.dispose();
    }
    super.dispose();
  }

  bool get isTextFieldActive => focusNode.hasFocus;

  @override
  Widget build(BuildContext c) {
    return Padding(
        padding: widget.padding ?? const EdgeInsets.only(top: 30, left: 30, right: 30),
        child: StatefulBuilder(builder: (BuildContext context, StateSetter set) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.header != null) ...[
                readText(
                    text: widget.header!,
                    size: 22,
                    fontWeight: widget.fontWeightHeader ?? FontWeight.w500,
                    color: widget.headerColor ?? Colors.black,
                    padding: const EdgeInsets.only(bottom: 10))
              ],
              Container(
                decoration: BoxDecoration(
                  color: widget.colorBg ?? (widget.isGreenColor && widget.error == null ? Colors.black : Colors.transparent),
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(40),
                  border: !widget.isBorder ? null : widget.border ?? Border.all(color: const Color(0xff5851A8)),
                ),
                height: widget.height ?? 70,
                child: Row(
                  children: [
                    if (widget.leftIcon != null) ...[Padding(padding: const EdgeInsets.only(left: 15), child: SvgPicture.asset(widget.leftIcon!, width: 30))],
                    Expanded(
                        child: Padding(
                      padding: widget.paddingTextField ?? EdgeInsets.only(left: widget.leftIcon != null ? 15 : 25),
                      child: FocusScope(
                          onFocusChange: (value) {
                            if (!value && widget.onEditingComplete != null) {
                              widget.onEditingComplete!();
                            }
                          },
                          child: TextField(
                              // autofocus: true,
                              // textInputAction: TextInputAction.done,
                              inputFormatters: widget.inputFormatters ?? [if (widget.maxLength != null) LengthLimitingTextInputFormatter(widget.maxLength)],
                              focusNode: focusNode,
                              enabled: widget.enable,
                              textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
                              onSubmitted: widget.onSubmitted,
                              maxLines: widget.maxLine ?? 1,
                              minLines: widget.minLines ?? 1,
                              keyboardType: widget.keyboardType,
                              onChanged: widget.onChanged,
                              controller: widget.controller,
                              obscureText: passActiveView,
                              decoration: InputDecoration(
                                  prefix: widget.prefixText == null
                                      ? null
                                      : readText(
                                          text: widget.prefixText!, fontWeight: FontWeight.w500, size: widget.sizeText ?? 20, color: widget.colorText ?? Colors.black),
                                  suffix: widget.suffixText == null
                                      ? null
                                      : readText(
                                          text: widget.suffixText!, fontWeight: FontWeight.w500, size: widget.sizeText ?? 20, color: widget.colorText ?? Colors.black),
                                  labelText: widget.labelText,
                                  border: InputBorder.none,
                                  hintText: widget.text,
                                  labelStyle:
                                      TextStyle(fontWeight: FontWeight.w500, fontSize: widget.sizeText ?? 20, color: widget.headerColor ?? const Color(0xffCDCDCD)),
                                  hintStyle:
                                      TextStyle(color: widget.headerColor ?? const Color(0xffCDCDCD), fontSize: widget.sizeText ?? 20, fontWeight: FontWeight.w500)),
                              style:
                                  widget.textStyle ?? TextStyle(fontWeight: FontWeight.w500, fontSize: widget.sizeText ?? 20, color: widget.colorText ?? Colors.black))),
                    )),
                    if (widget.passActive) ...[
                      // BTransparentScalableButton(
                      //     onPressed: () => set(() => passActiveView = !passActiveView),
                      //     scale: ScaleFormat.big,
                      //     child: SvgPicture.asset(Assets.componentsPass,
                      //         width: 30, color: !passActiveView ? const Color(0xffA0A8C4) : const Color(0xffE7E4ED)))
                    ] else if (widget.icon != null) ...[
                      SvgPicture.asset(widget.icon!, width: widget.iconSize ?? 30, color: widget.colorIcon ?? const Color(0xffCDCDCD))
                    ] else if (widget.endText != null) ...[
                      readText(
                          text: widget.endText!,
                          color: widget.colorEndText ?? Colors.black,
                          fontWeight: FontWeight.w600,
                          size: widget.sizeText ?? 20,
                          padding: const EdgeInsets.only(left: 15))
                    ],
                    const SizedBox(width: 15)
                  ],
                ),
              ),
              if (widget.error != null) ...[
                SizedBox(
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Center(child: readText(text: widget.error!, color: const Color(0xffEB5858), fontWeight: FontWeight.w600, size: 18, align: TextAlign.center)),
                    ))
              ]
            ],
          );
        }));
  }
}
