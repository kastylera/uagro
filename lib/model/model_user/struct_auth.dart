import 'dart:developer';

import 'package:agro/vars/model_notifier/user_notifier/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'model_user.dart';
import '../../routes/app_pages.dart';

structUserData(
    {required data, BuildContext? c, bool login = false, String? token}) {
  ModelUser modelUser = ModelUser();
  try {
    modelUser.id = data['id'].toString();
    modelUser.phone = data['phone'];
    modelUser.email = data['email'];
    modelUser.role = data['role'];
    modelUser.name = data['name'];
    modelUser.token = token;
  } catch (err) {
    log(err.toString());
  }
  log("ROLEE:$data");
  log(data['role']);
  if (login) {
    c?.read<UserNotifier>().setModelUser(val: modelUser, upd: false);
    Hive.box('data').put('modelUser', modelUser);

    Get.offAllNamed(Routes.app);
  } else {
    return modelUser;
  }
  return null;
}

  ModelUser? parseUser({required dynamic data, String? token}) {
    ModelUser modelUser = ModelUser();
    try {
      modelUser.id = data['id'].toString();
      modelUser.phone = data['phone'];
      modelUser.email = data['email'];
      modelUser.role = data['role'];
      modelUser.name = data['name'];
      modelUser.token = token;
    } catch (err) {
      log(err.toString());
      return null;
    }
    return modelUser;
  }
