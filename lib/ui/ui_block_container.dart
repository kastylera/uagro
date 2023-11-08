import 'package:flutter/material.dart';

class UiBlockContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? colorBg;
  final double? height;

  const UiBlockContainer({Key? key, required this.child, this.padding, this.colorBg, this.height}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return Padding(
        padding: padding ?? const EdgeInsets.only(left: 10, right: 10, top: 20),
        child: Container(
            width: MediaQuery.of(c).size.width,
            height: height,
            decoration: BoxDecoration(
                color: colorBg ?? const Color(0xff2D2D30).withOpacity(.5),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color:  Colors.black.withOpacity(.2), spreadRadius: -5, blurRadius: 22, offset: const Offset(0, 11))]),
            child: child));
  }
}
