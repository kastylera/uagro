import 'package:flutter/cupertino.dart';

import '../../../controllers/abstract/from_controller.dart';

class AppController extends FormController {
  late Function(VoidCallback fn) setState;
  late BuildContext c;

  void initPage({required BuildContext context, required Function(VoidCallback fn) set}) async {
    c = context;
    setState = set;
  }
}
