import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../ui/buttons/b_transparent_scalable_button.dart';
import '../../../../ui/text/read_text.dart';
import '../../../../vars/model_notifier/bottom_menu_notifier/bottom_menu_notifier.dart';

Widget buttBottomNavigation({required String icon, required int buttNum, required String text, required BuildContext c}) => Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Center(
            child: BTransparentScalableButton(
          onPressed: () => c.read<BottomMenuNotifier>().setActiveButtMenu(val: buttNum),
          scale: ScaleFormat.big,
          child: Column(
            children: [
              SvgPicture.asset(icon, height: 32, color: c.watch<BottomMenuNotifier>().activeButtMenu != buttNum ? const Color(0xffDCDCDC) : const Color(0xff078F1C)),
              readText(
                  text: text,
                  color: c.watch<BottomMenuNotifier>().activeButtMenu != buttNum ? const Color(0xffDCDCDC) : const Color(0xff078F1C),
                  size: 18,
                  fontWeight: FontWeight.w600,
                  padding: const EdgeInsets.only(top: 8))
            ],
          ),
        )),
      ),
    );
