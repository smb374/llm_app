import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:llm_app/blocs/blocs.dart';
import 'package:llm_app/blocs/search.dart';
import 'package:llm_app/models.dart';
import 'package:llm_app/utils.dart';

class ResultListPage extends StatefulWidget {
  final SearchParams params;
  const ResultListPage({required this.params, super.key});

  @override
  State<StatefulWidget> createState() => _ResultListPageState();
}

class _ResultListPageState extends State<ResultListPage> {
  bool _inProgress = true;
  SearchResponse? _resp;
  int _currPage = 0;
  int _maxPage = 0;

  @override
  Widget build(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    return BlocListener<SearchBloc, GeneralState<SearchState>>(
      listener: (context, state) {
        if (state is RequestInProgress) {
          setState(() {
            _inProgress = true;
          });
        } else if (state is RequestFailed<SearchState, FullSearch>) {
          setState(() {
            _inProgress = false;
          });
          generalAlert(context, 'Full Search Failed', state.error);
        } else if (state is RequestFailed<SearchState, SwitchSearchPage>) {
          generalAlert(context, 'Switch Page Failed', state.error);
        } else if (state is RequestFailed<SearchState, GetReport>) {
          generalAlert(context, 'Get Report Failed', state.error);
        } else if (state is RequestSuccess<SearchState, SearchResponse>) {
          final resp = state.resp;
          setState(() {
            _inProgress = false;
            _resp = resp;
            _currPage = 1;
            _maxPage =
                resp.reportResponse.total ~/ resp.reportResponse.rows.length;
          });
        } else if (state is RequestSuccess<SearchState, SearchReportResponse>) {
          // Switch Page
          setState(() {
            _inProgress = false;
            _resp = SearchResponse(
                state.resp, _resp!.levelResponse, _resp!.caseResponse);
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search Result'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: _inProgress
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : _resp == null
                        ? const Center(
                            child: Text('No result'),
                          )
                        : ListView(
                            children: _resp!.reportResponse.rows
                                .map((v) => Card(
                                      child: ListTile(
                                        title: Text('${v.caseNum} ${v.issue}'),
                                        subtitle: Text(v.tags
                                            .map((e) => e.substring(3))
                                            .join(' | ')),
                                      ),
                                    ))
                                .toList(),
                          ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () => _currPage == 1
                        ? null
                        : setState(() {
                            searchBloc.add(SwitchSearchPage(widget.params,
                                page: _currPage - 1));
                            _currPage--;
                          }),
                    icon: const Icon(Icons.arrow_left),
                    iconAlignment: IconAlignment.start,
                    label: const Text('Prev'),
                  ),
                ),
                const SizedBox(width: 10.0),
                Text('$_currPage/$_maxPage'),
                const SizedBox(width: 10.0),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () => _currPage == _maxPage
                        ? null
                        : setState(() {
                            searchBloc.add(SwitchSearchPage(widget.params,
                                page: _currPage + 1));
                            _currPage++;
                          }),
                    icon: const Icon(Icons.arrow_right),
                    iconAlignment: IconAlignment.end,
                    label: const Text('Next'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
