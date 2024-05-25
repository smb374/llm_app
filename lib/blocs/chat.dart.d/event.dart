part of '../chat.dart';

abstract class ChatEvent {}

final class ChatRequest extends ChatEvent {
  final String token;
  final String sessionId;
  final String prompt;

  ChatRequest(this.token, this.sessionId, this.prompt);
}

final class ChatProgressConnect extends ChatEvent {
  final String token;
  final String statusId;

  ChatProgressConnect(this.token, this.statusId);
}
