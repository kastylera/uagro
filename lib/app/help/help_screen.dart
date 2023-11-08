import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:agro/ui/text/read_text.dart';

import '../../generated/assets.dart';
import '../../ui/buttons/b_transparent_scalable_button.dart';
import '../components/block_page_screen.dart';
import 'components/help_controller.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HelpController controller = Get.find();

    return BlockPageScreen(
        header: 'Служба підтримки',
        theme: SystemUiOverlayStyle.dark,
        child: Column(children: [
          readText(
              text: 'Дякуюємо за звернення до нашої служби підтримки! Ми готові допомогти вам у'
                  ' вирішенні будь-яких питань чи проблем, з якими ви зіткнулися.\n\nЗверніться до нас через наші'
                  ' канали зв\'язку у телеграмі або вайбері. Наші експерти швидко відповідатимуть на ваші повідомлення'
                  ' та надаватимуть професійну допомогу у найкоротші терміни.',
              heightText: 1.4,
              size: 18,
              color: Colors.black,
              padding: const EdgeInsets.only(top: 20)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            BTransparentScalableButton(onPressed: controller.onContactTelegram, scale: ScaleFormat.small, child: Image.asset(Assets.authTelegram, width: 60)),
            const SizedBox(width: 50),
            BTransparentScalableButton(onPressed: controller.onContactViber, scale: ScaleFormat.small, child: Image.asset(Assets.authViber, width: 60))
          ]),
          readText(
              text:
                  'Не соромтеся звертатися до нас з будь-якими запитаннями, коментарями або проблемами, які ви маєте. Наша команда завжди тут, щоб допомогти вам і забезпечити вас якісною підтримкою.\n\nДякуємо, що вибрали наш додаток!\n\nЗ повагою, \nКоманда служби підтримки.',
              heightText: 1.4,
              size: 18,
              color: Colors.black,
              padding: const EdgeInsets.only(top: 20)),
        ]));
  }
}
