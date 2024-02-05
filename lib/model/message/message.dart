import 'package:agro/model/message/created.dart';
import 'package:intl/intl.dart';

class Message extends Created {
  int? id, readed, tenderId;
  String? type, title, message;

  Message.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    readed = int.tryParse(json['readed'].toString());
    tenderId = int.tryParse(json['tender_id'].toString());

    type = json['type'].toString();
    title = json['title'].toString();
    message = json['message'].toString();

    DateFormat format = DateFormat('dd.MM.yyyy HH:mm');
    createdAt = format.parse(json['created_human']);
  }

  bool get isRead => readed == 1;
}
