import 'dart:developer';

import 'package:agro/model/answer/answer.dart';
import 'package:agro/model/call_result/call_result.dart';
import 'package:agro/model/model_user/model_user.dart';
import 'package:hive/hive.dart';

class LocalStorageRepository {
  addNew(CallResult result, String orderId) {
    ModelUser? modelUser = Hive.box('data').get('modelUser');
    Hive.box(_answers).put("${modelUser?.id}$orderId",
        Answer(userId: modelUser?.id, orderId: orderId, result: result));
    log("answer saved: ${modelUser?.id}$orderId");
  }

  Future<CallResult?> getResult(String orderId) async {
    ModelUser? modelUser = Hive.box('data').get('modelUser');
    Answer? data = Hive.box(_answers).get("${modelUser?.id}$orderId");
    log("answer get: ${data.toString()}");
    return data?.result;
  }

  static const String _answers = "answers";
}
