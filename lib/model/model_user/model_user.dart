import 'package:hive/hive.dart';

part 'model_user.g.dart';

@HiveType(typeId: 1)
class ModelUser {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? phone;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? role;
  @HiveField(4)
  String? name;
  @HiveField(5)
  String? token;

  ModelUser(
      {this.name, this.id, this.email, this.phone, this.role, this.token});
}

extension ModelUserX on ModelUser {
  bool get isTraider => role == 'distrib';
  bool get isFarmer => role == 'farmer';
}
