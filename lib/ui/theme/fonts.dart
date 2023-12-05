import 'package:agro/ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//+6
class AppFonts {
  static TextStyle title1 = GoogleFonts.nunito(
      fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.black);

  static TextStyle title2 = GoogleFonts.nunito(
      fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.black);

  static TextStyle body1medium = GoogleFonts.nunito(
      fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.black);
  static TextStyle body1semibold = GoogleFonts.nunito(
      fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.black);
  static TextStyle body1bold = GoogleFonts.nunito(
      fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.black);

  static TextStyle body2medium = GoogleFonts.nunito(
      fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.black);
  static TextStyle body2semibold = GoogleFonts.nunito(
      fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.black);
  static TextStyle body2bold = GoogleFonts.nunito(
      fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.black);

  static TextStyle body3medium = GoogleFonts.nunito(
      fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.black);

  static TextStyle caption = GoogleFonts.nunito(
      fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.black);
}

extension CopyWithStyles on TextStyle {
  TextStyle get white => copyWith(color: AppColors.white);
  TextStyle get black => copyWith(color: AppColors.black);

  TextStyle get red => copyWith(color: AppColors.red);
  TextStyle get yellow => copyWith(color: AppColors.yellow);

  TextStyle get mainGreen => copyWith(color: AppColors.mainGreen);
  TextStyle get greyGreen => copyWith(color: AppColors.greyGreen);
  TextStyle get additionalGreen => copyWith(color: AppColors.additionalGreen);
  TextStyle get darkGreen => copyWith(color: AppColors.darkGreen);

  TextStyle get grey4 => copyWith(color: AppColors.grey4);
  TextStyle get grey3 => copyWith(color: AppColors.grey3);
  TextStyle get grey2 => copyWith(color: AppColors.grey2);
  TextStyle get grey1 => copyWith(color: AppColors.grey1);

  TextStyle withColor(Color color) => copyWith(color: color);
  TextStyle withSize(double size) => copyWith(fontSize: size);
}
