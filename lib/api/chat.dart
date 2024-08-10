import 'dart:convert';

import 'package:either_dart/either.dart';
import '../models.dart';
import '../utils.dart';
import 'package:web_socket_channel/io.dart';

Future<Either<ErrorResponse, ProgressResponse>> chat(
  String token,
  String sessionId,
  String prompt,
) async {
  return genericRequest(
    'POST',
    'chat',
    {'sid': sessionId, 'content': prompt},
    {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    (body) => ProgressResponse.fromJson(jsonDecode(body)),
  );
}

Future<Either<ErrorResponse, Stream<ChatProgress>>> chatProgress(
  String token,
  String statusId,
) async {
  final uri = Uri.parse('wss://$apiBase/api/chat/status/$statusId');
  final result = Either.tryExcept(() => IOWebSocketChannel.connect(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      ));

  if (result.isLeft) {
    return Left(
        ErrorResponse('Failed to connect chat status: ${result.left}', false));
  }

  final channel = result.right;

  await channel.ready;

  final stream = channel.stream.asyncMap((message) async {
    final progress = ChatProgress.fromJson(jsonDecode(message));
    if (progress.end) {
      await channel.sink.close();
    }
    return progress;
  });

  return Right(stream);
}
