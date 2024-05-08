import 'dart:async';

import 'package:agro/repositories/auth_repository.dart';
import 'package:agro/screens/app/push_notifications_bloc/push_notifications_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loggy/loggy.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>
    with UiLoggy {
  AuthenticationBloc(
    this._pushNotificationsBloc, {
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(_AuthenticationStatusChanged(status)),
    );
  }

  final PushNotificationsBloc _pushNotificationsBloc;
  final AuthenticationRepository _authenticationRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Future<void> _onAuthenticationStatusChanged(
    _AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        final token = await _tryGetToken();
        if (token == null) {
          return emit(const AuthenticationState.unauthenticated());
        } else {
          await _onAuthenticated(emit);
        }
      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
    }
  }

  Future<void> _onAuthenticated(Emitter<AuthenticationState> emit) async {
    //TODO get tariff

    // try {
    //   await _userRepository.getMe();
    // } on UnknownRole {
    //   final userId = await _userDataStorage.getUserId();
    //   await _userRepository.setRole(userId!);
    // } catch(e){
    //   loggy.debug(e.toString());
    // }
    emit(const AuthenticationState.authenticated());
    try {
      await _registerFCMToken();
      await _pushNotificationsBloc.askForPermissionIfNeeded();
    } catch (e) {
      loggy.debug(e.toString());
    }
  }

  Future _registerFCMToken() async {
    try {
      await _pushNotificationsBloc.registerFCMToken();
    } on Exception catch (exception) {
      loggy.error(exception.toString());
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _authenticationRepository.logOut();
  }

  Future<String?> _tryGetToken() async {
    try {
      final token = await _authenticationRepository.getToken();
      return token;
    } catch (_) {
      return null;
    }
  }
}
