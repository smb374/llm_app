import 'dart:convert';

import '../utils.dart';
import '../models.dart';
import 'package:either_dart/either.dart';

Future<Either<ErrorResponse, User>> profile(
  String token,
) async {
  return genericRequest(
    'GET',
    'profile',
    null,
    {'Authorization': 'Bearer $token'},
    (body) => User.fromJson(jsonDecode(body)),
  );
}

Future<Either<ErrorResponse, UserRegisterResponse>> userRegister(
  String name,
  String email,
  String password,
) async {
  return genericRequest(
    'POST',
    'signup',
    {'name': name, 'email': email, 'password': password},
    {'Content-Type': 'application/json'},
    (_) => UserRegisterResponse(),
  );
}

Future<Either<ErrorResponse, UserLoginResponse>> userLogin(
  String email,
  String password,
) async {
  return genericRequest(
    'POST',
    'login',
    {'email': email, 'password': password},
    {'Content-Type': 'application/json'},
    (body) => UserLoginResponse.fromJson(jsonDecode(body)),
  );
}

Future<Either<ErrorResponse, UserRefreshResponse>> userRefresh(
    String refreshToken) async {
  return genericRequest(
    'POST',
    'refresh',
    {'token': refreshToken},
    {'Content-Type': 'application/json'},
    (body) => UserRefreshResponse.fromJson(jsonDecode(body)),
  );
}
