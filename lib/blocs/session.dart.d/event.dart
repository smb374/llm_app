part of '../session.dart';

abstract class SessionEvent {}

final class SessionCreate extends SessionEvent {
  final String token;

  SessionCreate(this.token);
}

final class SessionDelete extends SessionEvent {
  final String token;
  final String sessionId;

  SessionDelete(this.token, this.sessionId);
}

final class SessionGet extends SessionEvent {
  final String token;
  final String sessionId;

  SessionGet(this.token, this.sessionId);
}

final class SessionList extends SessionEvent {
  final String token;

  SessionList(this.token);
}
