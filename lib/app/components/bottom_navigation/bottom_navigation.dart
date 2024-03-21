import 'package:agro/ui/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../../generated/assets.dart';
import 'components/butt_bottom_navigation.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Container(
                height: 3,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: const Color(0xffE8E8E8).withOpacity(0.5), spreadRadius: 0, blurRadius: 4, offset: const Offset(0, 4)),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              decoration: const BoxDecoration(color: AppColors.mainGreen),
              child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: SafeArea(
                  top: false,
                  bottom: false,
                  child: SizedBox(
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        children: [
                          buttBottomNavigation(icon: Assets.bottomNavigationHome, text: 'Заявки', buttNum: 0, c: context),
                          buttBottomNavigation(icon: Assets.bottomNavigationHelp, text: 'Підтримка', buttNum: 1, c: context),
                          buttBottomNavigation(icon: Assets.bottomNavigationProfile, text: 'Профіль', buttNum: 2, c: context),
                        ],
                      ),
                    ),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
