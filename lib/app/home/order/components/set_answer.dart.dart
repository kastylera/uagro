import 'package:agro/model/call_result/call_result.dart';
import 'package:agro/ui/buttons/b_style.dart';
import 'package:agro/ui/theme/colors.dart';
import 'package:agro/ui/views/bottom_drawer_header.dart';
import 'package:flutter/material.dart';

class SetAnswer extends StatelessWidget {
  const SetAnswer({Key? key, required this.onAnswered}) : super(key: key);

  final Function(CallResult) onAnswered;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 550,
      child: Column(
        children: [
          const BottomDrawerHeader(),
          const SizedBox(height: 32),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: CallResult.values.length,
              itemBuilder: (context, index) {
                final item = CallResult.values[index];
                return Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, top: 10),
                    child: bStyle(
                      c: context,
                      vertical: 15,
                      colorText: AppColors.white,
                      colorButt: item.color,
                      text: item.label,
                      onPressed: () => onAnswered(item),
                    ));
              }),
          bStyle(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 0, bottom: 20),
              text: 'Закрити',
              c: context,
              colorText: AppColors.grey4,
              vertical: 15,
              colorButt: Colors.transparent,
              border: Border.all(color: AppColors.grey4, width: 1),
              onPressed: () => Navigator.pop(context))
        ],
      ),
    );
  }
}
