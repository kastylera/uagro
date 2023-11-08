import 'package:flutter/material.dart';

navigator(Widget screen, BuildContext c) async => await Navigator.push(
    c,
    PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (BuildContext c, Animation<double> animation, Animation<double> setAnimation, Widget child) {
          animation = CurvedAnimation(parent: animation, curve: Curves.ease);
          return ScaleTransition(scale: animation, alignment: Alignment.center, child: child);
        },
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> setAnimation) {
          return screen;
        }));