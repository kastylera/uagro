import 'package:agro/model/call_result/call_result.dart';
import 'package:hive/hive.dart';

part 'answer.g.dart';

@HiveType(typeId: 4)
class Answer {
  @HiveField(0)
  String? orderId;
  @HiveField(1)
  String? userId;
  @HiveField(2)
  CallResult? result;

  Answer({this.orderId, this.userId, this.result});
}
