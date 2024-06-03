import 'package:agro/model/message/created.dart';
import 'package:agro/model/model_order/bids.dart';
import 'package:agro/model/model_order/model_contact.dart';
import 'package:intl/intl.dart';

class ModelOrder extends Created {
  int? id, harvestYear, sphere;
  String? title,
      crop,
      comment,
      region,
      capacity,
      count,
      payForm,
      payment,
      deliveryForm,
      sort,
      vidRabot;
  DateTime? startDate, endDate;
  bool? request, priceAdded;
  ModelContact? contact;
  List<Bid> bids;

  ModelOrder(
      {this.id,
      this.title,
      this.comment,
      this.capacity,
      this.count,
      this.crop,
      this.deliveryForm,
      this.endDate,
      this.harvestYear,
      this.priceAdded,
      this.payForm,
      this.payment,
      this.region,
      this.request,
      this.sort,
      this.startDate,
      this.vidRabot,
      this.contact,
      this.bids = const []});
}

extension OrderX on ModelOrder {
  String toText() {
    if (contact == null) {
      return toTextShort();
    } else {
      return toTextFull(contact);
    }
  }

  String toTextShort() {
    return "Заявка №$id від ${DateFormat('dd.MM.yyyy').format(startDate!)}\n"
        "Область: $region\n"
        "Культура: $crop\n"
        "Об’єм: $capacity\n"
        "Рік врожаю: $harvestYear\n"
        "Форма оплати: $payForm\n"
        "Тип доставки: $deliveryForm\n"
        "Коментар: $comment\n";
  }

  String toTextFull(ModelContact? contact) {
    return "Заявка №$id від ${DateFormat('dd.MM.yyyy').format(startDate!)}\n"
        "Область: $region\n"
        "Культура: $crop\n"
        "Об’єм: $capacity\n"
        "Рік врожаю: $harvestYear\n"
        "Форма оплати: $payForm\n"
        "Тип доставки: $deliveryForm\n"
        "Коментар: $comment\n"
        "${contact?.userName}\n"
        "Адреса: ${contact?.userRegion}\n"
        "${contact?.userDistrict}\n"
        "${contact?.userCity}\n"
        "E-mail: ${contact?.userEmail}\n"
        "Телефон: ${contact?.userPhone}\n";
  }
}
