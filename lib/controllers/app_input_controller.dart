import 'package:flutter/material.dart';

class AppInputController extends TextEditingController {
  final String? Function(String?)? validatorNew;
  final String? Function(String?, {required BuildContext context})? validator;
  final void Function(String)? onChanged;

  AppInputController({String? text, this.validator, this.onChanged, this.validatorNew}) : super(text: text);
}
