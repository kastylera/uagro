import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import '../api.dart';

class Traider extends Api {
  Future<ApiAnswer> getOrderList({required BuildContext c, required int page, required int limit, String? search}) async {
    ApiAnswer apiAnswer = ApiAnswer();
    log('mode=trader&page=$page&limit=$limit&search=$search&sphere=15');
    var request = await dataRequestMultipart('order.list', c: c, parameter: 'mode=trader&page=$page&limit=$limit&search=$search&sphere=15');

    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());
    checkAuth(apiAnswer.data);

    return apiAnswer;
  }

  Future<ApiAnswer> orderOpenContactFermer({required BuildContext c, required int orderId}) async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request = await dataRequestMultipart('order.opencontacts', c: c, parameter: 'order_id=$orderId');

    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());
    checkAuth(apiAnswer.data);

    return apiAnswer;
  }

  Future<ApiAnswer> viewReviewTender({required BuildContext c, required int orderId}) async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request = await dataRequestMultipart('order.reviews', c: c, parameter: 'order_id=$orderId');

    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());
    checkAuth(apiAnswer.data);

    return apiAnswer;
  }

  Future<ApiAnswer> addPrice({required BuildContext c, required int orderId, required String price}) async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request = await dataRequestMultipart('order.addbid', c: c, parameter: 'order_id=$orderId&price=$price&place_type=EXW1&send_sms=1');
    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());
    checkAuth(apiAnswer.data);

    return apiAnswer;
  }

  Future<ApiAnswer> deal(
      {required BuildContext c,
      required int tenderId}) async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request = await dataRequestMultipart('vip_accept',
        c: c,
        parameter: 'tender_id=$tenderId');
    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());
    checkAuth(apiAnswer.data);

    return apiAnswer;
  }

  Future<ApiAnswer> getTariff({required BuildContext c}) async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request = await dataRequestMultipart('tariff', c: c);
    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());
    checkAuth(apiAnswer.data);

    return apiAnswer;
  }

  Future<ApiAnswer> sendDeviceToken({required BuildContext c, required String deviceToken}) async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request = await dataRequestMultipart('send_devicetoken', c: c, parameter: 'device_token=$deviceToken');
    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());
    checkAuth(apiAnswer.data);

    return apiAnswer;
  }
}
