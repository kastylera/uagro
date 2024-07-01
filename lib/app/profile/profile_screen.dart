import 'package:agro/model/model_user/model_user.dart';
import 'package:agro/ui/text/read_text.dart';
import 'package:agro/ui/theme/colors.dart';
import 'package:agro/ui/theme/fonts.dart';
import 'package:agro/vars/helper.dart';
import 'package:agro/vars/valid_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../generated/assets.dart';
import 'components/block_setting.dart';
import 'components/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              readText(text: context.l.profile, style: AppFonts.title1.white),
          centerTitle: true,
          backgroundColor: AppColors.mainGreen,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: ValidThemes(
            theme: const SystemUiOverlayStyle(
                statusBarColor: AppColors.mainGreen,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark),
            child: SafeArea(
                bottom: false,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    Stack(alignment: Alignment.topCenter, children: [
                      Container(color: AppColors.mainGreen, height: 170),
                      Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 40),
                          child: Align(
                              alignment: Alignment.topCenter,
                              child: Card(
                                elevation: 2,
                                shape: const CircleBorder(),
                                child: SvgPicture.asset(Assets.profile,
                                    width: 200, height: 200),
                              ))),
                      Positioned(
                          bottom: 0,
                          child: readText(
                              text: controller.modelUser.value.phone.toString(),
                              style: AppFonts.title2,
                              padding: const EdgeInsets.only(top: 20))),
                    ]),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 0, bottom: 35),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              BlockSetting(
                                  header: context.l.ourSite,
                                  icon: Assets.accountSite,
                                  onPressed: controller.onSite),
                              BlockSetting(
                                  header: context.l.support,
                                  icon: Assets.accountQuestion,
                                  onPressed: controller.onHelp),
                              BlockSetting(
                                  header: context.l.privacyPolicy,
                                  icon: Assets.accountPrivacy,
                                  onPressed: controller.onPrivacy),
                              BlockSetting(
                                  header: "Тарифи",
                                  icon: Assets.accountTariffs,
                                  onPressed: controller.onTariffs),
                              BlockSetting(
                                  header: context.l.deleteProfile,
                                  icon: Assets.accountDelete,
                                  onPressed: () =>
                                      controller.onDeleteAccount(context)),
                              BlockSetting(
                                header: context.l.logOutOfProfile,
                                icon: Assets.accountExit,
                                onPressed: () => controller.onExit(context),
                              )
                            ],
                          ),
                        ))
                  ],
                )))));
  }
}
