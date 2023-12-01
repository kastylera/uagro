import 'package:agro/model/tariff/tariff.dart';
import 'package:agro/ui/text/read_text.dart';
import 'package:agro/ui/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:agro/ui/utils/date_extensions.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key, required this.tariff, required this.total})
      : super(key: key);

  final Tariff? tariff;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      headerItem((total).toString(), "Заявок"),
      headerItem((tariff?.balanceContactsDayOsttk ?? 0).toString(), "Котактів"),
      headerItem((tariff?.balanceSms ?? 0).toString(), "SMS"),
      headerItem(
          tariff?.balanceEnd?.formatDateShort() ?? '', "Термін дії тарифу", isValid: tariff?.balanceEnd?.isActive() ?? true)
    ]);
  }

  Widget headerItem(String value, String description, {bool isValid = true}) {
    return Column(children: [
      readText(text: value, style: isValid ? AppFonts.body1bold.mainGreen : AppFonts.body1bold.red),
      readText(text: description, style: AppFonts.caption.darkGreen)
    ]);
  }
}
