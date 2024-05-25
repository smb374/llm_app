import 'shared.dart';
import '../api/user.dart';
import 'package:bloc/bloc.dart';

part 'user.dart.d/event.dart';
part 'user.dart.d/state.dart';

final class UserBloc extends Bloc<UserEvent, GeneralState<UserState>> {
  UserBloc() : super(RequestInit()) {
    on<Login>((event, emit) => onEvent(
        event, emit, (event) => userLogin(event.email, event.password)));

    on<Register>((event, emit) => onEvent(event, emit,
        (event) => userRegister(event.name, event.email, event.password)));

    on<Refresh>((event, emit) async {
      emit(RequestInProgress());
      final result = await userRefresh(event.refreshToken);

      if (result.isLeft) {
        if (result.left.refresh) {
          emit(UserLoginAgain());
        } else {
          emit(RequestFailed(result.left.error));
        }
      } else {
        emit(UserTokenRefreshed(result.right.newToken));
      }
    });

    on<Profile>(
        (event, emit) => onEvent(event, emit, (event) => profile(event.token)));
  }
}
