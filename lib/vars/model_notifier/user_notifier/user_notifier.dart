import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../../model/model_user/model_user.dart';

class UserNotifier extends ChangeNotifier {
  ModelUser modelUser = Hive.box('data').get('modelUser') ?? ModelUser();

  setModelUser({required ModelUser val, bool upd = true}) {
    modelUser = val;
    Hive.box('data').put('modelUser', modelUser);
    if (upd) notifyListeners();
  }

}