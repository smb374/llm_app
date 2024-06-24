import '../api/chat.dart';
import 'shared.dart';
import 'package:bloc/bloc.dart';

abstract class ChatState {}

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

final class ChatRewind extends ChatEvent {
  final String newToken;
  final ChatEvent rewindEvent;

  ChatRewind(this.newToken, this.rewindEvent);
}

final class ChatReset extends ChatEvent {}

final class ChatBloc extends Bloc<ChatEvent, GeneralState<ChatState>> {
  String? _newToken;

  ChatBloc() : super(RequestInit()) {
    on<ChatRequest>((event, emit) async {
      final token = _newToken ?? event.token;
      _newToken = null;
      await onEvent(
          event, emit, (event) => chat(token, event.sessionId, event.prompt));
    });

    on<ChatProgressConnect>((event, emit) async {
      final token = _newToken ?? event.token;
      _newToken = null;
      await onEvent(
          event, emit, (event) => chatProgress(token, event.statusId));
    });

    on<ChatReset>((_, emit) => emit(RequestInit()));

    on<ChatRewind>((event, _) {
      _newToken = event.newToken;
      add(event.rewindEvent);
    });
  }
}
