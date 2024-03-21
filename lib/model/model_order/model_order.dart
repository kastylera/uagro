import 'package:agro/model/message/created.dart';

class ModelOrder extends Created {
  int? id, harvestYear, sphere;
  String? title, crop, comment, region, capacity, count, payForm, payment, deliveryForm, sort, vidRabot;
  DateTime? startDate, endDate;
  bool? request, priceAdded;

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
      this.vidRabot});
}