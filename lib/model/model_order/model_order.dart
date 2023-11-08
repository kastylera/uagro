class ModelOrder {
  int? id, harvestYear;
  String? title, crop, comment, region, capacity, count, payForm, payment, deliveryForm, sort, vidRabot;
  DateTime? startDate, endDate;
  bool? request, priceAdded;
  String? userName, userRegion, userDistrict, userCity, userEmail, userPhone;

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
      this.userCity,
      this.userDistrict,
      this.userEmail,
      this.userName,
      this.userPhone,
      this.userRegion});
}