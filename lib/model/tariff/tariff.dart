import 'package:intl/intl.dart';

class Tariff {
  String? vip, premium, balanceName;
  int? balanceContacts,
      balanceSms,
      balanceContactsDayTotal,
      balanceContactsDayOsttk,
      tafiffId;
  DateTime? balanceEnd;

  Tariff.fromJson(Map<String, dynamic> json) {
    vip = json['is_vip'];
    premium = json['is_premium'];
    balanceName = json['balance_name'];

    balanceContacts = int.tryParse(json['balance_contacts'].toString());
    balanceSms = int.tryParse(json['balance_sms'].toString());
    balanceContactsDayTotal =
        int.tryParse(json['balance_contacts_day_total'].toString());
    balanceContactsDayOsttk =
        int.tryParse(json['balance_contacts_day_osttk'].toString());
    tafiffId = int.tryParse(json['tariff_id'].toString());

    DateFormat format = DateFormat('dd.MM.yyyy');
    balanceEnd =
        json['balance_end'] != null ? format.parse(json['balance_end']) : null;
  }
}

extension TariffX on Tariff {
  bool get isPremium => premium == "Y";
  bool get isVip => vip == "Y";
}
