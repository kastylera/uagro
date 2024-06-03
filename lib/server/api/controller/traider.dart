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
            'mode=trader&page=$page&limit=$limit&search=$search');

    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());
    checkAuth(apiAnswer.data);

    return apiAnswer;
  }

  Future<ApiAnswer> getOrder({required int? orderId}) async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request = await dataRequestMultipart('order.view',
        parameter: 'order_id=$orderId');

    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());
    checkAuth(apiAnswer.data);

    return apiAnswer;
  }

  Future<ApiAnswer> getMessages() async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request =
        await dataRequestMultipart('push.getall', parameter: 'type=MESSAGE');

    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());
    checkAuth(apiAnswer.data);

    return apiAnswer;
  }

  Future<ApiAnswer> readMessage(int? pushId) async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request = await dataRequestMultipart('push.setreaded',
        parameter: 'push_id=$pushId');

    apiAnswer.code = request.statusCode;
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

  Future<ApiAnswer> checkSendOffer({int? sphere = 12}) async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request = await dataRequestMultipart('smssender.get',
        parameter: 'sphere=$sphere');
    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());
    checkAuth(apiAnswer.data);
    return apiAnswer;
  }

  Future<ApiAnswer> sendOffer(String? asId, String? sms) async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request = await dataRequestMultipart('smssender.send',
        parameter: 'as_id=$asId&sms=$sms');
    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());
    checkAuth(apiAnswer.data);
    return apiAnswer;
  }
}
