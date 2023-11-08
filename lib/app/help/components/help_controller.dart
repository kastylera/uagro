import 'package:url_launcher/url_launcher.dart';

import '../../../controllers/abstract/from_controller.dart';

class HelpController extends FormController {
  void onContactTelegram() => launchUrl(Uri.parse('https://t.me/uagro_admin'));

  void onContactViber() => launchUrl(Uri.parse('viber://chat?number=${Uri.encodeComponent('+380990026222')}'));
}
