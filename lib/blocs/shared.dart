import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:llm_app/models.dart';

abstract class GeneralState<S> {}

final class RequestInit<S> extends GeneralState<S> {}

final class RequestInProgress<S> extends GeneralState<S> {}

final class RequestSuccess<S, T> extends GeneralState<S> {
  final T resp;

  RequestSuccess(this.resp);
}

final class RequestFailed<S> extends GeneralState<S> {
  final String error;

  RequestFailed(this.error);
}

final class TokenExpired<S> extends GeneralState<S> {}

Future<void> onEvent<E, S, R>(
  E event,
  Emitter<GeneralState<S>> emit,
  Future<Either<ErrorResponse, R>> Function(E) apiCall,
) async {
  emit(RequestInProgress());
  final result = await apiCall(event);

  if (result.isLeft) {
    if (result.left.refresh) {
      emit(TokenExpired());
    } else {
      emit(RequestFailed(result.left.error));
    }
  } else {
    emit(RequestSuccess(result.right));
  }
}
