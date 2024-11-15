import 'dart:convert';

import 'package:http/http.dart';
import 'package:either_dart/either.dart';
import 'package:llm_app/models.dart';
import 'package:llm_app/utils.dart';

Future<Either<ErrorResponse, T>> _searchBased<T>(
  String endpoint,
  SearchParams params,
  Map<String, String>? extraParams,
  DateTime queryTime,
  T Function(String) bodyParser,
) async {
  var paramMap = params.toMap();
  if (extraParams != null) {
    paramMap.addAll(extraParams);
  }
  paramMap['_'] = '${queryTime.millisecondsSinceEpoch}';

  final uri = Uri.https(apiBase, 'api/search/$endpoint', paramMap);
  final req = Request('GET', uri);
  final result = Either.tryExcept(() => req.send());
  if (result.isLeft) {
    return Left(ErrorResponse('Failed to send request: ${result.left}', false));
  }

  final resp = await Response.fromStream(await result.right);
  if (resp.statusCode < 200 || resp.statusCode >= 300) {
    final error =
        'API Request to endpoint "$endpoint" failed with status ${resp.statusCode}.';
    return Left(ErrorResponse(error, false));
  }

  final parseResult = Either.tryExcept(() => bodyParser(resp.body));

  if (parseResult.isLeft) {
    return Left(ErrorResponse('${parseResult.left}', false));
  } else {
    return Right(parseResult.right);
  }
}

Future<Either<ErrorResponse, SearchReportResponse>> searchReport(
  SearchParams params,
  int rows,
  int page,
  DateTime queryTime,
) async {
  return _searchBased(
      'report',
      params,
      {
        'rows': '$rows',
        'page': '$page',
      },
      queryTime,
      (body) => SearchReportResponse.fromJson(jsonDecode(body)));
}

Future<Either<ErrorResponse, SearchLevelResponse>> searchLevel(
    SearchParams params, DateTime queryTime) async {
  return _searchBased('level', params, null, queryTime,
      (body) => SearchLevelResponse.fromJson(jsonDecode(body)));
}

Future<Either<ErrorResponse, SearchCaseResponse>> searchCase(
    SearchParams params, DateTime queryTime) async {
  return _searchBased('case', params, null, queryTime,
      (body) => SearchCaseResponse.fromJson(jsonDecode(body)));
}

Future<Either<ErrorResponse, ReportResponse>> getReport(String id) async {
  final uri = Uri.https(apiBase, 'api/search/report/$id',
      {'_': '${DateTime.now().millisecondsSinceEpoch}'});

  final req = Request('GET', uri);
  final result = Either.tryExcept(() => req.send());
  if (result.isLeft) {
    return Left(ErrorResponse('Failed to send request: ${result.left}', false));
  }

  final resp = await Response.fromStream(await result.right);
  if (resp.statusCode < 200 || resp.statusCode >= 300) {
    final error =
        'API Request to get report failed with status ${resp.statusCode}.';
    return Left(ErrorResponse(error, false));
  }

  final parseResult =
      Either.tryExcept(() => ReportResponse.fromJson(jsonDecode(resp.body)));

  if (parseResult.isLeft) {
    return Left(ErrorResponse('${parseResult.left}', false));
  } else {
    return Right(parseResult.right);
  }
}
