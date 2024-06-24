import 'package:bloc/bloc.dart';

enum PageState {
  init,
  login,
  search,
  session,
}

abstract class PageEvent {}

final class SwitchLogin extends PageEvent {}

final class SwitchSearch extends PageEvent {}

final class SwitchSession extends PageEvent {}

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(PageState.init) {
    on<SwitchLogin>((_, emit) => emit(PageState.login));
    on<SwitchSearch>((_, emit) => emit(PageState.search));
    on<SwitchSession>((_, emit) => emit(PageState.session));
  }
}
