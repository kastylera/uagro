import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:uuid/uuid.dart';

enum NotificationType { offer, weeklyEarned, earningLimitExceeded, unknown }

class MuzosNotification {
  final String messageId;
  final NotificationType type;
  MuzosNotification({required this.messageId, this.type = NotificationType.unknown});

  factory MuzosNotification.from(RemoteMessage? message) {
      final messageId = message?.messageId ?? const Uuid().v4().toString();

    switch (message?.data["notificationType"] ?? "") {
      case "offer":
        return OfferNotification(messageId: messageId,
            offerId: message?.data["offerId"] ?? 'unknownOfferId');
      case "weeklyEarned":
        return WeeklyEarnedNotification(messageId: messageId,);

      case "earningLimitExceeded":
        return EarningLimitExceededNotification(messageId: messageId,);

      default:
        return MuzosNotification(messageId: messageId,);
    }
  }
}

class OfferNotification extends MuzosNotification {
  OfferNotification(
      {required super.messageId, super.type = NotificationType.offer, required this.offerId});
  final String offerId;
}

class WeeklyEarnedNotification extends MuzosNotification {
  WeeklyEarnedNotification({required super.messageId, super.type = NotificationType.weeklyEarned});
}

class EarningLimitExceededNotification extends MuzosNotification {
  EarningLimitExceededNotification(
      {required super.messageId, super.type = NotificationType.earningLimitExceeded});
}
