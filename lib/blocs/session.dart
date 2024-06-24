import '../api/session.dart';
import 'shared.dart';
import 'package:bloc/bloc.dart';

abstract class SessionState {}

final class SessionCaptionUpdate extends GeneralState<SessionState> {
  final String sessionId;
  final String caption;

  SessionCaptionUpdate(this.sessionId, this.caption);
}

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

final class UpdateCaption extends SessionEvent {
  final String sessionId;
  final String caption;

  UpdateCaption(this.sessionId, this.caption);
}

final class SessionRewind extends SessionEvent {
  final String newToken;
  final SessionEvent rewindEvent;

  SessionRewind(this.newToken, this.rewindEvent);
}

final class SessionReset extends SessionEvent {}

final class SessionBloc extends Bloc<SessionEvent, GeneralState<SessionState>> {
  String? _newToken;

  SessionBloc() : super(RequestInit()) {
    on<SessionCreate>((event, emit) async {
      final token = _newToken ?? event.token;
      _newToken = null;
      await onEvent(event, emit, (event) => sessionCreate(token));
    });

    on<SessionDelete>((event, emit) async {
      final token = _newToken ?? event.token;
      _newToken = null;
      await onEvent(
          event, emit, (event) => sessionDelete(token, event.sessionId));
    });

    on<SessionGet>((event, emit) async {
      final token = _newToken ?? event.token;
      _newToken = null;
      await onEvent(event, emit, (event) => sessionGet(token, event.sessionId));
    });

    on<SessionList>((event, emit) async {
      final token = _newToken ?? event.token;
      _newToken = null;
      await onEvent(event, emit, (event) => sessionList(token));
    });

    on<UpdateCaption>((event, emit) =>
        emit(SessionCaptionUpdate(event.sessionId, event.caption)));

    on<SessionReset>((_, emit) => emit(RequestInit()));

    on<SessionRewind>((event, _) {
      _newToken = event.newToken;
      add(event.rewindEvent);
    });
  }
}
