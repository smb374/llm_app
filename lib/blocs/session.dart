import '../api/session.dart';
import 'shared.dart';
import 'package:bloc/bloc.dart';

part 'session.dart.d/event.dart';
part 'session.dart.d/state.dart';

final class SessionBloc extends Bloc<SessionEvent, GeneralState<SessionState>> {
  SessionBloc() : super(RequestInit()) {
    on<SessionCreate>((event, emit) =>
        onEvent(event, emit, (event) => sessionCreate(event.token)));

    on<SessionDelete>((event, emit) => onEvent(
        event, emit, (event) => sessionDelete(event.token, event.sessionId)));

    on<SessionGet>((event, emit) => onEvent(
        event, emit, (event) => sessionGet(event.token, event.sessionId)));

    on<SessionList>((event, emit) =>
        onEvent(event, emit, (event) => sessionList(event.token)));
  }
}
