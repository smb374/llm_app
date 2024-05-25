part of '../user.dart';

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
