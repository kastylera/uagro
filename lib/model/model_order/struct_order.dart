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

  DateFormat format = DateFormat('dd.MM.yyyy HH:mm');
  modelOrder.startDate =
      format.parse('${data['start_date']} ${data['start_time']}');
  modelOrder.endDate = format.parse('${data['end_date']} ${data['end_time']}');
  modelOrder.createdAt = modelOrder.startDate;

  return modelOrder;
}
