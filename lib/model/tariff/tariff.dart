import 'package:intl/intl.dart';

class Tariff {
  String? vip, balanceName;
  int? balanceContacts,
      balanceSms,
      balanceContactsDayTotal,
      balanceContactsDayOsttk,
      tafiffId;
  DateTime? balanceEnd;

  Tariff.fromJson(Map<String, dynamic> json) {
    vip = json['is_vip'];
    balanceName = json['balance_name'];
    balanceContacts = json['balance_contacts'];
    balanceSms = json['balance_sms'];
    balanceContactsDayTotal = json['balance_contacts_day_total'];
    balanceContactsDayOsttk = json['balance_contact_day_osttk'];
    tafiffId = json['tariff_id'];
    DateFormat format = DateFormat('dd.MM.yyyy');
    balanceEnd = format.parse(json['balance_end']);
  }
}

extension TariffX on Tariff {
  bool get isExclusive => balanceName == "Exclusive";
  bool get isVip => true;
}
