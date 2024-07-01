import 'dart:developer';

import 'package:agro/model/model_order/bids.dart';
import 'package:agro/model/model_order/model_contact.dart';
import 'package:agro/model/model_order/quality.dart';
import 'model_order.dart';
import 'package:intl/intl.dart';

ModelOrder structOrderData({required data}) {
  ModelOrder modelOrder = ModelOrder();

  modelOrder.id = data['id'];
  modelOrder.title = data['title'].toString();
  modelOrder.crop = data['crop'].toString();
  modelOrder.comment = data['comment'].toString();
  modelOrder.region = data['region'].toString();
  modelOrder.capacity = data['capacity'].toString();
  modelOrder.count = data['count'].toString();
  modelOrder.harvestYear = int.tryParse(data['harvest_year'].toString());
  modelOrder.payForm = data['pay_form'].toString();
  modelOrder.payment = data['payment'].toString();
  modelOrder.deliveryForm = data['delivery_form'].toString();
  modelOrder.request = data['request'];
  modelOrder.sort = data['sort'].toString();
  modelOrder.vidRabot = data['vid_rabot'].toString();
  modelOrder.priceAdded = data['price_added'];

  modelOrder.sphere = int.tryParse(data['sphere_id'].toString()) ??
      int.tryParse(data['sphere'].toString());

  try {
    if (data['contacts'] != null) {
      var contact = ModelContact();
      contact.userName = data['contacts']['name'];
      contact.userRegion = data['contacts']['region'];
      contact.userDistrict = data['contacts']['district'];
      contact.userCity = data['contacts']['city'];
      contact.userEmail = data['contacts']['email'];
      contact.userPhone = data['contacts']['phone'];
      modelOrder.contact = contact;
    }
  } catch (e) {
    log("Parse contact error $e");
  }

  try {
    if (data['contacts'] != null) {
      var contact = ModelContact();
      contact.userName = data['contacts']['name'];
      contact.userRegion = data['contacts']['region'];
      contact.userDistrict = data['contacts']['district'];
      contact.userCity = data['contacts']['city'];
      contact.userEmail = data['contacts']['email'];
      contact.userPhone = data['contacts']['phone'];
      modelOrder.contact = contact;
    }
  } catch (e) {
    log("Parse contact error $e");
  }

  try {
    if (data['bids'] != null) {
      final Map<String, dynamic> map = data['bids'];
      List<Bid> bids = [];
      for (var element in map.values) {
        final item = Bid();
        item.created = int.tryParse(element['created'].toString());
        item.priceList = element['pricelist'].toString();
        bids.add(item);
      }
      modelOrder.bids = bids;
      log(map.values.toString());
    }
  } catch (e) {
    log("Parse bids error $e");
  }

  try {
    if (data['quality'] != null) {
      final map = data['quality'];
      var quality = Quality();
      quality.open = int.tryParse(map['open'].toString());
      quality.sent = int.tryParse(map['sent'].toString());
      quality.qual = map['qual'];
      modelOrder.quality = quality;
      log(map.values.toString());
    }
  } catch (e) {
    log("Parse quality error $e");
  }

  DateFormat format = DateFormat('dd.MM.yyyy HH:mm');
  modelOrder.startDate =
      format.parse('${data['start_date']} ${data['start_time']}');
  modelOrder.endDate = format.parse('${data['end_date']} ${data['end_time']}');
  modelOrder.createdAt = modelOrder.startDate;

  return modelOrder;
}
