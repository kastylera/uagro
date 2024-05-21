part of 'push_notifications_bloc.dart';

abstract class PushNotificationsState extends Equatable {
  const PushNotificationsState();

  @override
  List<Object?> get props => [];
}

class PushNotificationsInitial extends PushNotificationsState {}
