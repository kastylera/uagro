import 'dart:convert';
import '../api.dart';

class Auth extends Api {
  Future<ApiAnswer> loginNumber({required String number}) async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request = await dataRequestMultipart('auth', parameter: 'phone=$number');

    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());

    return apiAnswer;
  }

  Future<ApiAnswer> loginCode({required String code}) async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request = await dataRequestMultipart('auth', parameter: 'code=$code');

    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());

    return apiAnswer;
  }
}
