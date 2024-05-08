part of 'role_bloc.dart';

sealed class RoleState extends Equatable {
  const RoleState();

  @override
  List<Object> get props => [];
}

final class RoleInitial extends RoleState {}

class RoleGot extends RoleState {
  final Role role;

  const RoleGot(this.role);

  @override
  List<Object> get props => [role];
}
