import 'dart:async';
import 'dart:convert';
import 'package:agro/model/model_user/model_user.dart';
import 'package:agro/model/model_user/struct_auth.dart';
import 'package:agro/server/api/api.dart';
import 'package:agro/storage/user_data_storage.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final UserDataStorage _userDataStorage;
  final Api _api;

  AuthenticationRepository(this._userDataStorage, this._api);

  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    String? token = await getToken();
    if ((token ?? "").isEmpty) {
      yield AuthenticationStatus.unauthenticated;
    } else {
      yield AuthenticationStatus.authenticated;
    }
    yield* _controller.stream;
  }

  Future<ApiAnswer> requestCode({required String number}) async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request =
        await _api.dataRequestMultipart('auth', parameter: 'phone=$number');

    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());

    return apiAnswer;
  }

  Future<ApiAnswer> loginCode({required String code}) async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request =
        await _api.dataRequestMultipart('auth', parameter: 'code=$code');

    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());

    if (apiAnswer.data['status']) {
      ModelUser? user = parseUser(
        data: apiAnswer.data['payload']['user'],
        token: apiAnswer.data['payload']['key'],
      );
      if (user != null && user.token != null) {
        _userDataStorage.setUser(user);
        _controller.add(AuthenticationStatus.authenticated);
      } else {
        throw Exception(apiAnswer.data['message']);
      }
    } else {
      throw Exception(apiAnswer.data['message']);
    }
    return apiAnswer;
  }

  Future<String?> getToken() async {
    return await _userDataStorage.getToken();
  }

  Future<void> logOut() async {
    _userDataStorage.deleteAll();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
