import 'package:agro/ui/theme/colors.dart';
import 'package:agro/ui/theme/fonts.dart';
import 'package:agro/vars/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
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
          backgroundColor: AppColors.white,
          body: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 120, bottom: 120),
                          child: Center(
                              child: SvgPicture.asset(Assets.pictureLogo,
                                  width: MediaQuery.of(c).size.width / 1.2))),
                      TextFieldWidget(
                          padding: const EdgeInsets.only(top: 15),
                          text: context.l.enterPhoneNumber,
                          header: context.l.phoneNumber,
                          prefixText: '+ ',
                          openKeyboardAuto: true,
                          error: controller.errorNumber,
                          keyboardType: TextInputType.number,
                          inputFormatters: controller.maskFormatterNumber,
                          controller: controller.numberController,
                          onChanged: controller.updScreenError),
                      bStyle(
                          key: UniqueKey(),
                          padding: const EdgeInsets.only(top: 35),
                          text: context.l.getCode,
                          c: c,
                          vertical: 18,
                          active: controller.numberController.text.length == 16,
                          onPressed: controller.onLogin),
                      const Spacer(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BTransparentScalableButton(
                                onPressed: controller.onContactTelegram,
                                scale: ScaleFormat.small,
                                child: SvgPicture.asset(Assets.authTelegram,
                                    width: 50)),
                            const SizedBox(width: 20),
                            BTransparentScalableButton(
                                onPressed: controller.onContactViber,
                                scale: ScaleFormat.small,
                                child: SvgPicture.asset(Assets.authViber,
                                    width: 55))
                          ]),
                      Center(
                          child: readText(
                              text: context.l.needHelpSupport,
                              style: AppFonts.body2medium.grey3,
                              padding:
                                  const EdgeInsets.only(bottom: 30, top: 15),
                              align: TextAlign.center))
                    ]),
              )),
        ));
  }
}
