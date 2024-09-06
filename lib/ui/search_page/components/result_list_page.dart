import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:llm_app/blocs/blocs.dart';
import 'package:llm_app/models.dart';
import 'package:llm_app/ui/report_page/report_page.dart';
import 'package:llm_app/utils.dart';

class ResultListPage extends StatefulWidget {
  final SearchParams params;
  const ResultListPage({required this.params, super.key});

  @override
  State<StatefulWidget> createState() => _ResultListPageState();
}

class _ResultListPageState extends State<ResultListPage> {
  bool _inProgress = true;
  SearchReportResponse? _page;
  // SearchLevelResponse? _level;
  // SearchCaseResponse? _case;
  int _currPage = 0;
  int _maxPage = 0;

  @override
  Widget build(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    return BlocListener<SearchBloc, GeneralState<SearchState>>(
      listener: (context, state) {
        if (state is RequestInProgress<SearchState, FullSearch>) {
          setState(() {
            _inProgress = true;
          });
        } else if (state is RequestInProgress<SearchState, SwitchSearchPage>) {
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
          if (resp.reportResponse.total == 0) {
            Navigator.pop(context, 0xdeadbeef);
          }
          setState(() {
            _inProgress = false;
            _page = resp.reportResponse;
            // _level = resp.levelResponse;
            // _case = resp.caseResponse;
            _currPage = 1;
            _maxPage = resp.reportResponse.rows.isEmpty
                ? 0
                : resp.reportResponse.total ~/ resp.reportResponse.rows.length +
                    1;
          });
        } else if (state is RequestSuccess<SearchState, SearchReportResponse>) {
          // Switch Page
          setState(() {
            _inProgress = false;
            _page = state.resp;
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
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: _inProgress
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : _page == null
                        ? const Center(
                            child: Text('No result'),
                          )
                        : ListView(
                            children: _page!.rows
                                .map((v) => Card(
                                      child: ListTile(
                                        title: Text('${v.caseNum} ${v.issue}'),
                                        subtitle: v.tags == null
                                            ? const Text('No tags')
                                            : Text(v.tags!
                                                .map((e) => e.substring(3))
                                                .join(' | ')),
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => ReportPage(
                                                caseNum: v.caseNum,
                                                issue: v.issue,
                                                reportId: v.identifier),
                                          ),
                                        ).then((v) => setState(
                                            () => _inProgress = false)),
                                      ),
                                    ))
                                .toList(),
                          ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
