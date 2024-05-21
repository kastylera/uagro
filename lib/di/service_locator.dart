import 'dart:async';
import 'package:agro/repositories/auth_repository.dart';
import 'package:agro/server/api/api.dart';
import 'package:agro/storage/user_data_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  //storage
  getIt.registerSingleton<UserDataStorage>(
      UserDataStorage());

  //api

  //repository
  getIt.registerSingleton<AuthenticationRepository>(AuthenticationRepository(
      getIt.get<UserDataStorage>(), Api()));
}
