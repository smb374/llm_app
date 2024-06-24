import 'dart:convert';

import 'package:either_dart/either.dart';
import '../models.dart';
import '../utils.dart';
import 'package:uuid/uuid.dart';

Future<Either<ErrorResponse, SessionListResponse>> sessionList(
  String token,
) async {
  return genericRequest(
    'GET',
    'session/list',
    null,
    {'Authorization': 'Bearer $token'},
    (body) => SessionListResponse.fromJson(jsonDecode(body)),
  );
}

Future<Either<ErrorResponse, SessionCreateResponse>> sessionCreate(
  String token,
) async {
  return genericRequest(
    'PUT',
    'session/create',
    null,
    {'Authorization': 'Bearer $token'},
    (body) => SessionCreateResponse.fromJson(jsonDecode(body)),
  );
}

Future<Either<ErrorResponse, SessionDeleteResponse>> sessionDelete(
  String token,
  String sessionId,
) async {
  if (!Uuid.isValidUUID(fromString: sessionId)) {
    return Left(ErrorResponse('Session id is not a valid UUID', false));
  }

  return genericRequest(
    'DELETE',
    'session/delete/$sessionId',
    null,
    {'Authorization': 'Bearer $token'},
    (_) => SessionDeleteResponse(sessionId),
  );
}

Future<Either<ErrorResponse, SessionGetResponse>> sessionGet(
  String token,
  String sessionId,
) async {
  if (!Uuid.isValidUUID(fromString: sessionId)) {
    return Left(ErrorResponse('Session id is not a valid UUID', false));
  }

  return genericRequest(
    'GET',
    'session/$sessionId',
    null,
    {'Authorization': 'Bearer $token'},
    (body) => SessionGetResponse.fromJson(jsonDecode(body)),
  );
}
