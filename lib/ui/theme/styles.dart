import 'package:flutter/material.dart';

import 'colors.dart';
import 'fonts.dart';

InputDecoration textFieldInputDecoration = const InputDecoration(
    focusColor: AppColors.white,
    focusedBorder: textFieldBorder,
    enabledBorder: textFieldBorder,
    border: textFieldBorder,
    hintText: '',
    filled: true,
    fillColor: AppColors.grey1);

const OutlineInputBorder textFieldBorder = OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.grey2),
    borderRadius: BorderRadius.all(Radius.circular(8)));

ButtonStyle greenButtonStyle = ButtonStyle(padding: MaterialStateProperty.all(const EdgeInsets.only(top: 6, bottom: 6, left: 20, right: 20)),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0))),
  backgroundColor: MaterialStateProperty.resolveWith<Color>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return AppColors.mainGreen;
      } else if (states.contains(MaterialState.disabled)) {
        return AppColors.mainGreen.withOpacity(0.3);
      }
      return AppColors.mainGreen;
    },
  ),
  textStyle:
      MaterialStateProperty.resolveWith<TextStyle>((Set<MaterialState> states) {
    return AppFonts.body1bold.white;
  }),
);