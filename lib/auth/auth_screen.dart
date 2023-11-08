import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:agro/ui/buttons/b_style.dart';
import 'package:agro/ui/text/read_text.dart';

import '../generated/assets.dart';
import '../ui/buttons/b_transparent_scalable_button.dart';
import '../ui/text_field/text_field.dart';
import 'components/auth_controller.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthController controller = Get.find();

  @override
  void initState() {
    controller.initPage(context: context, set: setState);
    super.initState();
  }

  @override
  Widget build(BuildContext c) {
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
                    TextFieldWidget(
                        padding: const EdgeInsets.only(top: 15),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.transparent),
                        text: 'Введіть номер телефону',
                        header: 'Номер телефону',
                        prefixText: '+ ',
                        openKeyboardAuto: true,
                        colorBg: const Color(0xffF8F8F8),
                        error: controller.errorNumber,
                        keyboardType: TextInputType.number,
                        inputFormatters: controller.maskFormatterNumber,
                        controller: controller.numberController,
                        onChanged: controller.updScreenError),
                    bStyle(
                        key: UniqueKey(),
                        padding: const EdgeInsets.only(top: 35),
                        text: 'Отримати код',
                        size: 23,
                        c: c,
                        colorText: Colors.white,
                        active: controller.numberController.text.length == 16,
                        onPressed: controller.onLogin),
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
