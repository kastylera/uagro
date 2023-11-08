import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:agro/ui/buttons/b_style.dart';
import 'package:agro/ui/text/read_text.dart';
import 'package:pinput/pinput.dart';

import '../../generated/assets.dart';
import '../../ui/buttons/b_transparent_scalable_button.dart';
import 'components/auth_confirmation_controller.dart';

class AuthConfirmScreen extends StatefulWidget {
  const AuthConfirmScreen({super.key});

  @override
  State<AuthConfirmScreen> createState() => _AuthConfirmScreenState();
}

class _AuthConfirmScreenState extends State<AuthConfirmScreen> {
  AuthConfirmationController controller = Get.find();

  @override
  void initState() {
    controller.initPage(context: context, set: setState);
    super.initState();
  }

  @override
  Widget build(BuildContext c) {
    final defaultPinTheme = PinTheme(
        width: MediaQuery.of(c).size.width / 4,
        height: 60,
        padding: EdgeInsets.zero,
        textStyle: const TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.w600),
        decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.transparent), color: const Color(0xffF8F8F8), borderRadius: BorderRadius.circular(10)));

    final focusPinTheme = PinTheme(
        width: MediaQuery.of(c).size.width / 4,
        height: 60,
        padding: EdgeInsets.zero,
        textStyle: const TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.w600),
        decoration: BoxDecoration(border: Border.all(width: 2, color: const Color(0xff01CA20)), color: Colors.white, borderRadius: BorderRadius.circular(10)));

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
                Image.asset(Assets.authBg, fit: BoxFit.fitWidth, width: MediaQuery.of(c).size.width),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Padding(padding: const EdgeInsets.only(top: 25), child: Center(child: Image.asset(Assets.pictureLogo, width: MediaQuery.of(c).size.width / 1.4))),
                    const Spacer(),
                    readText(text: 'Введіть код', size: 22, fontWeight: FontWeight.w500, color: Colors.black, padding: const EdgeInsets.only(bottom: 10)),
                    readText(
                        text: 'Код було відправлено на ваш номер',
                        size: 18,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xffA9A9A9),
                        padding: const EdgeInsets.only(bottom: 10)),
                    Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Pinput(
                                controller: controller.codeController,
                                scrollPadding: EdgeInsets.zero,
                                defaultPinTheme: defaultPinTheme,
                                focusedPinTheme: focusPinTheme,
                                submittedPinTheme: defaultPinTheme,
                                length: 4,
                                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                                showCursor: true,
                                onChanged: controller.updScreenError))),
                    if (controller.errorCode != null) ...[
                      Center(
                          child: readText(
                              text: controller.errorCode!,
                              color: const Color(0xffEB5858),
                              fontWeight: FontWeight.w600,
                              size: 18,
                              align: TextAlign.center,
                              padding: const EdgeInsets.only(top: 10)))
                    ],
                    bStyle(
                      key: UniqueKey(),
                        padding: const EdgeInsets.only(top: 35),
                        text: 'Продовжити',
                        size: 23,
                        c: c,
                        colorText: Colors.white,
                        active: controller.codeController.text.length == 4,
                        onPressed: controller.onLogin),
                    BTransparentScalableButton(
                        onPressed: controller.onAuth,
                        scale: ScaleFormat.small,
                        child: Center(child: readText(text: 'Змінити номер?', color: Colors.blueGrey, size: 20, padding: const EdgeInsets.only(top: 10)))),
                    const Spacer(),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      BTransparentScalableButton(onPressed: controller.onContactTelegram, scale: ScaleFormat.small, child: Image.asset(Assets.authTelegram, width: 50)),
                      const SizedBox(width: 20),
                      BTransparentScalableButton(onPressed: controller.onContactViber, scale: ScaleFormat.small, child: Image.asset(Assets.authViber, width: 50))
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
