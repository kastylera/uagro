import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '../api.dart';

class Fermer extends Api {
  Future<ApiAnswer> getOrderList({required BuildContext c, required int page, required int limit, String? search}) async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request = await dataRequestMultipart('order.list', parameter: 'mode=fermer&page=$page&limit=$limit&search=$search&deleted=false');

    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());
    checkAuth(apiAnswer.data);

    return apiAnswer;
  }

  Future<ApiAnswer> createOrder() async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request = await dataRequestMultipart('order.list', parameter: 'mode=fermer.createorder');

    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());
    checkAuth(apiAnswer.data);

    return apiAnswer;
  }

  Future<ApiAnswer> getInfoPriceOrder({required int orderId}) async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request = await dataRequestMultipart('order.pricelist', parameter: 'order_id=$orderId');

    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());
    checkAuth(apiAnswer.data);

    return apiAnswer;
  }

  Future<ApiAnswer> closePriceOrder({required int orderId}) async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request = await dataRequestMultipart('fermer.closeorder', parameter: 'order_id=$orderId');

    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());
    checkAuth(apiAnswer.data);

    return apiAnswer;
  }

  Future<ApiAnswer> viewReview({required int orderId}) async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request = await dataRequestMultipart('order.reviews', parameter: 'itemid=$orderId');

    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());
    checkAuth(apiAnswer.data);

    return apiAnswer;
  }

  Future<ApiAnswer> sendReviewFermer({required int orderId, required int rating, required String comment}) async {
    ApiAnswer apiAnswer = ApiAnswer();
    var request = await dataRequestMultipart('order.comment', parameter: 'order_id=$orderId&rating=$rating&comment=$comment');

    apiAnswer.code = request.statusCode;
    apiAnswer.data = json.decode(await request.stream.bytesToString());
    checkAuth(apiAnswer.data);

    return apiAnswer;
  }
}
