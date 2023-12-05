import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:agro/ui/text/read_text.dart';

import '../../generated/assets.dart';
import '../../ui/buttons/b_transparent_scalable_button.dart';
import 'components/auth_register_ok_controller.dart';

class AuthRegisterOkScreen extends StatelessWidget {
  const AuthRegisterOkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthRegisterOkController controller = Get.find();

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xffEFEFEF),
          body: SafeArea(
            bottom: false,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset(Assets.authBg, fit: BoxFit.fitWidth, width: MediaQuery.of(context).size.width),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Padding(padding: const EdgeInsets.only(top: 25), child: Center(child: SvgPicture.asset(Assets.pictureLogo, width: MediaQuery.of(context).size.width / 1.4))),
                    const Spacer(),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: const Color(0xffF8F8F8), borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                            readText(
                                text: 'Дякуємо за реєстрацію', fontWeight: FontWeight.w600, color: Colors.black, size: 26, padding: const EdgeInsets.only(bottom: 20)),
                            readText(text: 'Наші менеджери скоро зв’яжуться із вами.', color: Colors.black, align: TextAlign.center, size: 20),
                          ]),
                        )),
                    const Spacer(),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      BTransparentScalableButton(onPressed: controller.onContactTelegram, scale: ScaleFormat.small, child: SvgPicture.asset(Assets.authTelegram, width: 50)),
                      const SizedBox(width: 20),
                      BTransparentScalableButton(onPressed: controller.onContactViber, scale: ScaleFormat.small, child: SvgPicture.asset(Assets.authViber, width: 50))
                    ]),
                    Center(
                        child: readText(
                            text: 'Потрібна допомога? Звертайтесь до\nнашої служби підтримки!',
                            color: const Color(0xffA9A9A9),
                            padding: const EdgeInsets.only(bottom: 30, top: 15),
                            size: 18,
                            align: TextAlign.center))
                  ]),
                )
              ],
            ),
          ),
        ));
  }
}
