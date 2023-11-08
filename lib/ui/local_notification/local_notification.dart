import 'package:flutter/material.dart';
import 'package:in_app_notification/in_app_notification.dart';
import '../text/read_text.dart';

Widget localNotification({required String text, required BuildContext c, double? size}) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
    child: DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 12, blurRadius: 16),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          color: Colors.white,
          child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(child: readText(text: text, color: Colors.black, size: size ?? 22, fontWeight: FontWeight.w500, align: TextAlign.center))),
        ),
      ),
    ));

void inAppNotification({required String text, required BuildContext c, double? size, int? seconds}) =>
    InAppNotification.show(child: localNotification(text: text, c: c, size: size), context: c, duration: Duration(seconds: seconds ?? 2));
