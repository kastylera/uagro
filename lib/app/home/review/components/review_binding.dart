import 'package:agro/app/home/review/components/review_controller.dart';
import 'package:get/get.dart';

class ReviewBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut<ReviewController>(() => ReviewController());
}
