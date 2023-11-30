import 'dart:convert';
import 'dart:developer';

import '../api.dart';

class Traider extends Api {
  Future<ApiAnswer> getOrderList(
      {required int page, required int limit, String? search}) async {
    ApiAnswer apiAnswer = ApiAnswer();
    log('mode=trader&page=$page&limit=$limit&search=$search&sphere=15');
    var request = await dataRequestMultipart('order.list',
        parameter:
            'mode=trader&page=$page&limit=$limit&search=$search&sphere=15');

    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());
    checkAuth(apiAnswer.data);

    return apiAnswer;
  }

  Future<ApiAnswer> orderOpenContactFermer({required int orderId}) async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request = await dataRequestMultipart('order.opencontacts',
        parameter: 'order_id=$orderId');

    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());
    checkAuth(apiAnswer.data);

    return apiAnswer;
  }

  Future<ApiAnswer> viewReviewTender({required int orderId}) async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request = await dataRequestMultipart('order.reviews',
        parameter: 'order_id=$orderId');

    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());
    checkAuth(apiAnswer.data);

    return apiAnswer;
  }

  Future<ApiAnswer> addPrice(
      {required int orderId,
      required String price,
      required String form,
      required String currency}) async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request = await dataRequestMultipart('order.addbid',
        parameter:
            'order_id=$orderId&price=$price&place_type=EXW1&send_sms=1&forma=$form&currc=$currency');
    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());
    checkAuth(apiAnswer.data);

    return apiAnswer;
  }

  Future<ApiAnswer> deal({required int tenderId}) async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request = await dataRequestMultipart('vip_accept',
        parameter: 'tender_id=$tenderId');
    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());
    checkAuth(apiAnswer.data);

    return apiAnswer;
  }

  Future<ApiAnswer> getTariff() async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request = await dataRequestMultipart('tariff');
    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());
    checkAuth(apiAnswer.data);

    return apiAnswer;
  }

  Future<ApiAnswer> sendDeviceToken({required String deviceToken}) async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request = await dataRequestMultipart('send_devicetoken',
        parameter: 'device_token=$deviceToken');
    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());
    checkAuth(apiAnswer.data);

    return apiAnswer;
  }
}
