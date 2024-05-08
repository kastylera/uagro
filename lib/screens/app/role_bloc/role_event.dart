part of 'role_bloc.dart';

sealed class RoleEvent extends Equatable {
  const RoleEvent();

  @override
  List<Object> get props => [];
}

class GetRole extends RoleEvent {}

class SetRole extends RoleEvent {
  const SetRole(this.role);

  final Role role;
  @override
  List<Object> get props => [role];
}
