import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:either_dart/either.dart';
import 'package:llm_app/models.dart';

const apiBase = 'iguana-composed-redfish.ngrok-free.app';
typedef JsonObject = Map<String, dynamic>;

T? cast<T>(x) => x is T ? x : null;

Future<Either<ErrorResponse, Response>> generalRequest<T>(
  String method,
  String endpoint,
  Object? body,
  Map<String, String>? headers,
) async {
  var req = Request(method, Uri.https(apiBase, 'api/$endpoint'));
  if (headers != null) {
    headers.forEach((k, v) => req.headers[k] = v);
  }
  req.headers['ngrok-skip-browser-warning'] = '1';
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
  print("OK");
  if (resp.statusCode < 200 || resp.statusCode >= 300) {
    final contentType = resp.headers['content-type'];
    if (contentType == 'application/json') {
      final body = ErrorResponse.fromJson(jsonDecode(resp.body));
      final error =
          'API Request to endpoint "$endpoint" failed with status ${resp.statusCode}: ${body.error}';
      return Left(ErrorResponse(error, body.refresh));
    } else if (contentType == 'text/html') {
      final error =
          'API Request to endpoint "$endpoint" failed with status ${resp.statusCode}: Proxy to server failed.';
      return Left(ErrorResponse(error, false));
    } else {
      final error =
          'API Request to endpoint "$endpoint" failed with status ${resp.statusCode}: Unknown Error';
      return Left(ErrorResponse(error, false));
    }
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
    return Left(ErrorResponse('${parseResult.left}', false));
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

Future<T?> generalAlert<T>(BuildContext context, String title, String content) {
  return showDialog<T>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ));
}

Future<bool> retryAlert(
    BuildContext context, String title, String content) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Retry'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
      ],
    ),
  );

  return result != null && result;
}

void showTokenExpiredSnackbar(BuildContext context) {
  final tokenAlert = SnackBar(
    content: const Text('Token expired, refresh...'),
    action: SnackBarAction(label: 'OK', onPressed: () {}),
  );
  ScaffoldMessenger.of(context).showSnackBar(tokenAlert);
}

void showTokenRefreshedSnackbar(BuildContext context) {
  final tokenAlert = SnackBar(
    content: const Text('Token refreshed'),
    action: SnackBarAction(label: 'OK', onPressed: () {}),
  );
  ScaffoldMessenger.of(context).showSnackBar(tokenAlert);
}
