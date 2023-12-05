import 'package:agro/ui/theme/colors.dart';
import 'package:agro/ui/theme/fonts.dart';
import 'package:agro/vars/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        textStyle: const TextStyle(
            fontSize: 24, color: AppColors.black, fontWeight: FontWeight.w600),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.transparent),
            color: AppColors.grey1,
            borderRadius: BorderRadius.circular(10)));

    final focusPinTheme = PinTheme(
        width: MediaQuery.of(c).size.width / 4,
        height: 60,
        padding: EdgeInsets.zero,
        textStyle: const TextStyle(
            fontSize: 24, color: AppColors.black, fontWeight: FontWeight.w600),
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: AppColors.mainGreen),
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10)));

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.white,
          body: SafeArea(
            bottom: false,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding:
                                const EdgeInsets.only(top: 120, bottom: 120),
                            child: Center(
                                child: SvgPicture.asset(Assets.pictureLogo,
                                    width: MediaQuery.of(c).size.width / 1.2))),
                        readText(
                            text: context.l.enterCode,
                            style: AppFonts.title2,
                            padding:
                                const EdgeInsets.only(bottom: 10, left: 7)),
                        readText(
                            text: context.l.codeWasSent,
                            style: AppFonts.body1semibold.grey3,
                            padding:
                                const EdgeInsets.only(bottom: 10, left: 7)),
                        Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Pinput(
                                    controller: controller.codeController,
                                    scrollPadding: EdgeInsets.zero,
                                    defaultPinTheme: defaultPinTheme,
                                    focusedPinTheme: focusPinTheme,
                                    submittedPinTheme: defaultPinTheme,
                                    length: 4,
                                    pinputAutovalidateMode:
                                        PinputAutovalidateMode.onSubmit,
                                    showCursor: true,
                                    onChanged: controller.updScreenError))),
                        if (controller.errorCode != null) ...[
                          Center(
                              child: readText(
                                  text: controller.errorCode!,
                                  style: AppFonts.body2semibold.red,
                                  align: TextAlign.center,
                                  padding: const EdgeInsets.only(top: 10)))
                        ],
                        bStyle(
                            key: UniqueKey(),
                            padding: const EdgeInsets.only(top: 35),
                            text: context.l.continue_,
                            vertical: 18,
                            c: c,
                            active: controller.codeController.text.length == 4,
                            onPressed: controller.onLogin),
                        BTransparentScalableButton(
                            onPressed: controller.onAuth,
                            scale: ScaleFormat.small,
                            child: Center(
                                child: readText(
                                    text: context.l.changeNumber,
                                    style: AppFonts.body1semibold.mainGreen,
                                    padding: const EdgeInsets.only(top: 20)))),
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
                )
              ],
            ),
          ),
        ));
  }
}
