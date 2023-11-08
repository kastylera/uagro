import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '../api.dart';

class Auth extends Api {
  Future<ApiAnswer> loginNumber({required BuildContext c, required String number}) async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request = await dataRequestMultipart('auth', c: c, parameter: 'phone=$number');

    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());

    return apiAnswer;
  }

  Future<ApiAnswer> loginCode({required BuildContext c, required String code}) async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request = await dataRequestMultipart('auth', c: c, parameter: 'code=$code');

    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());

    return apiAnswer;
  }
}
