import 'package:agro/model/model_review/model_review.dart';

structReview({required data}) {
  ModelReview modelReview = ModelReview();

  modelReview.traderId = data['trader_id'];
  modelReview.rating = data['rating'];
  modelReview.date = data['date'];
  modelReview.comment = data['comment'];

  return modelReview;
}
