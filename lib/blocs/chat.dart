import '../api/chat.dart';
import 'shared.dart';
import 'package:bloc/bloc.dart';

part 'chat.dart.d/event.dart';
part 'chat.dart.d/state.dart';

final class ChatBloc extends Bloc<ChatEvent, GeneralState<ChatState>> {
  ChatBloc() : super(RequestInit()) {
    on<ChatRequest>((event, emit) => onEvent(event, emit,
        (event) => chat(event.token, event.sessionId, event.prompt)));

    on<ChatProgressConnect>((event, emit) => onEvent(
        event, emit, (event) => chatProgress(event.token, event.statusId)));
  }
}
