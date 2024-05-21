import 'package:agro/model/model_user/model_user.dart';
import 'package:hive/hive.dart';

class UserDataStorage {
  static const configsTag = "configs";
  static const dataTag = "data";
  static const userDataTag = "modelUser";
  static const fcmTokenTag = "fcmToken";

  Future<Box> getConfigs() async {
    return _getBox(configsTag);
  }

  Future<Box> getData() async {
    return _getBox(dataTag);
  }

  Future<String?> getToken() async {
    return (await getUser())?.token;
  }

  Future<ModelUser?> getUser() async {
    return (await _getBox(dataTag)).get(userDataTag);
  }

  Future setUser(ModelUser user) async {
    return (await _getBox(dataTag)).put(userDataTag, user);
  }

  Future<String?> getFcmToken() async {
    return (await getData()).get(fcmTokenTag);
  }

  Future setFcmToken(String fcmToken) async {
    return (await getData()).put(fcmTokenTag, fcmToken);
  }

  Future<Box> _getBox(String name) async {
    if (Hive.isBoxOpen(name)) {
      return Hive.box(name);
    } else {
      return Hive.openBox(name);
    }
  }

  void deleteAll() {
    getData().then((value) => value.clear());
  }
}
