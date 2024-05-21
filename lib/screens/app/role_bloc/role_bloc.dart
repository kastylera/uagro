import 'package:agro/model/model_user/model_user.dart';
import 'package:agro/storage/user_data_storage.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loggy/loggy.dart';

part 'role_event.dart';
part 'role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  final UserDataStorage _userDataStorage;

  RoleBloc(this._userDataStorage) : super(RoleInitial()) {
    on<GetRole>((event, emit) async {
      try {
        final role = (await _userDataStorage.getUser())!.getRole();
        emit(RoleGot(role));
      } catch (e) {
        logError(e.toString());
      }
    });
  }
}
