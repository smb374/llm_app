import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:llm_app/blocs/blocs.dart';
import 'package:llm_app/models.dart';
import 'package:llm_app/utils.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:llm_app/ui/webview_page/webview_page.dart';

class ReportPage extends StatefulWidget {
  final String caseNum;
  final String issue;
  final String reportId;
  final String? token;
  const ReportPage(
      {required this.caseNum,
      required this.issue,
      required this.reportId,
      this.token,
      super.key});

  @override
  State<StatefulWidget> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  bool _init = true;
  Widget _child = const Text('Unknown State.');
  Widget _actionButton = Container();

  @override
  Widget build(BuildContext context) {
    if (_init) {
      BlocProvider.of<SearchBloc>(context).add(GetReport(widget.reportId));
      setState(() {
        _init = false;
      });
    }
    return MultiBlocListener(
      listeners: [
        BlocListener<SearchBloc, GeneralState<SearchState>>(
          listener: (context, state) {
            if (state is RequestInProgress) {
              setState(() {
                _child = const CircularProgressIndicator();
              });
            } else if (state is RequestSuccess<SearchState, ReportResponse>) {
              final resp = state.resp;
              if (!resp.success) {
                setState(() {
                  _child = const Text('No Data.');
                });
              } else {
                setState(() {
                  _child = Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                          child: Html(
                              data:
                                  '<div>${resp.response.reportBase.content}</div>',
                              onLinkTap: (url, attributes, element) {
                                if (url != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => WebViewPage(url: url)),
                                  );
                                }
                              },
                              style: {
                            'div': Style(
                              whiteSpace: WhiteSpace.pre,
                            ),
                          })));
                });
                if (widget.token != null) {
                  setState(() {
                    _actionButton = FloatingActionButton(
                        tooltip: 'Create session with this report',
                        child: const Icon(Icons.add),
                        onPressed: () {
                          ReportBase repBase = resp.response.reportBase;
                          BlocProvider.of<SessionBloc>(context).add(
                              SessionCreateWithReport(widget.token!,
                                  '${repBase.caseNum} ${repBase.issue}'));
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content:
                                Text('Creating session for this report...'),
                            duration: Duration(seconds: 2),
                          ));
                        });
                  });
                }
              }
            } else if (state is RequestFailed<SearchState, GetReport>) {
              generalAlert(context, 'Get Report Request Failed', state.error);
              setState(() {
                _child = const Text('No Data.');
              });
            }
          },
        ),
        BlocListener<SessionBloc, GeneralState<SessionState>>(
          listener: (context, state) {
            if (state is RequestSuccess<SessionState, SessionCreateResponse>) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text('Created session "${state.resp.session.caption}"'),
                action: SnackBarAction(label: 'OK', onPressed: () {}),
              ));
            } else if (state
                is RequestFailed<SessionState, SessionCreateWithReport>) {
              generalAlert(
                  context, 'Failed to create session with report', state.error);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.caseNum} ${widget.issue}'),
        ),
        floatingActionButton: _actionButton,
        body: Center(
          child: _child,
        ),
      ),
    );
  }
}
