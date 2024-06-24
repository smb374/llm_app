import 'shared.dart';
import '../api/user.dart';
import 'package:bloc/bloc.dart';

abstract class UserState {}

final class UserTokenRefreshed extends GeneralState<UserState> {
  final String token;
  UserTokenRefreshed(this.token);
}

final class UserLoginAgain extends GeneralState<UserState> {}

final class UserLogout extends GeneralState<UserState> {}

final class UserNeedRefresh extends GeneralState<UserState> {}

abstract class UserEvent {}

final class Login extends UserEvent {
  final String email;
  final String password;

  Login(this.email, this.password);
}

final class Register extends UserEvent {
  final String name;
  final String email;
  final String password;

  Register(this.name, this.email, this.password);
}

final class Refresh extends UserEvent {
  final String refreshToken;

  Refresh(this.refreshToken);
}

final class Profile extends UserEvent {
  final String token;

  Profile(this.token);
}

final class Logout extends UserEvent {}

final class LoginAgain extends UserEvent {}

final class NeedRefresh extends UserEvent {}

final class UserRewind extends UserEvent {
  final String newToken;
  final UserEvent rewindEvent;

  UserRewind(this.newToken, this.rewindEvent);
}

final class UserReset extends UserEvent {}

final class UserBloc extends Bloc<UserEvent, GeneralState<UserState>> {
  String? _newToken;

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
          emit(RequestFailed<UserState, Refresh>(result.left.error));
        }
      } else {
        emit(UserTokenRefreshed(result.right.newToken));
      }
    });

    on<Profile>((event, emit) async {
      final token = _newToken ?? event.token;
      _newToken = null;
      await onEvent(event, emit, (event) => profile(token));
    });

    on<Logout>((_, emit) => emit(UserLogout()));
    on<UserReset>((_, emit) => emit(RequestInit()));
    on<NeedRefresh>((_, emit) => emit(UserNeedRefresh()));
    on<UserRewind>((event, _) {
      _newToken = event.newToken;
      add(event.rewindEvent);
    });
  }
}
