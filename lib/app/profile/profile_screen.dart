import 'package:agro/ui/text/read_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:agro/app/components/block_page_screen.dart';
import '../../generated/assets.dart';
import 'components/block_setting.dart';
import 'components/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController controller = Get.find();

  @override
  void initState() {
    controller.initPage(context: context, set: setState);
    super.initState();
  }

  @override
  Widget build(BuildContext c) {
    print(controller.modelUser.name);
    // print(controller.modelUser);
    print(controller.modelUser.phone);

    return BlockPageScreen(
        headerSize: 21,
        padding: EdgeInsets.only(left: controller.modelUser.role == 'distrib' ? 0 : 40),
        header: 'Профіль',
        theme: SystemUiOverlayStyle.dark,
        child: Column(
          children: [
            const SizedBox(height: 30),
            SvgPicture.asset(Assets.bottomNavigationProfile, color: Colors.black12, height: 100),
            readText(text: controller.modelUser.phone.toString(), color: Colors.black, size: 20, padding: const EdgeInsets.only(top: 20)),
            Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 40, bottom: 35),
                child: Container(
                  width: MediaQuery.of(c).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: const Color(0xff52C3FF).withOpacity(.2), spreadRadius: -5, blurRadius: 22, offset: const Offset(0, 11))]),
                  child: Column(
                    children: [
                      BlockSetting(header: 'Наш сайт', icon: Assets.accountSite, onPressed: controller.onSite),
                      BlockSetting(header: 'Підтримка', icon: Assets.accountQuestion, onPressed: controller.onHelp),
                      BlockSetting(header: 'Політика конфеденційності', icon: Assets.accountPrivacy, onPressed: controller.onPrivacy),
                      // BlockSetting(header: 'Політика користування', icon: Assets.accountTerms, onPressed: controller.onTerms),
                      BlockSetting(header: 'Видалити профіль', icon: Assets.accountDelete, onPressed: controller.onDeleteAccount),
                      BlockSetting(header: 'Вийти з профілю', icon: Assets.accountExit, onPressed: controller.onExit, arrowActive: false)
                    ],
                  ),
                ))
          ],
        ));
  }
}
