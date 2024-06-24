import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:llm_app/models.dart';

mixin TokenEvent {
  void setToken(String newToken);
}

abstract class GeneralState<S> {}

final class RequestInit<S> extends GeneralState<S> {
  @override
  String toString() {
    return 'RequestInit<${S.toString()}>';
  }
}

final class RequestInProgress<S, E> extends GeneralState<S> {
  @override
  String toString() {
    return 'RequestInProgress<${S.toString()}, ${E.toString()}>';
  }
}

final class RequestSuccess<S, R> extends GeneralState<S> {
  final R resp;

  RequestSuccess(this.resp);

  @override
  String toString() {
    return 'RequestSuccess<${S.toString()}, ${R.toString()}>';
  }
}

final class RequestFailed<S, E> extends GeneralState<S> {
  final String error;

  RequestFailed(this.error);

  @override
  String toString() {
    return 'RequestFailed<${S.toString()}, ${E.toString()}>';
  }
}

final class TokenExpired<S, E> extends GeneralState<S> {
  final E event;

  TokenExpired(this.event);

  @override
  String toString() {
    return 'TokenExpired<${S.toString()}, ${E.toString()}>';
  }
}

Future<void> onEvent<S, E, R>(
  E event,
  Emitter<GeneralState<S>> emit,
  Future<Either<ErrorResponse, R>> Function(E) apiCall,
) async {
  emit(RequestInProgress<S, E>());
  final result = await apiCall(event);

  if (result.isLeft) {
    if (result.left.refresh) {
      emit(TokenExpired<S, E>(event));
    } else {
      emit(RequestFailed<S, E>(result.left.error));
    }
  } else {
    emit(RequestSuccess<S, R>(result.right));
  }
}
