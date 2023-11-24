import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';

import '../../routes/app_pages.dart';
import 'controller/auth.dart';
import 'controller/fermer.dart';
import 'controller/traider.dart';

int numRequestSend = 0;

class Api {
  // var headers = {
  //   // 'Authorization': 'Bearer ${Hive.box('data').get('modelUser') != null ? Hive.box('data').get('modelUser').token : ''}',
  //   'Authorization': 'Bearer ${Hive.box('data').get('modelUser') != null ? Hive.box('data').get('modelUser').token : ''}',
  //   'Content-Type': 'application/json',
  // };
  //Hive.box('data').get('modelUser');
  Map<String, String> headers() => {
        // 'Authorization': 'Bearer ${Hive.box('data').get('modelUser') != null ? Hive.box('data').get('modelUser').token : ''}',
        // 'Authorization':
        //     'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwZXJzb25hbF9pZCI6Ijg1MDA3MjgzMDEiLCJleHAiOjE2OTI4MDYwNTV9.ZZ_IYoJrXv96qxRDYkicpD2IV0CaFcvtdJhJasq2UqU',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };

  Map<String, String> headersNoBearer() => {'Content-Type': 'application/json', 'Accept': 'application/json'};

  final url = 'https://uagro.trade/apiapp.php';

  Future<StreamedResponse> dataRequest(path,
      {String req = 'POST', String? parameter, bool urlActive = true, bool bearerActive = true, String? body, required BuildContext c}) async {
    StreamedResponse request = await ((Request(req, Uri.parse('${urlActive ? url : ''}$path?${parameter ?? ''}')))
          ..headers.addAll(bearerActive ? headers() : headersNoBearer())
          ..body = body ?? json.encode({}))
        .send();

    log('$url$path${parameter ?? ''}');

    return request;
  }

  Future<StreamedResponse> dataRequestMultipart(method,
      {String? parameter, bool urlActive = true, bool bearerActive = true, Map<String, String>? formData}) async {
    var request = MultipartRequest(
        'POST',
        Uri.parse('${urlActive ? url : ''}?method=$method&'
            'key=${Hive.box('data').get('modelUser') == null || Hive.box('data').get('modelUser').token == null ? '' : Hive.box('data').get('modelUser').token}${parameter == null ? '' : '&$parameter'}'));

    request.headers.addAll(bearerActive ? headers() : headersNoBearer());

    if (formData != null) {
      formData.forEach((key, value) {
        request.fields[key] = value;
      });
    }

//    await request.send();
//
// print(request)
    return await request.send();
  }

  Auth get auth => Auth();

  Fermer get fermer => Fermer();

  Traider get traider => Traider();
}

class ApiAnswer {
  int? code;
  var data;
}

void checkAuth(data) {
  log('data: $data');
  try {
    if (data['message'] == 'Unauthorized') {
      Hive.box('data').put('pinCode', null);
      Hive.box('data').clear();

      Get.offAllNamed(Routes.auth);
    }
  } catch (_) {}
}
