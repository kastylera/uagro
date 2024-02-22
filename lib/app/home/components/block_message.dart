import 'package:agro/model/message/message.dart';
import 'package:agro/ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:agro/ui/text/read_text.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class BlockMessage extends StatelessWidget {
  final Message message;

  const BlockMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.grey2),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: readText(
                    text: message.title.toString(),
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    size: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: readText(
                    text: message.message.toString(),
                    color: const Color(0xffA9A9A9),
                    size: 20,
                    fontWeight: FontWeight.w400),
              ),
              message.isRead
                  ? const SizedBox()
                  : Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 10),
                          child: GestureDetector(
                              onTap: () {
                                controller.onReadMessage(message);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.green,
                                      borderRadius: BorderRadius.circular(8)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: const Text(
                                    "Прочитати",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  )))))
            ]),
          )),
    );
  }
}
