import 'dart:ui';

import 'package:agro/ui/theme/colors.dart';
import 'package:hive/hive.dart';

part 'call_result.g.dart';

@HiveType(typeId: 3)
enum CallResult {
  @HiveField(0)
  agreement("Угода", AppColors.mainGreen),
  @HiveField(1)
  noAnswer("Не підняв слухавку", AppColors.yellow),
  @HiveField(2)
  noConnection("Не має зв’язку", AppColors.yellow),
  @HiveField(3)
  wrongPrice("Ціна не підійшла", AppColors.red),
  @HiveField(4)
  notActual("Заявка не актуальна", AppColors.red);

  final String label;
  final Color color;

  const CallResult(this.label, this.color);
}
