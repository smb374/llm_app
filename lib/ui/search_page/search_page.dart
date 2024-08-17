import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:llm_app/blocs/blocs.dart';
import 'package:llm_app/blocs/search.dart';
import 'package:llm_app/models.dart';
import 'package:llm_app/utils.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _inProgress = false;
  final TextEditingController _queryString = TextEditingController();
  DateTime? _dateStart;
  DateTime? _dateEnd;
  final TextEditingController _caseNum1 = TextEditingController();
  final TextEditingController _caseNum2 = TextEditingController();
  final TextEditingController _caseNum3 = TextEditingController();
  final TextEditingController _issue = TextEditingController();
  final TextEditingController _main = TextEditingController();

  _SearchPageState();

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
          setState(() {
            _inProgress = false;
          });
          final result = state.resp;

          generalAlert(context, 'Full Search Success',
              'results: ${result.reportResponse.total}');
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 50.0, right: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _queryString,
              decoration: const InputDecoration(
                labelText: '全文檢索',
                border: OutlineInputBorder(),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      final result = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1970),
                          lastDate: DateTime(2100));
                      setState(() {
                        if (result != null) {
                          _dateStart = result;
                        }
                      });
                    },
                    child: Text(_dateStart == null
                        ? '開始日期'
                        : '${_dateStart!.year}-${_dateStart!.month}-${_dateStart!.day}'),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      final result = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1970),
                          lastDate: DateTime(2100));
                      setState(() {
                        if (result != null) {
                          _dateEnd = result;
                        }
                      });
                    },
                    child: Text(_dateEnd == null
                        ? '結束日期'
                        : '${_dateEnd!.year}-${_dateEnd!.month}-${_dateEnd!.day}'),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _caseNum1,
                    decoration: const InputDecoration(
                      labelText: '年',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: _caseNum2,
                    decoration: const InputDecoration(
                      labelText: '字',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _caseNum3,
                    decoration: const InputDecoration(
                      labelText: '號',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            TextField(
              controller: _issue,
              decoration: const InputDecoration(
                labelText: '案由',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: _main,
              decoration: const InputDecoration(
                labelText: '主文',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final cn = [_caseNum1, _caseNum2, _caseNum3]
                    .map((x) => x.text)
                    .where((x) => x != '')
                    .toList();
                final params = SearchParams(
                  querySentence:
                      _queryString.text != '' ? _queryString.text : null,
                  keyword: _queryString.text != '' ? _queryString.text : null,
                  dateStart: _dateStart != null
                      ? '${_dateStart?.year}-${_dateStart?.month}-${_dateStart?.day}'
                      : null,
                  dateEnd: _dateEnd != null
                      ? '${_dateEnd?.year}-${_dateEnd?.month}-${_dateEnd?.day}'
                      : null,
                  caseNum: cn.isNotEmpty ? cn : null,
                  issue: _issue.text != '' ? _issue.text : null,
                  main: _main.text != '' ? _main.text : null,
                );
                searchBloc.add(FullSearch(params));
              },
              child: _inProgress
                  ? const SizedBox(
                      height: 16.0,
                      width: 16.0,
                      child: CircularProgressIndicator(),
                    )
                  : const Text('Submit'),
            ),
          ].expand((x) => [const SizedBox(height: 10.0), x]).skip(1).toList(),
        ),
      ),
    );
  }
}
