import 'dart:developer';

import 'package:agro/model/answer/answer.dart';
import 'package:agro/model/call_result/call_result.dart';
import 'package:agro/model/model_user/model_user.dart';
import 'package:hive/hive.dart';

class LocalStorageRepository {
  addNew(CallResult result, String orderId) async {
    ModelUser? modelUser = Hive.box('data').get('modelUser');
    final box = await Hive.openBox<Answer>(_answers);
    box.put("${modelUser?.id}$orderId",
        Answer(userId: modelUser?.id, orderId: orderId, result: result));
    box.close;
    log("answer saved: ${modelUser?.id}$orderId");
  }

  Future<CallResult?> getResult(String orderId) async {
    ModelUser? modelUser = Hive.box('data').get('modelUser');
    final box = await Hive.openBox<Answer>(_answers);
    Answer? data = box.get("${modelUser?.id}$orderId");
    log("answer get: ${data.toString()}");
    box.close();
    return data?.result;
  }

  Future<List<Answer>> getAll() async {
    final box = await Hive.openBox<Answer>(_answers);
    List<Answer> data = box.values.toList();
    log("answer get: ${data.toString()}");
    box.close();
    return data;
  }

  Future<void> clear() async {
    final box = await Hive.openBox<Answer>(_answers);
    box.clear();
    box.close();
  }

  static const String _answers = "answers";
}
