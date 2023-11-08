import 'package:agro/app/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../routes/initialize_get.dart';
import '../vars/model_notifier/bottom_menu_notifier/bottom_menu_notifier.dart';
import '../vars/valid_themes.dart';
import 'components/app_controller.dart';
import 'components/bottom_navigation/bottom_navigation.dart';
import 'help/help_screen.dart';
import 'home/home_screen.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  @override
  void initState() {
    initializeGet();
    AppController controller = Get.find();

    controller.initPage(context: context, set: setState);

    super.initState();
  }

  @override
  Widget build(BuildContext c) {
    return ValidThemes(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              SafeArea(
                top: false,
                child: Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(c).viewInsets.bottom > 50 ? 0 : 60),
                  child: Column(
                    children: [
                      if (c.watch<BottomMenuNotifier>().activeButtMenu == 0) ...[
                        const Expanded(child: HomeScreen())
                      ] else if (c.watch<BottomMenuNotifier>().activeButtMenu == 1) ...[
                        const Expanded(child: HelpScreen())
                      ] else if (c.watch<BottomMenuNotifier>().activeButtMenu == 2) ...[
                        const Expanded(child: ProfileScreen())
                      ]
                    ],
                  ),
                ),
              ),
              const Align(alignment: Alignment.bottomCenter, child: BottomNavigation())
            ],
          )),
    );
  }
}
