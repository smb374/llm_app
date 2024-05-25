part of '../user.dart';

typedef UserRegisterResponse = Null;

final class UserState {}

final class UserTokenRefreshed extends GeneralState<UserState> {
  final String token;
  UserTokenRefreshed(this.token);
}

final class UserLoginAgain extends GeneralState<UserState> {}
