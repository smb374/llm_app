import 'package:either_dart/either.dart';
import 'package:llm_app/models.dart';

import '../api/search.dart';
import 'shared.dart';
import 'package:bloc/bloc.dart';

abstract class SearchState {}

abstract class SearchEvent {}

final class FullSearch extends SearchEvent {
  final SearchParams params;
  final int rows;

  FullSearch(this.params, {this.rows = 10});
}

final class SwitchSearchPage extends SearchEvent {
  final SearchParams params;
  final int rows;
  final int page;

  SwitchSearchPage(this.params, {this.rows = 10, this.page = 2});
}

final class GetReport extends SearchEvent {
  final String id;

  GetReport(this.id);
}

final class SearchBloc extends Bloc<SearchEvent, GeneralState<SearchState>> {
  SearchBloc() : super(RequestInit()) {
    on<FullSearch>((event, emit) =>
        onEvent<SearchState, FullSearch, SearchResponse>(event, emit,
            (event) async {
          final queryTime = DateTime.now();

          final report =
              await searchReport(event.params, event.rows, 1, queryTime);
          if (report.isLeft) {
            return Left(report.left);
          }

          final level = await searchLevel(event.params, queryTime);
          if (level.isLeft) {
            return Left(level.left);
          }

          final case_ = await searchCase(event.params, queryTime);
          if (case_.isLeft) {
            return Left(case_.left);
          }

          return Right(SearchResponse(report.right, level.right, case_.right));
        }));
    on<SwitchSearchPage>((event, emit) => onEvent(event, emit, (event) async {
          final queryTime = DateTime.now();
          return searchReport(event.params, event.rows, event.page, queryTime);
        }));
    on<GetReport>(
        (event, emit) => onEvent(event, emit, (event) => getReport(event.id)));
  }
}
