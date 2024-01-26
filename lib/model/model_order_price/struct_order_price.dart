import 'model_order_price.dart';

ModelOrderPrice structOrderPriceData({required data}) {
  ModelOrderPrice modelOrderPrice = ModelOrderPrice();

  modelOrderPrice.id = data['id'];
  modelOrderPrice.cost = data['cost'];
  modelOrderPrice.createdAt = data['created_at'];
  modelOrderPrice.traiderId = data['trader_contact']['id'].toString();
  modelOrderPrice.traiderPhone = data['trader_contact']['phone'];
  modelOrderPrice.traiderName = data['trader_contact']['name'];
  modelOrderPrice.isMy = data['is_my'];

  return modelOrderPrice;
}
