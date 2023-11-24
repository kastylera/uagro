import 'model_order.dart';
import 'package:intl/intl.dart';

structOrderData({required data}) {
  ModelOrder modelOrder = ModelOrder();

  modelOrder.id = data['id'];
  modelOrder.title = data['title'];
  modelOrder.crop = data['crop'];
  modelOrder.comment = data['comment'];
  modelOrder.region = data['region'];
  modelOrder.capacity = data['capacity'];
  modelOrder.count = data['count'];
  modelOrder.harvestYear = int.tryParse(data['harvest_year'].toString());
  modelOrder.payForm = data['pay_form'];
  modelOrder.payment = data['payment'];
  modelOrder.deliveryForm = data['delivery_form'];
  modelOrder.request = data['request'];
  modelOrder.sort = data['sort'];
  modelOrder.vidRabot = data['vid_rabot'];
  modelOrder.priceAdded = data['price_added'];

  DateFormat format = DateFormat('dd.MM.yyyy HH:mm');
  modelOrder.startDate = format.parse('${data['start_date']} ${data['start_time']}');
  modelOrder.endDate = format.parse('${data['end_date']} ${data['end_time']}');

  return modelOrder;
}
