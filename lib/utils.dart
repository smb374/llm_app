import 'dart:convert';

import 'package:http/http.dart';
import 'package:either_dart/either.dart';
import 'package:llm_app/models.dart';

const apiBase = "localhost:8080";
typedef JsonObject = Map<String, dynamic>;

T? cast<T>(x) => x is T ? x : null;

Future<Either<ErrorResponse, Response>> generalRequest<T>(
  String method,
  String endpoint,
  Object? body,
  Map<String, String>? headers,
) async {
  var req = Request(method, Uri.http(apiBase, "api/$endpoint"));
  if (headers != null) {
    headers.forEach((k, v) => req.headers[k] = v);
  }
  if (body != null) {
    req.body = jsonEncode(body);
  }

  final result = Either.tryExcept(() => req.send());
  if (result.isLeft) {
    final error =
        ErrorResponse('Failed to send request: ${result.left}', false);
    return Left(error);
  }

  final resp = await Response.fromStream(await result.right);
  if (resp.statusCode < 200 || resp.statusCode >= 300) {
    final body = ErrorResponse.fromJson(jsonDecode(resp.body));
    final error =
        'API Request to endpoint "$endpoint" failed with status ${resp.statusCode}: ${body.error}';
    return Left(ErrorResponse(error, body.refresh));
  }
  return Right(resp);
}

Future<Either<ErrorResponse, T>> genericRequest<T>(
  String method,
  String endpoint,
  Object? body,
  Map<String, String>? headers,
  T Function(String) bodyParser,
) async {
  final result = await generalRequest(method, endpoint, body, headers);

  if (result.isLeft) {
    return Left(result.left);
  }

  final resp = result.right;
  final parseResult = Either.tryExcept(() => bodyParser(resp.body));

  if (parseResult.isLeft) {
    return Left(ErrorResponse("${parseResult.left}", false));
  } else {
    return Right(parseResult.right);
  }
}

Future<Either<ErrorResponse, Null>> nullRequest(
  String method,
  String endpoint,
  Object? body,
  Map<String, String>? headers,
) async {
  final result = await generalRequest(method, endpoint, body, headers);

  if (result.isLeft) {
    return Left(result.left);
  }

  return const Right(null);
}
