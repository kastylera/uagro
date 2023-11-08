import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ValidThemes extends StatelessWidget {
  final Widget child;
  final SystemUiOverlayStyle? theme;

  const ValidThemes({Key? key, required this.child, this.theme}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return AnnotatedRegion<SystemUiOverlayStyle>(value: theme ?? SystemUiOverlayStyle.light, child: child);
  }
}
