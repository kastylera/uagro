import 'package:agro/model/call_result/call_result.dart';
import 'package:agro/ui/buttons/b_style.dart';
import 'package:flutter/material.dart';

class SetAnswer extends StatelessWidget {
  const SetAnswer({Key? key, required this.onAnswered}) : super(key: key);

  final Function(CallResult) onAnswered;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 600,
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xffEDEDED),
                      borderRadius: BorderRadius.circular(3)),
                  height: 10,
                  width: 100)),
          const SizedBox(height: 32),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: CallResult.values.length,
              itemBuilder: (context, index) {
                final item = CallResult.values[index];
                return Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
                    child: bStyle(
                      c: context,
                      size: 24,
                      colorText: Colors.black,
                      colorButt: item.color,
                      text: item.label,
                      onPressed: () => onAnswered(item),
                    ));
              }),
          bStyle(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 20),
              text: 'Закрити',
              size: 23,
              c: context,
              colorText: Colors.black,
              vertical: 15,
              colorButt: const Color(0xffF2F2F2),
              onPressed: () => Navigator.pop(context))
        ],
      ),
    );
  }
}
